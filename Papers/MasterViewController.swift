//
//  MasterViewController.swift
//  Papers
//
//  Created by Tim Mitra on 1/14/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit


class MasterViewController: UICollectionViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    private var papersDataSource = PapersDataSource()
    private let reuseIdentifier = "PaperCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.toolbarHidden = true
        let layout = collectionViewLayout as! WaterfallLayout
        layout.delegate = self
        layout.numberOfColumns = 2
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //  override func prepareForSegue(segue: UIStoryboardSegue, sender:
    //    AnyObject?) {
    //      if segue.identifier == "MasterToDetail" {
    //        if let indexPath = collectionView!.indexPathsForSelectedItems()!.first {
    //            if let paper = papersDataSource.paperForItemAtIndexPath(indexPath) {
    //                let detailViewController = segue.destinationViewController as! DetailViewController
    //                detailViewController.paper = paper
    //            }
    //        }
    //      }
    //  }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MasterToDetail" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.paper = sender as? Paper
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("\(papersDataSource.count)")
        return papersDataSource.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PaperCell", forIndexPath: indexPath) as! PaperCell
        
        // Configure the cell
        if let paper = papersDataSource.paperForItemAtIndexPath(indexPath) {
            cell.paper = paper
        }
        
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !editing {
            if let paper = papersDataSource.paperForItemAtIndexPath(indexPath) {
                performSegueWithIdentifier("MasterToDetail", sender: paper)
            }
        } else {
            navigationController!.setToolbarHidden(false, animated: true)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if editing {
            if collectionView.indexPathsForSelectedItems()!.count == 0 {
                navigationController?.setToolbarHidden(true, animated: true)
            }
        }
    }
    
}

extension MasterViewController: WaterfallLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath: NSIndexPath) -> CGFloat {
        let randomHeight = arc4random_uniform(2) + 1
        return CGFloat(100 * randomHeight)
    }
}


















