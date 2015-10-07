//
//  MovieListTableViewController.swift
//  RottenTom
//
//  Created by MSSSD on 9/26/15.
//  Copyright © 2015 MSSSD. All rights reserved.
//

import Foundation

//import UI KIT
import UIKit

//create class after the : is the subclass
class MovieListTableViewController: UITableViewController, DownloaderDelegate {
    
    
    //movie array to hold our movies from the json object, initializing it, not createing  movie type because we don't know what we'll get back from Json
    
    var moviesArray = [AnyObject](){
        //we are adding a closure to this, so whenever it's set it will run this closure
        didSet {
            self.tableView.reloadData()
        }
    }
    

    //constant initialize an instance of a downloaer
    let downloadManager = Downloader()
    
    //this is a closure variable - a function that is a variable
    private let jsonURL: NSURL = {
        let apiKey = "qe43pmsb84evcmyj43gbe7j8"
        let urlString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=\(apiKey)"
        
        //our return will have a custom initializer ... the () is an initializer and the ! tells it to ignore an error
        return NSURL(string: urlString)!
        
        }()
    
    //http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=
    //let apiKey = "qe43pmsb84evcmyj43gbe7j8"
    
    
    
    
    //we are overridding view did load, apple do your stuff and we'll do our stuff we always have to call super ourselfs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //right before it loads
        self.downloadManager.delegate = self
        
        
        //now we are going to get the URL once the view loads
        self.downloadManager.downloadDataForURL(self.jsonURL)
        
        
        NSLog("MovieListTableViewController: Did Load")
    }
    
    //writng a method to get the number of rows from the array so the ViewController knows how many rows to build for the view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.moviesArray.count
    }
    
    //we'll match row to cell ....type in tableView to open up auto complete and it will autocomplete a function for table views....
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath)
        
        //we need more than just the cell, so let's get the info
        
        let movie = self.moviesArray[indexPath.row] as! NSDictionary
        let movieTitle = movie["title"] as! String
        let movieSynopsis = movie["synopsis"] as! String
        
        //whirlwind code that wouldn't doesn't work....
        //let moviePostersDictionary = movie["posters"] as! NSDictionary
        //let moviePosterURLString = moviePostersDictionary["thumbnail"] as! String
        //let moviePosterURL = NSURL(string: moviePosterURLString)!
        
        //telling download manager to download image..wil call random method - did finish downloaing url, 
        //in the time we downloaded, the cell could have changd identities, so loads 10 cells only, and as you scroll recycles cells...so...
        //if let
        //self.downloadManager.downloadDataForURL(moviePosterURL)
        
        cell.textLabel?.text = movieTitle
        cell.detailTextLabel?.text = movieSynopsis
        
        
            return cell
        
    }
    
    
    func downloadFinishedForURL(finishedURL: NSURL){
        
        //this will pull down raw binary data
        let data = self.downloadManager.downloadedData[finishedURL]
        
        //use serialization utlity - insists that we use a try catch so the try! is like, take whatever
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        
        //casting this AnyObject json to an oldSkool NSdictionary, and then casting "movies" key to
        let dictionary = json as! NSDictionary
        
        
        //need to make sure this is on the main thread...bc if it's on the background thread will not be able to be accessed from the view
        dispatch_async(dispatch_get_main_queue()){
             self.moviesArray = dictionary["movies"] as! [AnyObject]
        
        }
        
        
        
        NSLog("Found data \(json)")
        
    }
    
    
}
