//
//  AppDelegate.swift
//  ContainerTest
//
//  Created by Nicholas Outram on 24/06/2014.
//  Copyright (c) 2014 Plymouth University. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
                            
    var window: UIWindow?
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        
        //Get storyboard
        let sb = UIStoryboard(name: "Storyboard", bundle: nil)
        
        let container = sb.instantiateViewControllerWithIdentifier("RootContainerViewController") as RootContainerViewController
        let detail    = sb.instantiateViewControllerWithIdentifier("DetailViewController")        as DetailViewController
        let master    = sb.instantiateViewControllerWithIdentifier("MasterTableViewController")   as MasterTableViewController
        detail.message = "No data to display"
        
        let nav = UINavigationController(rootViewController: master)
        let splitVC = UISplitViewController();
        splitVC.viewControllers = [nav, detail]
        splitVC.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        splitVC.delegate = self
        
        //The root view controller is a container which overrides size classes
        container.childVC = splitVC
        
        self.window!.rootViewController = container
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // DELEGATE METHODS
    
    func primaryViewControllerForCollapsingSplitViewController(splitViewController: UISplitViewController!) -> UIViewController!
    {
        println("Collapse:")
        return splitViewController.viewControllers[0] as? UINavigationController
    }
    func primaryViewControllerForExpandingSplitViewController(splitViewController: UISplitViewController!) -> UIViewController!
    {
        println("Expand: \(splitViewController.viewControllers)")
        return splitViewController.viewControllers[0] as? UINavigationController
    }
    
    //Override the behaviour when collapsing
    func splitViewController(splitViewController: UISplitViewController!, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool
    {
        
        //Return false to stop collapsing - i.e. let the split view controller try and incorporate the secondary view controller’s content into the collapsed interface
        //Return true to indicate that you want to fully collase - i.e. don't ask the split view controller to try and merge content in master-detail.
        
        return true //Allow to collapse fully (do not try and incorporate detail in master)
    }
    
    //Override the behaviour when expanding
    func splitViewController(splitViewController: UISplitViewController!, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController!
    {
        //nil is the default - in this case - pop the controller off the navigation stack
        return nil
        
        //We could return a different view controller here and override the secondary controller - try uncommenting the following
        //        return UITableViewController()
    }
}

