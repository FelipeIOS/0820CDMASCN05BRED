//
//  InvoiceVC.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 28/10/20.
//

import UIKit

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

class InvoiceVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var controller: InvoiceController?
    
    func setup(cardID: String?){
        self.controller = InvoiceController(cardID: cardID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ExtratoCell", bundle: nil), forCellReuseIdentifier: "ExtratoCell")
        
        self.controller?.loadCardListElement(completionHandler: { (result, error) in
            
            if result {
                self.tableView.delegate = self
                self.tableView.dataSource = self
            }else{
                print("deu error: \(error)")
            }
        })
        
    }
}

extension InvoiceVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell: ExtratoCell? =  tableView.dequeueReusableCell(withIdentifier: "ExtratoCell", for: indexPath) as? ExtratoCell

        cell?.setup(value: self.controller?.loadCurrentInvoice(indexPath: indexPath.row))
    
        return cell ?? UITableViewCell()
    
    }
    
}
