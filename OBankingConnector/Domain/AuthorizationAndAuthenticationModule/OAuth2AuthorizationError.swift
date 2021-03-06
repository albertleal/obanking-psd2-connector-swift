//
//  BankServiceProviderAuthenticationRequestProcessorError.swift
//  OBankingConnector
//
//  Created by Kai Takac on 12.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation

enum OAuth2AuthorizationError: Error {
    case unsupportedRequest
    case invalidAuthorizationURL
    case invalidAuthorizationToken
}
