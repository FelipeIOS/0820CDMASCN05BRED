//
//  CreditCardCollectionCell.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 26/10/20.
//

import UIKit

class CreditCardCollectionCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var cardBackgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(value: CartoesElement?) {
        
        if let _value = value {
            
            self.nameLabel.text = _value.nome
            self.numberLabel.text = _value.numero
            self.dateLabel.text = _value.data
            self.flagImageView.image = UIImage(named: _value.bandeira)
            
            self.cardBackgroundImageView.image = UIImage(named: "fundo-visa")
            self.cardBackgroundImageView.layer.cornerRadius = 4
            
            self.containerView.layer.cornerRadius = 4
            if _value.bandeira == Flag.mastercard.rawValue {
                self.containerView.backgroundColor = .black
                self.nameLabel.textColor = .lightGray
                self.numberLabel.textColor = .lightGray
                self.dateLabel.textColor = .lightGray
                self.lineView.backgroundColor = .lightGray
                self.cardBackgroundImageView.image = UIImage(named: "fundo-master")
                
            }
        }
        
    }

}
