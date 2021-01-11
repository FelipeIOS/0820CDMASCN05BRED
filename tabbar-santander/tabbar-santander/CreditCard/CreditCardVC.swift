//
//  ViewController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 23/10/20.
//

import UIKit

class CreditCardVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var controller: CreditCardController = CreditCardController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CreditCardContainerCell", bundle: nil), forCellReuseIdentifier: "CreditCardContainerCell")
        
        self.showLoading()
        self.controller.loadCreditCard { (result, error) in
            
            if result {
                
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.tableFooterView = UIView()
                    self.tableView.reloadData()
                    self.hiddenLoading()
                }
     
            }else{
                DispatchQueue.main.async {
//                    self.showError(error: error ?? "", preferredStyle: .alert)
                    self.hiddenLoading()
                }
                print("deu error: \(error)")
            }
        }
        
        
        print("CreditCardVC----viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tappedPerfilButton(_ sender: UIBarButtonItem) {
        
        print("tappedPerfilButton")
    }
}


extension CreditCardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CreditCardContainerCell? = tableView.dequeueReusableCell(withIdentifier: "CreditCardContainerCell", for: indexPath) as? CreditCardContainerCell
        
        cell?.setup(value: self.controller.loadCartoes, delegate: self, isReload: self.controller.reloadCreditCards)
        
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "InvoiceVC" {
            let vc:InvoiceVC? = segue.destination as? InvoiceVC
            vc?.setup(cardID: sender as? String)
        
        }else if segue.identifier == "AddCreditCardVC" {
            let vc: AddCreditCardVC? =  segue.destination as? AddCreditCardVC
            vc?.delegate = self
        }
    }
}


extension CreditCardVC: AddCreditCardVCDelegte {
   
    func success(value: CartoesElement?) {
        print(value?.nome)
        
        self.controller.appendCreditCard(value: value)
        self.tableView.reloadData()
    }
}


extension CreditCardVC: CreditCardContainerCellDelegate {
   
    func tappedAddCredCardButton() {
        
        self.performSegue(withIdentifier: "AddCreditCardVC", sender: nil)
        print("CreditCardVC===>CreditCardContainerCellDelegate===>tappedAddCredCardButton")
        
    }
    
    func tappedCreditCardWith(id: String) {
        
        self.performSegue(withIdentifier: "InvoiceVC", sender: id)
        print("tappedCreditCard=====> \(id)")
    }
    
}
