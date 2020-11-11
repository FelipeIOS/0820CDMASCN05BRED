//
//  AddButtonCollectionCell.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 09/11/20.
//

import UIKit

protocol ButtonCollectionCellDelegate: class {
    
    func tappedButton()
}

class ButtonCollectionCell: UICollectionViewCell {

    private weak var delegate:ButtonCollectionCellDelegate?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageButton: UIImageView!
    @IBOutlet weak var backgroundViewButton: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var imageCenter: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(delegate:ButtonCollectionCellDelegate?) {
        self.delegate = delegate
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        self.delegate?.tappedButton()
    }
    
}
