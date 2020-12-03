//
//  InvoiceWorker.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 02/12/20.
//

import Foundation


class InvoiceWorker {
    
    typealias completion <T> = (_ result: T, _ failure: String?) -> Void
    
    func getInvoice(cardID: String, completion: @escaping completion<CardListElement?>) {
        
        let session: URLSession = URLSession.shared
        
        let url: URL? = URL(string: "http://www.amock.io/api/v2/invoice")
        
        if let _url = url {
            
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
        
                do {
                    let cardList = try JSONDecoder().decode(CardList.self, from: data ?? Data())
                    
                    if let _cardList = cardList.cardList {
                    
                        let cardLisElement = _cardList.filter({$0.cardID == cardID })
                        
                        completion(cardLisElement.first, nil)
                    }else{
                        completion(nil, "Deu ruim")
                    }
                    
                }catch {
                    completion(nil,"deu ruim no catch")
                    print(error)
                }
            }
            
            task.resume()
        }
    }
    
    
    func getInvoice(completion: @escaping completion<CardList?>) {
        
        let session: URLSession = URLSession.shared
        
        let url: URL? = URL(string: "http://www.amock.io/api/v2/invoice")
        
        if let _url = url {
            
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
        
                do {
                    let cardList = try JSONDecoder().decode(CardList.self, from: data ?? Data())
                    
                    completion(cardList, nil)
                    
                }catch {
                    completion(nil,"deu ruim no catch")
                    print(error)
                }
            }
            
            task.resume()
        }
    }
    
    
    func getInvoiceMock(cardID: String, completion: @escaping completion<CardListElement?>) {
        
        if let path = Bundle.main.path(forResource: "invoice", ofType: "json"){

            do {

                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                let cardList = try JSONDecoder().decode(CardList.self, from: data)

                print("=======>cardList\(cardList)")

                let list = cardList.cardList?.filter({$0.cardID == cardID})

                let cardListElement = list?.first

                completion(cardListElement, nil)
            }catch{
                print("Deu ruim no parse")
                completion(nil, "deu ruim")
            }

        }
    }

}
