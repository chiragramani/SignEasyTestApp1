//
//  Client.swift
//  SignEasyTestApp1
//
//  Created by Chirag Ramani on 22/09/16.
//  Copyright © 2016 Chirag Ramani. All rights reserved.
//

import Foundation

final class Client:NSObject
{
    static let sharedInstance = Client()
    
    override init() {
        super.init()
    }
    
    final func taskForGETMethod(completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        let apiAddress = "https://api.getsigneasy.com/v4/files"
        let apiURL=NSURL(string: apiAddress)
        let request = NSMutableURLRequest(URL: apiURL!)
        request.addValue("Basic dmluYXlhayswNUBnZXRzaWduZWFzeS5jb206ZjBlNjU5NzVlZDlhNDM4MDViMDMwYjVlMGQ0YWY4MzIzOWE2NTJiMWRkZDdmYTI2YjEwODQyNGUxOWY0ODY3Ng==", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
           guard (error == nil) else {
                if(error!.code==(-1009))
                {
                    sendError("The Internet connection appears to be offline")
                }
                else
                {
                    sendError("There was an error with your request: \(error)")
                }
                return
            }
            
           guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
           self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        task.resume()
        
        return task
    }
    
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    
}




