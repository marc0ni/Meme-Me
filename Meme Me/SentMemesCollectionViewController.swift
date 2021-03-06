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
    @IBOutlet weak var addMemeButton: UIBarButtonItem!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]{
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    var contentView = UIView()
    
    override func viewWillAppear(animated: Bool) {
        collectionView!.reloadData()
        collectionView?.hidden = false
        tabBarController!.tabBar.hidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        collectionView?.hidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 6
        let heightDimension = (view.frame.size.height - (2 * space)) / 6
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(widthDimension, heightDimension)
        
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
        let meme = memes[indexPath.item]

        // Configure the cell...
        cell.memedImage.image = meme.memedImage
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.meme = memes[indexPath.item] as Meme
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueFromCollection") {
            tabBarController!.tabBar.hidden = true
        }
    }
    
    
    @IBAction func addMeme(sender: AnyObject) {
        performSegueWithIdentifier("segueFromCollection", sender: "addMeme")
    }
}
