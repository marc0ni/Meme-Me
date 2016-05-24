//
//  DismissSegue.swift
//  Meme Me
//
//  Created by Mark Lindamood on 5/24/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

@objc(DismissSegue)class DismissSegue: UIStoryboardSegue {
    override func perform() {
        if let controller = sourceViewController.presentingViewController {
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}