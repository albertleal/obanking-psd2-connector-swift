//
//  Amount.swift
//  OBankingConnector
//
//  Created by Kai Takac on 10.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation

public struct Amount: Codable {

    public let value: Int
    public let precision: Int
    public let currency: Currency

    public init(value: Int, precision: Int, currency: Currency) {
        self.value = value
        self.precision = precision
        self.currency = currency
    }

    public func toDecimal() -> Decimal {
        return Decimal(value) / pow(10, precision)
    }
}

extension Amount: Equatable {
    public static func == (lhs: Amount, rhs: Amount) -> Bool {
        return lhs.value == rhs.value &&
            lhs.precision == rhs.precision &&
            lhs.currency == rhs.currency
    }
}
