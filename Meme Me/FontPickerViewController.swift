//
//  FontPickerViewController.swift
//  Meme Me
//
//  Created by Mark Lindamood on 4/13/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit
import Foundation

class FontPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
    
    let pickerDataSource = [
        ["AINile-Bold", "AmericanTypewriter-CondensedBold", "AvenirNextCondensed-Bold", "Bauhaus",  "Cambria", "DINCondensed-Bold", "Futura-CondensedMedium ", "HelveticaNeue-CondensedBlack", "Optima-Bold"]
    ]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count
    }
    
    func pickerView(pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
    }
    
    @IBAction func saveFont(sender: UIBarButtonItem) {
        topTextField.addAttribute(NSFontAttributeName, value: UIFont(name: pickerDataSource.component.row, size: 40.0))!
        bottomTextField.addAttribute(NSFontAttributeName, value: UIFont(name: pickerDataSource.component.row, size: 40.0))!
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}



