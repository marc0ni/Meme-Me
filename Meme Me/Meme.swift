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
    
    static let TopTextKey = "TopText"
    static let BottomTextKey = "BottomText"
    static let PickerImageKey = "PickerKey"
    static let MemedImageKey = "MemedKey"
    
    // Generate a Meme from a four entry dictionary
    init(dictionary: [String : AnyObject]) {
        self.topTextField = dictionary[Meme.TopTextKey] as! String
        self.bottomTextField = dictionary[Meme.BottomTextKey] as! String
        self.pickerViewImage = dictionary[Meme.PickerImageKey] as! UIImage
        self.memedImage = dictionary[Meme.MemedImageKey] as! UIImage
    }
}

// This extension adds static variable allMemes, an array of Meme objects

extension Meme {
    static var allMemes: [Meme] {
        
        var memeArray = [Meme]()
        
        for d in Meme.memeData() {
            memeArray.append(Meme(dictionary: d))
        }
        return memeArray
    }
    
    static func memeData() -> [[String : AnyObject]] {
        return [["TopTextKey":TopTextKey, "BottomTextKey":BottomTextKey, "PickerImageKey":PickerImageKey, "MemedImageKey":MemedImageKey]]
    }
}


