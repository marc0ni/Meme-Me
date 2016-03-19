//
//  ViewController.swift
//  Meme Me
//
//  Created by Mark Lindamood on 3/19/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    enum Sources {
        case PhotoLibrary
        case Camera
    }
    
    
    @IBAction func cancelImagePicker(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        switchSource(Sources.Camera)
        /*let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)*/
    }
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        switchSource(Sources.PhotoLibrary)
        /*let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)*/
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
    
    func switchSource(source: Sources) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case Sources.PhotoLibrary:
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        case Sources.Camera:
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            
        }
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}


