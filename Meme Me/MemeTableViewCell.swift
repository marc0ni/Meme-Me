//
//  MemeTableViewCell.swift
//  Meme Me
//
//  Created by Mark Lindamood on 5/10/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var meme:Meme! {
        didSet {
            topLabel.text = meme.topTextField
            bottomLabel.text = meme.bottomTextField
            imagePickerView.image = meme.pickerViewImage
        }
    }
}
