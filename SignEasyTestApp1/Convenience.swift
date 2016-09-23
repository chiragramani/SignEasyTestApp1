//
//  Convenience.swift
//  SignEasyTestApp1
//
//  Created by Chirag Ramani on 22/09/16.
//  Copyright © 2016 Chirag Ramani. All rights reserved.
//

import Foundation

extension Client
{
    func fetchFiles(completionHandler:(success: Bool, errorString: String?) -> Void)
    {
    Client.sharedInstance.taskForGETMethod { (result, error) in
        if error == nil
        {
            Client.sharedInstance.extractData("pending", result: result)
            Client.sharedInstance.extractData("draft", result: result)
            Client.sharedInstance.extractData("original", result: result)
            Client.sharedInstance.extractData("signed", result: result)
            completionHandler(success: true, errorString: nil)
        }
        else
        {
            print(error?.localizedDescription)
            completionHandler(success: false, errorString: error?.localizedDescription)
        }
        }
    
    }
    
    func extractData(category:String,result:AnyObject)
    {
    
        if let results = result as? [String:AnyObject]
        {
            if let pendingFiles = results["\(category)"] as? [String:AnyObject]
            {
                if let files = pendingFiles["files"] as? [[String:AnyObject]]
                {
                    var fileNames=[String]()
                    for file in files
                    {
                        let fileName = file["name"] as! String
                        fileNames.append(fileName)
                    }
                    if fileNames.count>0
                    {
                        let categ=Category()
                        categ.categoryName=category
                        categ.fileNames=fileNames
                        Data.sharedInstance().categories.append(categ)
                    }
                }
            }
        }
    }}
