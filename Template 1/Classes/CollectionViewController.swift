//
//  CollectionViewController.swift
//  iOSAppTemplate
//
//  Created by Rafael on 07/07/15.
//  Copyright (c) 2015 Rafael Colatusso. All rights reserved.
//

import UIKit
import QuartzCore


let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let products: [Dictionary<String, String>] = [
        ["image": "casaco.jpg", "title": "Awesome stuff! 1", "price": "$ 399"],
        ["image": "casaco.jpg", "title": "Awesome stuff! 2", "price": "$ 299"],
        ["image": "casaco.jpg", "title": "Awesome stuff! 3", "price": "$ 199"],
        ["image": "casaco.jpg", "title": "Awesome stuff! 4", "price": "$ 399"],
        ["image": "casaco.jpg", "title": "Awesome stuff! 5", "price": "$ 299"],
        ["image": "casaco.jpg", "title": "Awesome stuff! 6", "price": "$ 199"],
        ["image": "bolsa.jpg", "title": "Purse MK 7", "price": "$ 399"],
        ["image": "bolsa.jpg", "title": "Purse MK 8", "price": "$ 299"],
        ["image": "bolsa.jpg", "title": "Purse MK 9", "price": "$ 199"],
        ["image": "bolsa.jpg", "title": "Purse MK 10", "price": "$ 399"],
        ["image": "bolsa.jpg", "title": "Purse MK 11", "price": "$ 299"],
        ["image": "bolsa.jpg", "title": "Purse MK 12", "price": "$ 199"]]
    
    var lastIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.alwaysBounceVertical = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return products.count/2
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 2
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        cell.title.text = self.products[(indexPath.section+indexPath.section) + indexPath.row]["title"]
        cell.price.text = self.products[(indexPath.section+indexPath.section) + indexPath.row]["price"]
        let imgName = self.products[(indexPath.section+indexPath.section) + indexPath.row]["image"]
        
        cell.imgView.image = UIImage(named: imgName!)
        cell.imgView.clipsToBounds = true
        println("\(indexPath.section), \(indexPath.row)")
        
        lastIndex += 1
        
        // executa a animação somente na primeira vez
        if lastIndex <= self.products.count {
            cell.alpha = 0
    
            UIView.animateWithDuration(1.0, delay: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                cell.alpha = 1
                }, completion: nil)
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var alert = UIAlertController(title: "StoreTemplate", message: "not yet ;(", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "ok!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 152, height: 189)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 1, right: 8)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == self.products.count / 2 - 1 {
            return CGSizeMake(self.view.frame.size.width, 130)
        }
        else {
            return CGSizeMake(0, 0)
        }
    }
    

}
