//
//  ViewController.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 23/10/20.
//

import UIKit

class CreditCardVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var controller: CreditCardController = CreditCardController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CreditCardContainerCell", bundle: nil), forCellReuseIdentifier: "CreditCardContainerCell")
        
        
        self.controller.loadCreditCard { (result, error) in
            
            if result {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.tableFooterView = UIView()
            }else{
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
        
        cell?.setup(value: self.controller.loadCartoes, delegate: self)
        
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc:InvoiceVC? = segue.destination as? InvoiceVC
        vc?.setup(cardID: sender as? String)
    }
}


extension CreditCardVC: CreditCardContainerCellDelegate {
    
    func tappedCreditCardWith(id: String) {
        
        self.performSegue(withIdentifier: "InvoiceVC", sender: id)
        print("tappedCreditCard=====> \(id)")
    }
    
}
