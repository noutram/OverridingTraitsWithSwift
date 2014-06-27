OverridingTraitsWithSwift
=========================

Universal master-detail app using Swift in iOS8 to override the UITraitCollection (uses setOverrideTraitCollection)

Demonstates how to override the traits such that an iPhone Master-detail view in landscape mode shows both master and detail on the same screen.

Based loosely on WWDC14 example shown in 216 Building Adaptive Apps with UIKit
https://developer.apple.com/videos/wwdc/2014/

The master branch sets up the navigation stack using code. This includes boiler plate code to create a view controller container.

The "01-UsingStoryBoard" branch removes much of the boiler-plate code for the view controller container. This is rather convenient, but is now tied to 'containing' a UISplitViewController. I would need to re-think this a bit to make it more generic.

The "02-StaticMasterTable" branch removes uses a static table as a master view, and shows seperate detail view controllers for each selection (as opposed to the same controller, but with different data)

