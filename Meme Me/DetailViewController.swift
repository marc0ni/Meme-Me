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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
