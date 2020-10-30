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


//{"lancamentos": [{
//    "id": "12034",
//    "nome": "loja de pao",
//    "data": "23/10",
//    "valor": 10.50,
//    "tipo": "E"
//},

struct LancamentoElement: Codable {
    
    let id, nome, data, tipo: String
    let valor: Double
}
