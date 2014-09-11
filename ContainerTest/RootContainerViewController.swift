//
//  RootContainerViewController.swift
//  ContainerTest
//
//  Created by Nicholas Outram on 24/06/2014.
//  Copyright (c) 2014 Plymouth University. All rights reserved.
//

import UIKit

class RootContainerViewController: UIViewController, UISplitViewControllerDelegate {
    
    @IBOutlet var containerView: UIView?
    
    //Computed property - this is the property that must be used to prevent setting the same value twice
    //unless there is another way of doing this?
    var childVC : UIViewController? {
        get {
            return self.childViewControllers[0] as? UISplitViewController
        }
    }
    
    //This is the magic - override UI Traits in landscape mode
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        self.overrideTraitsForChildVC(size)
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    func overrideTraitsForChildVC(size:CGSize) {
        if self.childVC == nil {
            return
        }
        var traits : UITraitCollection?
        
        if (size.width>320.0) {
            println("Going regular width");
            let tc1 = self.traitCollection;
            let tc2 = UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular)
            traits = UITraitCollection(traitsFromCollections: [tc1, tc2])
            println("traits: \(traits)")
        } else {
            println("Going default");
        }
        self.setOverrideTraitCollection(traits, forChildViewController: self.childVC!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let svc = self.childVC as UISplitViewController
        svc.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        svc.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


    // DELEGATE METHODS
    func primaryViewControllerForCollapsingSplitViewController(splitViewController: UISplitViewController!) -> UIViewController!
    {
        println("Collapse:")
        return splitViewController.viewControllers[0] as UINavigationController
    }
    func primaryViewControllerForExpandingSplitViewController(splitViewController: UISplitViewController!) -> UIViewController!
    {
        println("Expand: \(splitViewController.viewControllers)")
        return splitViewController.viewControllers[0] as UINavigationController
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
