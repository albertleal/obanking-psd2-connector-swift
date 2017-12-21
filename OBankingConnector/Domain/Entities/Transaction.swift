//
//  Transaction.swift
//  OBankingConnector
//
//  Created by Kai Takac on 10.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation

public struct Transaction {

    public let id: String
    public let bankAccountNumberId: String
    public let partyAccount: AccountNumber
    public let amount: Amount
    public let text: String
    public let bookingDate: Date
    public let processingDate: Date?
    public let textType: TransactionTextType
    public let notes: String?
    public let exchangeRateInformation: ExchangeRateInformation?

    init(id: String,
         bankAccountNumberId: String,
         partyAccount: AccountNumber,
         amount: Amount,
         text: String,
         bookingDate: Date,
         processingDate: Date? = nil,
         textType: TransactionTextType = .unknown,
         notes: String? = nil,
         exchangeRateInformation: ExchangeRateInformation? = nil) {
        self.id = id
        self.bankAccountNumberId = bankAccountNumberId
        self.partyAccount = partyAccount
        self.amount = amount
        self.text = text
        self.bookingDate = bookingDate
        self.processingDate = processingDate
        self.textType = textType
        self.notes = notes
        self.exchangeRateInformation = exchangeRateInformation
    }
}