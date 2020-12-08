//
//  CreditCardController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 06/11/20.
//

import Foundation

class CreditCardController {
    
    private var cartoes: Cartoes?
    
    private var isReloadCollection: Bool = false
    
    func loadCreditCard(completionHandler: @escaping (_ result: Bool, _ error: String?) -> Void)  {
        
        CartoesWorker().getCartoes { (success, error) in
        
            if let _success = success {
                
                self.cartoes = _success
                completionHandler(true, nil)
            }else{
                completionHandler(false,"")
            }
        }
    }
    
    var loadCartoes: Cartoes? {
        return self.cartoes
    }
    
    func appendCreditCard(value: CartoesElement?) {
        if let _value = value {
            self.cartoes?.cartoes.append(_value)
            
            print(self.cartoes?.cartoes.count)
            self.isReloadCollection = true
        }
    }
    
    var numberOfRows: Int {
        return 1
    }
    
    var reloadCreditCards: Bool {
        return self.isReloadCollection
    }
}
