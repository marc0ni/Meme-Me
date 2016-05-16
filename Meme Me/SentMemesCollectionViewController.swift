//
//  SentMemesCollectionViewController.swift
//  Meme Me
//
//  Created by Mark Lindamood on 5/4/16.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit
import Foundation

class SentMemesCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]{
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    var contentView = UIView()
    
    // This is an array of Meme instances
    let allMemes = Meme.allMemes
    
    override func viewWillAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        print("the current value of 'memes' is \(memes)")

        // Configure the cell...
        cell.topLabel.text = meme.topTextField
        cell.collectionPickerView = UIImageView(image: meme.pickerViewImage)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    
    
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    
}
