//
//  Cartoes.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 26/10/20.
//

import Foundation

struct Cartoes: Codable {
    
    let cartoes:[CartoesElement]
}

struct CartoesElement: Codable {
    
    let id, nome, data, numero, bandeira: String
}
