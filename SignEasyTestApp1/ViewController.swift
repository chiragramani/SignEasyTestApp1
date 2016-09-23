//
//  ViewController.swift
//  SignEasyTestApp1
//
//  Created by Chirag Ramani on 22/09/16.
//  Copyright © 2016 Chirag Ramani. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    private let cellID="CellId"
    private let headerID="HeaderId"
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        setupActivityIndicator(false)
        navigationController?.navigationBar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.whiteColor()]
        navigationController!.navigationBar.barTintColor = UIColor(red: 69/255, green: 88/255, blue: 151/255, alpha: 1)
        self.navigationItem.title="SignEasy"
        collectionView?.backgroundColor=UIColor.whiteColor()
        collectionView?.registerClass(BaseCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.registerClass(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        
        Client.sharedInstance.fetchFiles { (success, errorString) in
            if(success)
            {
                dispatch_async(dispatch_get_main_queue(), {
                    self.collectionView?.reloadData()
                    self.setupActivityIndicator(true)

                })
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 20)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header=collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerID, forIndexPath: indexPath) as! HeaderCell
        header.nameLabel.text = Data.sharedInstance().categories[indexPath.section].categoryName
        return header
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.sharedInstance().categories[section].fileNames!.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width/4, height: view.frame.width/4 )
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return Data.sharedInstance().categories.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! BaseCell
        cell.nameLabel.text=Data.sharedInstance().categories[indexPath.section].fileNames![indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 14, right: 14)
    }
    
    func setupActivityIndicator(bool:Bool)
    {
        
        activityIndicator.hidden = bool
        if(bool)
        {
           activityIndicator.stopAnimating()
        }
        else
        {
            activityIndicator.startAnimating()
        }
    }
    
    func configureActivityIndicator()
    {   
        activityIndicator=UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicator.color = UIColor(red: 69/255, green: 88/255, blue: 151/255, alpha: 1)
        activityIndicator.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(activityIndicator)
        activityIndicator.center=view.center
    }
    
}






