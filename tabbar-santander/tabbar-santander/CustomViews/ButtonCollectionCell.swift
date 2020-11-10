//
//  AddButtonCollectionCell.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 09/11/20.
//

import UIKit

class ButtonCollectionCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageButton: UIImageView!
    @IBOutlet weak var backgroundViewButton: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var imageCenter: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
   
    }
    
}
