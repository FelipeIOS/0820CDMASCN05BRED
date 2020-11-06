//
//  AccountBalanceController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 04/11/20.
//

import Foundation

class AccountBalanceController {
    
    private var arrayLancamentos:[LancamentoElement] = []
    private var currentLancamentoElement: LancamentoElement?
    
    func loadCurrentLancamentoElement(index: Int) {
        self.currentLancamentoElement = arrayLancamentos[index]
    }
    
    func loadLancamentos() {
        
        if let path = Bundle.main.path(forResource: "despesas", ofType: "json"){
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let movimentacao = try JSONDecoder().decode(Movimentacao.self, from: data)
                
                print("=======>movimentacao\(movimentacao)")
                
                self.arrayLancamentos =  movimentacao.lancamentos
                
            }catch{
                print("Deu ruim no parse")
            }
        }
    }
    
    
    var lancamentoElement: LancamentoElement?{
        return self.currentLancamentoElement
    }
    
    var numberOfRows: Int {
        return self.arrayLancamentos.count
    }
}
