//
//  Meme.swift
//  Meme Me
//
//  Created by Mark Lindamood on 4/23/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import Foundation
import UIKit 

struct Meme {
    var topTextField: String!
    var bottomTextField:String!
    var pickerViewImage: UIImage!
    var memedImage: UIImage!
    
    init(topTextField:String, bottomTextField:String,
        pickerViewImage: UIImage, memedImage: UIImage){
            self.topTextField = topTextField
            self.bottomTextField = bottomTextField
            self.pickerViewImage = pickerViewImage
            self.memedImage = memedImage
    }
    
    static var allMemes: [Meme] = [Meme]()
}


