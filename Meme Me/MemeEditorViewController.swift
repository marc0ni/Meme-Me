//
//  MemeEditorViewController.swift
//  Meme Me
//
//  Created by Mark Lindamood on 3/19/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit
import Foundation
//import AVFoundation


class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var navigationItems: UINavigationBar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var zoomAndPanButton: UIBarButtonItem!
       
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    ///// MARK: - Constants & Set-up
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    let TOP_DEFAULT_TEXT = "TOP"
    let BOTTOM_DEFAULT_TEXT = "BOTTOM"
    
    var memedImage:UIImage!
    
    var meme: Meme!
    
    var memes: [Meme]! {
       return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    let memeTextDelegate = MemeTextFieldDelegate()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0,
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
        
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
        topTextField.delegate = memeTextDelegate
        bottomTextField.delegate = memeTextDelegate
        
        zoomAndPanButton.enabled = false
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //tabBarController!.tabBar.hidden = true
        
        //Modified from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
        if imagePickerView.image != nil {
            shareButton.enabled = true
            zoomAndPanButton.enabled = true
        } else {
            shareButton.enabled = false
            zoomAndPanButton.enabled = true
        }
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        ()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
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
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = chosenImage
            imagePickerView.contentMode = .ScaleAspectFit
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
        
    //Copied from https://github.com/mrecachinas/MemeMeApp/blob/master/MemeMe/MemeEditorViewController.swift
    @IBAction func shareAction(sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (type: String?, returnedItem: Bool, items: [AnyObject]?, error: NSError?) -> Void in
            if returnedItem {
                self.save()
                print("Successfully saved image.")
            } else if error != nil {
                print("Error: \(error)")
            } else {
                print("Unknown cancel -- user likely clicked \"cancel\" to dismiss activity view.")
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
            view.frame.origin.y -= getKeyboardHeight(notification)
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
    func hideNavBarAndToolBar() {
        navigationItems.hidden = true
        bottomToolBar.hidden = true
    }
    
    func showNavBarAndToolbar() {
        navigationItems.hidden = false
        bottomToolBar.hidden = false
    }
    
    func resetText() {
        viewDidLoad()
    }
    
    
    ///// MARK: Memes Object Functions
    func generateMemedImage() -> UIImage {
        
        hideNavBarAndToolBar()
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        showNavBarAndToolbar()
        
        
        return memedImage
    }
    
    ///// MARK: Zoom and Pan
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
        if recognizer.state == UIGestureRecognizerState.Ended {
            //1
            let velocity = recognizer.velocityInView(self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude/200
            print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            //2
            let slideFactor = 0.1 * slideMultiplier //Increase for more of a slide
            
            //3
            var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x + slideFactor),
                y: recognizer.view!.center.y + (velocity.y * slideFactor))
            
            //4
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            //5
            UIView.animateWithDuration(Double(slideFactor * 2),
                delay:0,
                //6
                options:UIViewAnimationOptions.CurveEaseOut,
                animations: {recognizer.view!.center = finalPoint},
                completion:nil)
            
        }
    }
    
    @IBAction func handlePinch(recognizer :UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformScale(view.transform, recognizer.scale, recognizer.scale)
            recognizer.scale = 1
        }
    }

    
    @IBAction func zoomAndPanAction(sender: AnyObject) {
        let pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("handlePinch:"))
        imagePickerView.addGestureRecognizer(pinchGesture)
        
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        imagePickerView.addGestureRecognizer(panGesture)
        
    }
    
    
    ///// MARK: Save/Cancel
    func save () {
        // Create the meme
        let memedImage = generateMemedImage()
        let meme = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, pickerViewImage:imagePickerView.image!, memedImage:memedImage)
        
        // Add it to memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func cancel(){
        presentingViewController?.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        cancel()
    }
    
}
    

extension NSLayoutConstraint {
    
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}





