//
//  PhotoTableViewCell.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var autherNameLabel: UILabel!
    

    static var reuseIdentifier: String {
        return String.init(describing: self)
    }

    static var nib: UINib {
        return UINib.init(nibName: String.init(describing: self), bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setupUiWithData(photoItem: Photo) {
        autherNameLabel.text = photoItem.author
        if let url = URL(string: photoItem.downloadURL) {
            photoImageView.kf.setImage(with: url)
        }
    }
}
