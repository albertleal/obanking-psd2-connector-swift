//
//  OAuth2AuthorizationRequestURLBuilder.swift
//  OBankingConnector-iOS
//
//  Created by Kai Takac on 13.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation

protocol OAuth2AuthorizationRequestURLBuilder {

    func makeAuthorizationCodeRequestURL(
        for request: OAuth2AuthorizationRequest,
        adding state: UUID?
    ) -> URL?
}

final class DefaultOAuth2AuthorizationRequestURLBuilder: OAuth2AuthorizationRequestURLBuilder {
    func makeAuthorizationCodeRequestURL(
        for request: OAuth2AuthorizationRequest,
        adding state: UUID?
    ) -> URL? {
        let urlBuilder = URLBuilder(from: request.authorizationEndpointURL)

        urlBuilder.append(queryParameter: ("response_type", "code"))
        urlBuilder.append(queryParameter: ("client_id", request.clientId))

        if let redirectUri = request.redirectURI {
            urlBuilder.append(queryParameter: ("redirect_uri", redirectUri))
        }

        if let scope = request.scope {
            urlBuilder.append(queryParameter: ("scope", scope))
        }

        if let state = state {
            urlBuilder.append(queryParameter: ("state", state.uuidString))
        }

        if let additionalParameters = request.additionalAuthorizationRequestParameters {
            additionalParameters.forEach {
                urlBuilder.append(queryParameter: ($0.key, $0.value))
            }
        }

        return urlBuilder.build()
    }
}
