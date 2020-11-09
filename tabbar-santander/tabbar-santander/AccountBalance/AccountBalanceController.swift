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
    
    func tsste() {
        
        
    }

    func loadLancamentos(completionHandler: (_ result: Bool,  _ error: Error?) -> Void) {
        
        if let path = Bundle.main.path(forResource: "despesas", ofType: "json"){
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let movimentacao = try JSONDecoder().decode(Movimentacao.self, from: data)
                
                print("=======>movimentacao\(movimentacao)")
                
                self.arrayLancamentos =  movimentacao.lancamentos
                
                completionHandler(true, nil)
                
            }catch{
                completionHandler(false, error)
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
