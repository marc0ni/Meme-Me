//
//  MemeTextFieldDelegate.swift
//  Meme Me
//
//  Created by Mark Lindamood on 3/20/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let TOP_DEFAULT_TEXT = "TOP"
    let BOTTOM_DEFAULT_TEXT = "BOTTOM"
    
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    var oldText: String = ""
    
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    func textFieldDidBeginEditing(textField: UITextField) {
        oldText = textField.text!
        textField.text = ""
    }
    
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = oldText
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}
