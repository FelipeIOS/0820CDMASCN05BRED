//
//  InvoiceVC.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 28/10/20.
//

import UIKit

class InvoiceVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var cardList: CardList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardList = self.loadCardList()
        
        if self.cardList != nil {
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    private func loadCardList() -> CardList? {
        
        
        if let path = Bundle.main.path(forResource: "invoice", ofType: "json"){
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let cardList = try JSONDecoder().decode(CardList.self, from: data)
                
                print("=======>cardList\(cardList)")
                
                return cardList
                
            }catch{
                print("Deu ruim no parse")
                return nil
            }

        }
        
        return nil
    }
}


extension InvoiceVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return UITableViewCell()
    
    }
    
}
