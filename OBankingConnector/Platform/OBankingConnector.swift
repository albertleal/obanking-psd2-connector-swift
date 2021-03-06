//
//  OBankingConnector.swift
//  OBankingConnector
//
//  Created by Kai Takac on 12.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation

public final class OBankingConnector {

    static var bundle: Bundle {
        if let bundle = Bundle(identifier: "org.cocoapods.OBankingConnector") {
            return bundle
        }

        return Bundle(for: OBankingConnector.self)
    }

    private let configurationParser: ConfigurationParser
    private let deepLinkService: DeepLinkService
    private let externalWebBrowserLauncher: ExternalWebBrowserLauncher
    private let webClient: WebClient
    private let supportedBankServicesProvider: SupportedBankServicesProvider

    public init(configuration: OBankingConnectorConfiguration) {
        self.configurationParser = ConfigurationParser(configuration: configuration)

        // Initialize Dependencies
        self.deepLinkService = DefaultDeepLinkService()
        self.externalWebBrowserLauncher = PlatformDependingExternalWebBrowserLauncher()
        self.webClient = AlamofireWebClient()
        self.supportedBankServicesProvider = ConfigurationEnabledSupportedBankServicesProvider(
            configuration: configuration
        )
    }

    public func makeBankServiceProviderAuthenticationProvider() -> AuthorizationModule {
        let oAuth2AuthorizationRequestProcessor = DefaultOAuth2AuthorizationRequestProcessor(
            externalWebBrowserLauncher: externalWebBrowserLauncher,
            deepLinkProvider: deepLinkService,
            authorizationRequestURLBuilder: DefaultOAuth2AuthorizationRequestURLBuilder(),
            authorizationTokenExtractor: DefaultOAuth2AuthorizationTokenExtractor(),
            accessTokenRequestor: DefaultOAuth2AccessTokenRequestor(webClient: webClient)
        )

        let oAuth2AuthorizationProviderFactory = DefaultOAuth2AuthorizationProviderFactory(
            oAuth2AuthorizationRequestFactory: DefaultOAuth2AuthorizationRequestFactory(),
            oAuth2AuthorizationRequestProcessor: oAuth2AuthorizationRequestProcessor
        )
        let authorizationProcessorFactory = DefaultAuthorizationProviderFactory(
            oAuth2AuthorizationProviderFactory: oAuth2AuthorizationProviderFactory
        )
        let authorizationModule = DefaultAuthorizationModule(
            authorizationProviderFactory: authorizationProcessorFactory,
            configurationParser: configurationParser
        )

        return authorizationModule
    }

    public func makeBankServiceProviderConnector() -> BankServiceProviderConnector {
        return DefaultBankServiceProviderConnector(
            configurationParser: configurationParser,
            webClient: webClient,
            supportedBankServicesProvider: supportedBankServicesProvider
        )
    }

    public func makeDeepLinkHandler() -> DeepLinkHandler {
        return self.deepLinkService
    }

    public func makeSupportedBankServicesProvider() -> SupportedBankServicesProvider {
        return self.supportedBankServicesProvider
    }

    public func makeBankServiceConnectionInformationDecoder() -> BankServiceConnectionInformationDecoder {
        return DefaultBankServiceConnectionInformationDecoder()
    }

    public func makeBankServiceConnectionInformationEncoder() -> BankServiceConnectionInformationEncoder {
        return DefaultBankServiceConnectionInformationEncoder()
    }
}
