//
//  RootContainerViewController.swift
//  ContainerTest
//
//  Created by Nicholas Outram on 24/06/2014.
//  Copyright (c) 2014 Plymouth University. All rights reserved.
//

import UIKit

class RootContainerViewController: UIViewController {
    
    
    //Underlying instance variable (would ideally be private)
    var _childVC : UIViewController? {
        willSet {
            
            //REMOVE OLD VC
            println("Property will set")
            if (_childVC != nil) {
                _childVC!.willMoveToParentViewController(nil)
                self.setOverrideTraitCollection(nil, forChildViewController: _childVC)
                _childVC!.view.removeFromSuperview()
                _childVC!.removeFromParentViewController()
            }
            if (newValue) {
                self.addChildViewController(newValue)
            }
            
        }
    
        //I can't see a way to 'stop' the value being set to the same controller - hence the computed property
    
        didSet {
            
            //ADD NEW VC
            println("Property did set")
            if (_childVC) {
//                var views  = NSDictionaryOfVariableBindings(self.view)    .. NOT YET SUPPORTED (NSDictionary bridging not yet available)
                
                //Add subviews + constraints
                _childVC!.view.setTranslatesAutoresizingMaskIntoConstraints(false)       //For now - until I add my own constraints
                self.view.addSubview(_childVC!.view)
                let views = ["view" : _childVC!.view] as NSMutableDictionary
                let layoutOpts = NSLayoutFormatOptions(0)
                let lc1 : AnyObject[] = NSLayoutConstraint.constraintsWithVisualFormat("|[view]|",  options: layoutOpts, metrics: NSDictionary(), views: views)
                let lc2 : AnyObject[] = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: layoutOpts, metrics: NSDictionary(), views: views)
                self.view.addConstraints(lc1)
                self.view.addConstraints(lc2)
                
                //Forward messages to child
                _childVC!.didMoveToParentViewController(self)
            }
        }
    }


    //Computed property - this is the property that must be used to prevent setting the same value twice
    //unless there is another way of doing this?
    var childVC : UIViewController? {
        get {
            return _childVC
        }
        set(suggestedVC) {
            if (suggestedVC != _childVC) {
                _childVC = suggestedVC
            }
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
        self.overrideTraitsForChildVC(self.view.bounds.size)
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

}
