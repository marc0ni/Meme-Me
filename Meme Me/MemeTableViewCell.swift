//
//  MemeTableViewCell.swift
//  Meme Me
//
//  Created by Mark Lindamood on 5/10/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var memedImage: UIImageView!
       
    var meme:Meme! {
        didSet {
            memedImage.image = meme.memedImage
            topLabel.text = meme.topTextField
            bottomLabel.text = meme.bottomTextField
        }
    }
}
