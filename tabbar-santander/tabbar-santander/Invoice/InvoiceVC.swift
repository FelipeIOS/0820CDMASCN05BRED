//
//  InvoiceVC.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 28/10/20.
//

import UIKit

class InvoiceVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var controller: InvoiceController?
    
    func setup(cardID: String?){
        self.controller = InvoiceController(cardID: cardID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ExtratoCell", bundle: nil), forCellReuseIdentifier: "ExtratoCell")
        
        self.showLoading()
        
        self.controller?.loadCardListElement(completionHandler: { (result, error) in

            if result {
                
                DispatchQueue.main.async {
                    
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    self.hiddenLoading()
                }
                
            }else{
                
                DispatchQueue.main.async {
                    print("deu error: \(error)")
                    
                    self.showError(error: error, preferredStyle: .alert)
                    self.hiddenLoading()
                }
               
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
