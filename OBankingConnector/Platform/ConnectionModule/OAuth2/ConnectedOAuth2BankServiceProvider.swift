//
//  ConnectedOAuth2BankServiceProvider.swift
//  OBankingConnector
//
//  Created by Kai Takac on 16.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation
import RxSwift

final class ConnectedOAuth2BankServiceProvider: ConnectedBankServiceProvider {

    private let oAuth2ConnectionInformation: OAuth2BankServiceConnectionInformation
    private let configurationParser: ConfigurationParser
    private let webClient: WebClient
    private let supportedBankServicesProvider: SupportedBankServicesProvider

    init(
        oAuth2ConnectionInformation: OAuth2BankServiceConnectionInformation,
        configurationParser: ConfigurationParser,
        webClient: WebClient,
        supportedBankServicesProvider: SupportedBankServicesProvider
    ) {
        self.oAuth2ConnectionInformation = oAuth2ConnectionInformation
        self.configurationParser = configurationParser
        self.webClient = OAuth2AuthorizedWebClient(
            oAuth2ConnectionInformation: oAuth2ConnectionInformation,
            webClient: webClient
        )
        self.supportedBankServicesProvider = supportedBankServicesProvider
    }

    func perform<T: BankingRequest>(_ request: T) -> Single<T.Result> {

        guard let configuration = getConfiguration() else {
            return Single.error(ConnectedBankServiceProviderError.unsupportedRequest)
        }

        guard let processor = configuration.bankingRequestTranslator.makeProcessor(for: request) else {
            return Single.error(ConnectedBankServiceProviderError.unsupportedRequest)
        }

        let oAuth2AuthorizedWebClient = OAuth2AuthorizedWebClient(
            oAuth2ConnectionInformation: oAuth2ConnectionInformation,
            webClient: webClient
        )

        return processor.perform(request: request, using: oAuth2AuthorizedWebClient)
    }

}

private extension ConnectedOAuth2BankServiceProvider {

    func getConfiguration() -> OAuth2BankServiceConfiguration? {
        guard let bankServiceProvider = supportedBankServicesProvider.bankService(
            for: oAuth2ConnectionInformation.bankServiceProviderId
        ) else {
            return nil
        }

        return configurationParser.getBankServiceConfiguration(for: bankServiceProvider)
            as? OAuth2BankServiceConfiguration
    }
}
