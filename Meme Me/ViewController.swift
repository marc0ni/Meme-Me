//
//  ViewController.swift
//  Meme Me
//
//  Created by Mark Lindamood on 3/19/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolBar: UINavigationItem!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    ///// MARK: - Constants & Set-up
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    let TOP_DEFAULT_TEXT = "TOP"
    let BOTTOM_DEFAULT_TEXT = "BOTTOM"
    
    //var oldText: String = ""
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
        /*setUpTextField(TextFields.topTextField)
        setUpTextField(TextFields.bottomTextField)*/
        
        topTextField.text = TOP_DEFAULT_TEXT
        bottomTextField.text = BOTTOM_DEFAULT_TEXT
        
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center

        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        self.topTextField.delegate = memeTextDelegate
        self.bottomTextField.delegate = memeTextDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    ////// MARK: TextField Functions
    func textFieldProperties() {
        let textField = UITextField()
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = memeTextDelegate
        textField.textAlignment = .Center
        
    }
    
    func setUpTextField(textField: TextFields) {
        
        switch textField {
            
        case TextFields.topTextField:
            topTextField.text = TOP_DEFAULT_TEXT
            textFieldProperties()
            /*topTextField.defaultTextAttributes = memeTextAttributes
            self.topTextField.delegate = memeTextDelegate
            topTextField.textAlignment = .Center*/
            
        case TextFields.bottomTextField:
             bottomTextField.text = BOTTOM_DEFAULT_TEXT
             textFieldProperties()
             /*bottomTextField.defaultTextAttributes = memeTextAttributes
             self.bottomTextField.delegate = memeTextDelegate
             bottomTextField.textAlignment = .Center*/
        }
    }
    
    func resetText() {
        setUpTextField(TextFields.topTextField)
        setUpTextField(TextFields.bottomTextField)
    }
    
    
    ///// MARK: ImagePicker Functions
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
            imagePickerView.contentMode = .ScaleAspectFill
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [.AllButUpsideDown]
    }
    
    
    ///// MARK: Keyboard Functions
    /*func keyboardWillShow(notification: NSNotification){
    self.view.frame.origin.y -= getKeyboardHeight(notification)
    }*/
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        bottomToolBar.hidden = true
    }
    
    func showStatusBarAndToolbar() {
        self.navigationController?.navigationBarHidden = false
        bottomToolBar.hidden = false
    }
    
    func takeScreenshot() -> UIImage {
        // uses the context approach
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    
    ///// MARK: Memes Object Functions
    struct Meme {
        var topTextField: String
        var bottomTextField:String
        var pickerViewImage: UIImage
        var memedImage: UIImage
    }
    
    func save () {
        // Create the meme
        let memedImage = generateMemedImage()
        _ = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, pickerViewImage:imagePickerView.image!, memedImage:memedImage)
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
    
}
