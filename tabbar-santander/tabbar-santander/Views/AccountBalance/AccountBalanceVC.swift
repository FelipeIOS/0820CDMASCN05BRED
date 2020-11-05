//
//  SecondVC.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 23/10/20.
//

import UIKit

class AccountBalanceController {
    
    private var arrayLancamentos:[LancamentoElement] = []
    private var currentLancamentoElement: LancamentoElement?
    
    func loadCurrentLancamentoElement(index: Int) {
        self.currentLancamentoElement = arrayLancamentos[index]
    }
    
    func loadLancamentos() {
        
        if let path = Bundle.main.path(forResource: "despesas", ofType: "json"){
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let movimentacao = try JSONDecoder().decode(Movimentacao.self, from: data)
                
                print("=======>movimentacao\(movimentacao)")
                
                self.arrayLancamentos =  movimentacao.lancamentos
                
            }catch{
                print("Deu ruim no parse")
            }
        }
    }
    
    var lancamentoElement: LancamentoElement?{
        return self.currentLancamentoElement
    }
    
    var numberOfRows: Int {
        return self.arrayLancamentos.count
    }
}

class AccountBalanceVC: UIViewController {
    
    @IBOutlet weak var timeLineTableView: UITableView!

    private var controller: AccountBalanceController = AccountBalanceController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AccountBalanceVC----viewDidLoad")
        // Do any additional setup after loading the view.
    
        
        self.timeLineTableView.register(UINib(nibName: "ExtratoCell", bundle: nil), forCellReuseIdentifier: "ExtratoCell")
        
        self.controller.loadLancamentos()
        
        self.timeLineTableView.delegate = self
        self.timeLineTableView.dataSource = self
        self.timeLineTableView.separatorStyle = .none
        
    }
}

extension AccountBalanceVC: UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.controller.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ExtratoCell? = tableView.dequeueReusableCell(withIdentifier: "ExtratoCell", for: indexPath) as? ExtratoCell
        
        self.controller.loadCurrentLancamentoElement(index: indexPath.row)
        
        cell?.setup(value:self.controller.lancamentoElement)
        return cell ?? UITableViewCell()
    }
    
}
