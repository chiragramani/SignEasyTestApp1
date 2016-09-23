//
//  BaseCell.swift
//  SignEasyTestApp1
//
//  Created by Chirag Ramani on 23/09/16.
//  Copyright © 2016 Chirag Ramani. All rights reserved.
//

import UIKit


class BaseCell:UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel:UILabel={
        let label=UILabel()
        label.font=UIFont.systemFontOfSize(12)
        label.textColor=UIColor.whiteColor()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.numberOfLines=0
        label.text="SignEasy"
        return label
    }()
    
    func setupViews()
    {
        backgroundColor=UIColor(red: 73.0/255.0, green: 133.0/255.0, blue: 203.0/255.0, alpha: 1)
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
    }
    
}
