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
    
    var topTextField:UITextField!
    var bottomTextField:UITextField!
    //var selectedFont:Int = 0
    
    // Modified from http://stackoverflow.com/questions/30025481/take-data-from-enum-to-show-on-uipickerview-swift
    enum Fonts: Int {
        case AINileBold = 0
        case AmTypeCndBld = 1
        case AvenirNxtCndBld = 2
        case Bauhaus = 3
        case Cambria = 4
        case DINCndBld = 5
        case FuturaCndMed = 6
        case HelveticaNeueCndBlk = 7
        case OptimaBold = 8
        static var count: Int {return Fonts.OptimaBold.hashValue + 1}
        
        var description: String {
            switch self {
            case .AINileBold: return "AINile-Bold"
            case .AmTypeCndBld   : return "AmericanTypewriter-CondensedBold"
            case .AvenirNxtCndBld  : return "AvenirNextCondensed-Bold"
            case .Bauhaus : return "Bauhaus"
            case .Cambria : return "Cambria"
            case .DINCndBld : return "DINCondensedBold"
            case .FuturaCndMed : return "Futura-CondensedMedium"
            case .HelveticaNeueCndBlk : return "HelveticaNeue-CondensedBlack"
            case .OptimaBold : return "Optima-Bold"
            }
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Fonts.count.hashValue
    }
    
    func pickerView(pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int) -> String? {
        return Fonts(rawValue: row)?.description
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch (row) {
        case 0: "AINile-Bold";
        break;
        case 1: "AmericanTypewriter-CondensedBold";
        break;
        case 2: "AvenirNextCondensed-Bold";
        break;
        case 3: "Bauhaus";
        break;
        case 4: "Cambria";
        break;
        case 5: "DINCondensedBold";
        break;
        case 5: "Futura-CondensedMedium";
        break;
        case 6: "HelveticaNeue-CondensedBlack";
        break;
        case 7: "Optima-Bold";
        break;
        default: break;
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}



