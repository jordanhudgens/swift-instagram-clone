//
//  NetworkManager.swift
//  Photog
//
//  Created by Jordan Hudgens on 10/20/14.
//  Copyright (c) 2014 Jordan Hudgens. All rights reserved.
//

import Foundation

typealias ObjectsCompletionHandler = (objects: [AnyObject]?, error: NSError?) -> ()
typealias ImageCompletionHandler = (image: UIImage?, error: NSError?) -> ()

public class NetworkManager
{
    public class var sharedInstance: NetworkManager
    {
        struct Singleton
        {
            static let instance = NetworkManager()
        }
            
        return Singleton.instance
    }
    
    func follow(user: PFUser!, completionHandler:(error: NSError?) -> ())
    {
        var relation = PFUser.currentUser().relationForKey("following")
        relation.addObject(user)
        PFUser.currentUser().saveInBackgroundWithBlock {
            (success, error) -> Void in
            
            completionHandler(error: error)
        }
    }
    
    func fetchFeed(completionHandler: ObjectsCompletionHandler!)
    {
        var relation = PFUser.currentUser().relationForKey("following")
        var query = relation.query()
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if (error != nil) {
                println("error fetching following")
                completionHandler(objects: nil, error: error)
            } else {
                println("sucess fetching following \(objects)")
                
                var postQuery = PFQuery(className: "Post")
                postQuery.whereKey("User", containedIn: objects)
                postQuery.orderByDescending("createdAt")
                postQuery.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error: NSError!) -> Void in
                    
                    if (error != nil) {
                        println("error fetching posts")
                        completionHandler(objects: nil, error: error)
                    } else {
                        println("success fetching feed posts \(objects)")
                        completionHandler(objects: objects, error: nil)
                    }
                    
                })
                
            }
        }
    }
    
    func fetchImage(post: PFObject!, completionHandler: ImageCompletionHandler!)
    {
        var imageReference = post["Image"] as PFFile
        imageReference.getDataInBackgroundWithBlock {
            (data, error) -> Void in
            if (error != nil) {
                println("Error fetching image \(error.localizedDescription)")
            } else {
                println("image downloaded")
                let image = UIImage(data: data)
                completionHandler(image: image, error: nil)
            }
        }
    }
}