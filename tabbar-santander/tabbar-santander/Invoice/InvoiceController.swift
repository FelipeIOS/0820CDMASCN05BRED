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
    
    init(cardListElement:CardListElement? = nil, cardID: String?) {
        
        self.cardID = cardID
        self.cardListElement = cardListElement
    }

    func loadCardListElement( completionHandler: (_ result: Bool, _ error: Error?) -> Void) {
        
        if let path = Bundle.main.path(forResource: "invoice", ofType: "json"){
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let cardList = try JSONDecoder().decode(CardList.self, from: data)
                
                print("=======>cardList\(cardList)")
                
                let list = cardList.cardList?.filter({$0.cardID == self.cardID ?? ""})
                
                self.cardListElement = list?.first
                
                completionHandler(true, nil)
            }catch{
                print("Deu ruim no parse")
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
