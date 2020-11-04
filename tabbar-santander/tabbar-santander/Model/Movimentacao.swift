//
//  Movimentacao.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 23/10/20.
//

import Foundation

struct Movimentacao: Codable {
    
    let lancamentos:[LancamentoElement]
    
}

struct LancamentoElement: Codable {
    
    let id, nome, data, tipo: String
    let valor: Double
}
