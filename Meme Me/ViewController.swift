//
//  ViewController.swift
//  Meme Me
//
//  Created by Mark Lindamood on 3/19/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var cropToolButton: UIBarButtonItem!
   
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    ///// MARK: - Constants & Set-up
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    let TOP_DEFAULT_TEXT = "TOP"
    let BOTTOM_DEFAULT_TEXT = "BOTTOM"
    var cropImage: UIImage!
    
    let memeTextDelegate = MemeTextFieldDelegate()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
    enum TextFields {
        case topTextField
        case bottomTextField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topTextField.text = TOP_DEFAULT_TEXT
        bottomTextField.text = BOTTOM_DEFAULT_TEXT
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        self.topTextField.delegate = memeTextDelegate
        self.bottomTextField.delegate = memeTextDelegate
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Modified from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
        if let _ = imagePickerView.image {
            shareButton.enabled = true
        } else {
            shareButton.enabled = false
        }
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    ///// MARK: ImagePicker Functions
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
            imagePickerView.contentMode = .ScaleAspectFill
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
        
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    @IBAction func shareAction(sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (s: String?, ok: Bool, items: [AnyObject]?, err: NSError?) -> Void in
            if ok {
                self.save()
                NSLog("Successfully saved image.")
            } else if err != nil {
                NSLog("Error: \(err)")
            } else {
                NSLog("Unknown cancel -- user likely clicked \"cancel\" to dismiss activity view.")
            }
        }
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [.AllButUpsideDown]
    }
    
    
    ///// MARK: Keyboard Functions
    // Copied per discussion thread: https://discussions.udacity.com/t/better-way-to-shift-the-view-for-keyboardwillshow-and-keyboardwillhide/36558
    func keyboardWillShow(notification: NSNotification) -> Void{
        if bottomTextField.isFirstResponder(){
            self.view.frame.origin.y -= getKeyboardHeight(notification);
        }
        else if topTextField.isFirstResponder(){
            self.view.frame.origin.y = 0;
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification:NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillHide(notification: NSNotification){
        view.frame.origin.y = 0
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardDidShowNotification, object:nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardDidHideNotification, object:nil)
        
    }
    
    
    ///// MARK: Helpers for creating Meme
    func hideStatusBarAndToolBar() {
        topToolBar.hidden = true
        bottomToolBar.hidden = true
    }
    
    func showStatusBarAndToolbar() {
        topToolBar.hidden = false
        bottomToolBar.hidden = false
    }
    
    func resetText() {
        viewDidLoad()
    }
    
    
    ///// MARK: Memes Object Functions
    struct Meme {
        var topTextField: String
        var bottomTextField:String
        var pickerViewImage: UIImage
        var memedImage: UIImage
    }
    
    func generateMemedImage() -> UIImage {
        
        hideStatusBarAndToolBar()
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        showStatusBarAndToolbar()
        
        return memedImage
    }
    
    ///// MARK: Save/Cancel
    func save () {
        // Create the meme
        let memedImage = generateMemedImage()
        _ = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, pickerViewImage:imagePickerView.image!, memedImage:memedImage)
    }
    
    func cancel(){
        imagePickerView.image = nil
        showStatusBarAndToolbar()
        viewDidLoad()
        shareButton.enabled = false
    }
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        cancel()
    }
    
}


