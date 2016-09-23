//
//  Data.swift
//  SignEasyTestApp1
//
//  Created by Chirag Ramani on 22/09/16.
//  Copyright © 2016 Chirag Ramani. All rights reserved.
//

import Foundation

class Data:NSObject
{
    var categories: [Category] = [Category]()
    
    class func sharedInstance() -> Data {
        struct Singleton {
            static var sharedInstance = Data()
        }
        return Singleton.sharedInstance
    }
}


class Category:NSObject
{
    //static let sharedInstance=Category()
    var fileNames:[String]?
    var categoryName:String?
}


