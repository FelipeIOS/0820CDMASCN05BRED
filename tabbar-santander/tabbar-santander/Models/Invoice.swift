//
//  Invoice.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 28/10/20.
//

import Foundation

// MARK: - CardList
struct CardList: Codable {
    var cardList: [CardListElement]?
}

// MARK: - CardListElement
struct CardListElement: Codable {
    var cardID: String?
    var invoice: [Invoice]?
}

// MARK: - Invoice
struct Invoice: Codable {
    var id, nome: String?
    var data: String?
    var valor: Double?
    var tipo: Tipo?
}

enum Tipo: String, Codable {
    case e = "E"
    case s = "S"
}

