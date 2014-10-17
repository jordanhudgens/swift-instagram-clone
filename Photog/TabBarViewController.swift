//
//  TabBarViewController.swift
//  Photog
//
//  Created by Jordan Hudgens on 10/16/14.
//  Copyright (c) 2014 Jordan Hudgens. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var feedViewController = UIViewController()
        feedViewController.view.backgroundColor = UIColor.orangeColor()
        
        var profileViewController = UIViewController()
        profileViewController.view.backgroundColor = UIColor.redColor()
        
        var findPeopleViewController = UIViewController()
        findPeopleViewController.view.backgroundColor = UIColor.blackColor()
        
        var cameraViewController = UIViewController()
        cameraViewController.view.backgroundColor = UIColor.purpleColor()
        
        var viewControllers = [feedViewController, profileViewController, findPeopleViewController, cameraViewController]
        self.setViewControllers(viewControllers, animated: true)
        
        let tabItems = tabBar.items as [UITabBarItem]
        for (index, value) in enumerate(tabItems) {
            value.title = "Hey"
        }
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.hidesBackButton = true
        self.tabBar.translucent = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Photog"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
