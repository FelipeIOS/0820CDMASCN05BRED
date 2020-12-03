//
//  InvoiceController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 09/11/20.
//

import Foundation

class InvoiceController {
    
    private var cardListElement: CardListElement?
    
    private var cardID: String?
    
    private var  worker: InvoiceWorker?
    
    init(cardID: String?) {
        
        self.cardID = cardID
        self.cardListElement = CardListElement()
        self.worker = InvoiceWorker()
    }

    func loadCardListElement( completionHandler: @escaping (_ result: Bool, _ error: String?) -> Void) {
    
        self.worker?.getInvoice(cardID: self.cardID ?? "") { (cardListElement, error) in
            
            if let _cardListElement = cardListElement {
                print(_cardListElement.cardID)
                
                self.cardListElement = _cardListElement
                completionHandler(true, nil)
            }else{
                
                completionHandler(false, error)
            }
        }

    }
    
    var numberOfRows: Int {
        return self.cardListElement?.invoice?.count ?? 0
    }
    
    func loadCurrentInvoice(indexPath: Int) -> Invoice? {
        return self.cardListElement?.invoice?[indexPath]
    }
}
