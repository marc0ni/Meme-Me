//
//  ViewController.swift
//  Meme Me
//
//  Created by Mark Lindamood on 3/19/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // MARK: - Constants
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    let TOP_DEFAULT_TEXT = "TOP"
    let BOTTOM_DEFAULT_TEXT = "BOTTOM"
    
    var oldText: String = ""
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Modified from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
        setUpTextField(topTextField)
        setUpTextField(bottomTextField)
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    ////// TextField Functions
    let memeTextDelegate = MemeTextFieldDelegate()
    
    //Modified from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    func setUpTextField(textField: UITextField) {
        
        textField.defaultTextAttributes = memeTextAttributes
        
        textField.textAlignment = .Center
        
        textField.delegate = self
    }
    
    
    ///// ImagePicker Functions
    /*enum Sources {
        case PhotoLibrary
        case Camera
    }*/
    
    func resetText() {
        topTextField.text = TOP_DEFAULT_TEXT
        bottomTextField.text = BOTTOM_DEFAULT_TEXT
    }
    
    @IBAction func cancelImagePicker(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    func pickImageFromSource(source:UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion:nil)
    }
    
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        pickImageFromSource(UIImagePickerControllerSourceType.Camera)
    }
    
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        pickImageFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .ScaleToFill
            dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


