//
//  InvoiceWorker.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 02/12/20.
//

import Foundation
import Alamofire


class InvoiceWorker: GenericWorker {
    
    func getInvoice(cardID: String, completion: @escaping completion<CardListElement?>) {
        
        
        let url: URL? = URL(string: "https://gist.githubusercontent.com/ooredroxoo/a474fc39a8c3c209daf29b95dd1fad3b/raw/2644152eed972bd1e8f347e487744d5538a4ddf2/invoices.json")
        
        if let _url = url {
            
            var urlRequest = URLRequest(url: _url)
            urlRequest.httpMethod = Method.get.rawValue
            
            AF.request(urlRequest).responseJSON { (response) in
                
                print(response.response)
                
                if response.response?.statusCode == 200 {
                    
                    do {
                        let cardList = try JSONDecoder().decode(CardList.self, from: response.data ?? Data())
                        
                        if let _cardList = cardList.cardList {
                            
                            let cardLisElement = _cardList.filter({$0.cardID == cardID })
                            
                            completion(cardLisElement.first, nil)
                        }else{
                            completion(nil, ErrorHandler(title: "Error", description: response.error?.errorDescription, code: response.error?.responseCode))
                        }
                        
                    }catch {
                        
                        completion(nil, ErrorHandler(title: "Error", description: error.localizedDescription,code:nil))
                        print(error)
                    }
                    
                }else{
                    completion(nil, ErrorHandler(title: "Error", description: response.error?.errorDescription, code: response.error?.responseCode))
                }
            }
            
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
                    completion(nil, ErrorHandler(title: "Error", description: error.localizedDescription,code:nil))
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
                completion(nil, ErrorHandler(title: "Error", description: error.localizedDescription,code:nil))
            }
            
        }
    }
    
}
