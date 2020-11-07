//
//  CreditCardController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 06/11/20.
//

import Foundation

class CreditCardController {
    
    private var cartoes: Cartoes?
    
    func loadCreditCard(completionHandler: (_ result: Bool,  _ error: Error?) -> Void) {
        
        if let path = Bundle.main.path(forResource: "cartoes", ofType: "json"){
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let cartoes = try JSONDecoder().decode(Cartoes.self, from: data)
                
                print("=======>cartoes\(cartoes)")
                self.cartoes = cartoes
                completionHandler(true, nil)
                
            }catch{
                print("Deu ruim no parse")
                completionHandler(false, error)
            }
        }
    }
    
    var loadCartoes: Cartoes? {
        return self.cartoes
    }
    
    var numberOfRows: Int {
        return 1
    }
    
}
