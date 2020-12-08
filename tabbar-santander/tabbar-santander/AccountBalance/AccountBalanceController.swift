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
    private var worker: DespesasWorker = DespesasWorker()
    
    func loadCurrentLancamentoElement(index: Int) {
        self.currentLancamentoElement = arrayLancamentos[index]
    }
    
    func tsste() {
        
        
    }

    func loadLancamentos( completionHandler: @escaping (_ result: Bool, _ error: String?) -> Void) {

        self.worker.getLancamentos { (success, error) in
        
            if let _success = success {
                
                self.arrayLancamentos = _success
                completionHandler(true,nil)
            }else{
                completionHandler(false,"")
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
