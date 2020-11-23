//
//  AddCreditCardController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 20/11/20.
//

import Foundation

class AddCreditCardController {
    
    private var creditCard: CartoesElement?
    
    func saveCreditCard(name: String?, date: String?, number: String?, flag: Flag) {
    
        let card: CartoesElement? = CartoesElement(id: String(Int.random(in: 1...1000)), nome: name ?? "", data: date ?? "", numero: number ?? "", bandeira: flag.rawValue)
        
        self.creditCard = card
    }
    
    
    func saveCreditCard(name: String?, date: String?, number: String?, flag: Int) {
    
        let card: CartoesElement? = CartoesElement(id: String(Int.random(in: 1...1000)), nome: name ?? "", data: date ?? "", numero: number ?? "", bandeira: Flag.loadFlag(index: flag).rawValue)
        
      
        self.creditCard = card
    }
    
    
    var creditCardSaved:CartoesElement? {
    
        return self.creditCard
    }

}
