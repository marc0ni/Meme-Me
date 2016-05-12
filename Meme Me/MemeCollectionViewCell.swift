//
//  MemeCollectionViewCell.swift
//  Meme Me
//
//  Created by Mark Lindamood on 5/10/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pickerImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    
    var meme:Meme! {
        didSet {
            topLabel.text = meme.topTextField
            pickerImageView.image = meme.pickerViewImage
        }
    }
}
