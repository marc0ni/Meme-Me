//
//  MemeCollectionViewCell.swift
//  Meme Me
//
//  Created by Mark Lindamood on 5/10/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var memedImage: UIImageView!
    
    var meme:Meme! {
        didSet {
            memedImage.image = meme.memedImage
        }
    }
}
