//
//  RootContainerViewController.swift
//  ContainerTest
//
//  Created by Nicholas Outram on 24/06/2014.
//  Copyright (c) 2014 Plymouth University. All rights reserved.
//

import UIKit

class RootContainerViewController: UIViewController, UISplitViewControllerDelegate {
    
    @IBOutlet var containerView: UIView
    
    //Computed property - this is the property that must be used to prevent setting the same value twice
    //unless there is another way of doing this?
    var childVC : UIViewController? {
        get {
            return self.childViewControllers[0] as? UISplitViewController
        }
    }
    
    //This is the magic - override UI Traits in landscape mode
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator!)
    {
        self.overrideTraitsForChildVC(size)
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    func overrideTraitsForChildVC(size:CGSize) {
        if (size.width>320.0) {
            println("Going regular width");
            let tc1 = self.traitCollection;
            let tc2 = UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular)
            let traits = UITraitCollection(traitsFromCollections: [tc1, tc2])
            self.setOverrideTraitCollection(traits, forChildViewController: self.childVC)
        } else {
            println("Going default");
            self.setOverrideTraitCollection(nil, forChildViewController: self.childVC)
        }
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization

    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
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
        return splitViewController.viewControllers[0] as? UINavigationController
    }
    func primaryViewControllerForExpandingSplitViewController(splitViewController: UISplitViewController!) -> UIViewController!
    {
        println("Expand: \(splitViewController.viewControllers)")
        return splitViewController.viewControllers[0] as? UINavigationController
    }
    func splitViewController(splitViewController: UISplitViewController!, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool
    {
        
        //Return false to let the split view controller try and incorporate the secondary view controller’s content into the collapsed interface
        //Return true to indicate that you do not want the split view controller to do anything with the secondary view controller.

        return true //Allow to collapse fully (do not try and incorporate detail in master)
    }
    func splitViewController(splitViewController: UISplitViewController!, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController!
    {
        //nil is the default
        return nil
        
        //If there is no content, we could return a different view controller here and override (e.g. a placeholder)
    }
    

}
