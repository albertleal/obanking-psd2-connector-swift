//
//  BankServiceProviderAuthenticationProviderError.swift
//  OBankingConnector
//
//  Created by Kai Takac on 12.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation

public enum BankServiceProviderAuthenticationProviderError: Error {
    case unsupportedBankServiceProvider
    case noProperProcessorFound
}
