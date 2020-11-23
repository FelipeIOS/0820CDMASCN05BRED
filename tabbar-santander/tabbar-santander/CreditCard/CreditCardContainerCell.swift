//
//  CreditCardContainerCell.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 26/10/20.
//

import UIKit

protocol CreditCardContainerCellDelegate: class {
    
    func tappedCreditCardWith(id: String)
    func tappedAddCredCardButton()
}

class CreditCardContainerCell: UITableViewCell {
   
    weak var delegate: CreditCardContainerCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var cartoes: Cartoes?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(value: Cartoes?, delegate: CreditCardContainerCellDelegate?, isReload: Bool = false) {
        
        self.collectionView.register(UINib(nibName: "CreditCardCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CreditCardCollectionCell")
       
        self.collectionView.register(UINib(nibName: "ButtonCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ButtonCollectionCell")
        
        self.cartoes = value
        self.delegate = delegate
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if isReload {
            self.collectionView.reloadData()
        }
    }
}

extension CreditCardContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = self.cartoes?.cartoes.count ?? 0
        return count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CreditCardCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCardCollectionCell", for: indexPath) as? CreditCardCollectionCell
        if indexPath.row < cartoes?.cartoes.count ?? 0 {
            cell?.setup(value: cartoes?.cartoes[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
        else {
            
            let cell: ButtonCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionCell", for: indexPath) as? ButtonCollectionCell
            
            cell?.setup(delegate: self)
            
            return cell ?? UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < cartoes?.cartoes.count ?? 0 {
            self.delegate?.tappedCreditCardWith(id: cartoes?.cartoes[indexPath.row].id ?? "")
        }
    }
}

extension CreditCardContainerCell: ButtonCollectionCellDelegate {
    func tappedButton() {
        print("CreditCardContainerCell===>ButtonCollectionCellDelegate===>tappedButton")
        self.delegate?.tappedAddCredCardButton()
    }
}
