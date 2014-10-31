//
//  PostCell.swift
//  Photog
//
//  Created by Jordan Hudgens on 10/20/14.
//  Copyright (c) 2014 Jordan Hudgens. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet var postImageView : UIImageView?
    @IBOutlet var usernameLabel : UILabel?
    @IBOutlet var dateLabel : UILabel?
    
    var post: PFObject? {
        didSet {
            self.configure()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        if let constPost = post {
            // Set the username label
            var user = constPost["User"] as PFUser
            user.fetchIfNeededInBackgroundWithBlock({
                (object, error) -> Void in
                
                if let constObject = object {
                    self.usernameLabel!.text = user.username
                } else if let constError = error {
                    // Give alert
                }
            })
            
            // Set the date label
            var date = constPost.createdAt
            self.dateLabel?.text = date.fuzzyTime()
            
            
            // Download the image and display it
            NetworkManager.sharedInstance.fetchImage(constPost, completionHandler: {
                (image, error) -> () in
                
                if (image != nil) {
                    self.postImageView!.image = image
                } else {
                    // Alert the user
                }
            })
            
            
        }
    }
    
}
