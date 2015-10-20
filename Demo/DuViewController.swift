//
//  DuViewController.swift
//  Demo
//
//  Created by Justin on 10/18/15.
//  Copyright © 2015 Guyser. All rights reserved.
//

import UIKit

class DuViewController: UIViewController {
    
    var barHandler = NavigationBarTransitionHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        guard let count = navigationController?.viewControllers.count,
//            let priorController = navigationController?.viewControllers[count - 2],
//            let fromView = priorController.view,
//            let origBar = navigationController?.navigationBar else {
//                print("\(__FUNCTION__): 😭")
//                return
//        }
//        
//        // Make real navigation bar's background view transparent
//        if let view = origBar.valueForKey("_backgroundView") as? UIView {
////            view.hidden = true
//            var rect = view.frame
//            rect.origin.x -= CGRectGetWidth(rect)
//            view.frame = rect
//        }
//        
//        // Get frame of original bar
//        var frame = origBar.frame
//        
//        // Create new navigation bar with same frame
//        let bar = UINavigationBar(frame: frame)
//        bar.translucent = false
//        bar.backgroundColor = UIColor.redColor()
//        
//        // Tag to ease removal
//        bar.tag = 1234
//        
//        frame.origin = CGPointMake(-150, -20)
//        frame.size.height += 20
//        
//        // Set new bars background view frame
//        if let barBackgroundView = bar.valueForKey("_backgroundView") as? UIView {
//            barBackgroundView.frame = frame
//        }
//        
//        // Clone shadow image
//        bar.shadowImage = origBar.shadowImage
        
        // Add new bar to subview
//        fromView.addSubview(bar)
        
//        if let view = origBar.valueForKey("_backdropView") as? UIView {
//            view.alpha = 0
//        }
        
        transitionCoordinator()?.animateAlongsideTransition({ context in
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
            self.barHandler.animateViewAppearing(context, navigationController: self.navigationController)
            }, completion: nil)
        
        for constraint in view.constraints {
            let firstItem = constraint.firstItem as? NSObject
            let secondItem = constraint.secondItem as? NSObject
            let topLayoutGuide = self.topLayoutGuide as! NSObject
            if firstItem == topLayoutGuide && secondItem == self.view ||
                secondItem == topLayoutGuide && firstItem == self.view {
                    constraint.constant = -84
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        transitionCoordinator()?.animateAlongsideTransition({ context in
            self.navigationController?.navigationBar.tintColor = nil
            self.navigationController?.navigationBar.titleTextAttributes = nil
            self.barHandler.animateViewDisappearing(context, navigationController: self.navigationController)
            }, completion: { context in
                self.barHandler.animateViewDisappearingComplete(context)
        })
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
