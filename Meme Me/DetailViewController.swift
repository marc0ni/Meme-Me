//
//  DetailViewController.swift
//  Meme Me
//
//  Created by Mark Lindamood on 5/10/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var pickerImageView: UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.topLabel.text = self.meme.topTextField
        self.bottomLabel.text = self.meme.bottomTextField
        self.pickerImageView!.image = self.meme.pickerViewImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
