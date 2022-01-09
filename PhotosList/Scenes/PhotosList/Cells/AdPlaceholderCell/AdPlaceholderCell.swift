//
//  AdPlaceholderCell.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import UIKit

class AdPlaceholderCell: UITableViewCell {
    
    @IBOutlet weak var adPlaceholderImage: UIImageView!
    
    static var reuseIdentifier: String {
        return String.init(describing: self)
    }

    static var nib: UINib {
        return UINib.init(nibName: String.init(describing: self), bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        adPlaceholderImage.image = UIImage(named: "AdPlaceHolder")
    }
    
}
