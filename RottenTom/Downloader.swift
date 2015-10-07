//
//  Downloader.swift
//  RottenTom
//
//  Created by MSSSD on 9/26/15.
//  Copyright © 2015 MSSSD. All rights reserved.
//

import Foundation

//pure swift class - doesn't inhereit
//keys of NSURL and values of data

//our delegete is our ViewController

//a protocol is like an interface - you have to implement its methods (but we can define our own version in the class)
protocol DownloaderDelegate: class {
    
    func downloadFinishedForURL(finishedURL: NSURL)

}

class Downloader {
    
        //var creates prop on class that we can change data in bc let is a constant - colon tells us this is a dict 
        //vs. an array, and the () initializes a blank dictionary of the type in the bracket
        //NSURL is a native class that handles URLs, so NSURLs are our keys, and NSData is our data type
    
    var downloadedData = [NSURL: NSData]()
    //declaring delegate - we will tell the view controller to be the delegate, but might give us mothing - ? means it may return nothing (optional)
    var delegate: DownloaderDelegate?
    
    
                    //url is the var name, and NSURL is the data type
                    //  I am declaring the type of this variable to be of type NSURL
                    //the escape \ (varname) - tells swift to insert varible in middle of string
    
    
    //closure NSURLSessions is an object from apple that downloads things on our behalf
    //have to initialize it witha  configuration, but can use the default
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
        
        }()
    
    func downloadDataForURL(url: NSURL){
        
            //this is a completionhandler....will complete that download he started
            // when we are ceation a method (the rocket indicates return type of method -- if there is a type will expect a return of that type
        let task = self.session.dataTaskWithURL(url){(data, response, error) -> Void in
        
            //when the data is downloaded, we want to push into the dictinoary we created (downloadedData)
            self.downloadedData[url] = data
            self.delegate?.downloadFinishedForURL(url)
            NSLog("succesful download for URL \(url)")
            
        }//MUST call task(resume) or the download will never start....
        task.resume()
    }
    
    
    

}
