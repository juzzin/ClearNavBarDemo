//
//  NavigationBarTransitionHandler.swift
//  Demo
//
//  Created by Justin on 10/20/15.
//  Copyright © 2015 Guyser. All rights reserved.
//

import UIKit

enum NavigationBarPosition : Int {
    case Center
    case Left
    case Right
}

class NavigationBarTransitionHandler: NSObject {
    
    let kNavBarTag = 1234
    
    func animateViewAppearing(context: UIViewControllerTransitionCoordinatorContext, navigationController: UINavigationController?) {
        
//        // Disable animation to prevent fade out animation
//        CATransaction.begin()
//        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
//        
        
        guard let fromController = context.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let toController = context.viewControllerForKey(UITransitionContextToViewControllerKey),
            let toView = context.viewForKey(UITransitionContextToViewKey) else {
                print("\(__FUNCTION__): 😤")
                return
        }
        
        guard let fromView = context.viewForKey(UITransitionContextFromViewKey),
              let origBar = navigationController?.navigationBar else {
                print("\(__FUNCTION__): 😭")
                return
        }
        
        guard let navigationController = navigationController as? NavigationController else {
            print("Navigation controller must be an instance of the NavigationController class.")
            return
        }
        
//        CATransaction.begin()
//        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        switch navigationController.currentOperation {
        case .Push:
            positionNavigationBar(origBar, position: .Left)
        case .Pop:
            positionNavigationBar(origBar, position: .Right)
        default:
            print("😐")
        }
        
//        // Get frame of original bar
//        var frame = origBar.frame
//        
//        // Create new navigation bar with same frame
//        let bar = UINavigationBar(frame: frame)
//        bar.translucent = false
//        bar.barTintColor = UIColor.redColor()
//        
//        // Tag to ease removal
//        bar.tag = kNavBarTag
//        
//        frame.origin = CGPointMake(0, -20)
//        frame.size.height += 20
        
//        // Set new bars background view frame
//        if let barBackgroundView = bar.valueForKey("_backgroundView") as? UIView {
//            barBackgroundView.frame = frame
//        }
//        
//        // Clone shadow image
//        bar.shadowImage = origBar.shadowImage
        
        // Add new bar to subview
//        fromView.addSubview(bar)
        
//        CATransaction.commit()

//        // Make real navigation bar's background view transparent
//        if let origBarBackgroundView = origBar.valueForKey("_backgroundView") as? UIView {
//            // Disable animation to prevent fade out animation
//            CATransaction.begin()
//            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
//            origBarBackgroundView.alpha = 0
//            CATransaction.commit()
//        }
    }
    
    func animateViewDisappearing(context: UIViewControllerTransitionCoordinatorContext, navigationController: UINavigationController?) {
        guard let toController = context.viewControllerForKey(UITransitionContextToViewControllerKey),
            let toView = context.viewForKey(UITransitionContextToViewKey),
            let origBar = navigationController?.navigationBar else {
                print("\(__FUNCTION__): 😤")
                return
        }
        
//        var isPushing = false
//        
//        if let count = navigationController?.viewControllers.count {
//            if count > 2 {
//                if let priorController = navigationController?.viewControllers[count - 2] {
//                    if priorController.dynamicType != toController.dynamicType {
//                        isPushing = true
//                    }
//                }
//            }
//        }
        
        guard let navigationController = navigationController as? NavigationController else {
            print("Navigation controller must be an instance of the NavigationController class.")
            return
        }
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        switch navigationController.currentOperation {
        case .Push:
            positionNavigationBar(origBar, position: .Right)
        case .Pop:
            positionNavigationBar(origBar, position: .Left)
        default:
            print("😐")
        }
        CATransaction.commit()
        
        positionNavigationBar(origBar, position: .Center)
//
//        CATransaction.begin()
//        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
//        if isPushing == true {
//            // Reposition bar background to the right
//            positionNavigationBar(origBar, position: .Left)
//        } else {
//            // Reposition bar background to the left
//            positionNavigationBar(origBar, position: .Right)
//        }
//        CATransaction.commit()
//        
//        // Make real navigation bar's background view transparent
//        if let view = origBar.valueForKey("_backgroundView") as? UIView {
//            var frame = view.frame
//            frame.origin.x = 0
//            view.frame = frame
//        }
//
//        if toController.dynamicType == priorController.dynamicType {
//            origBar.setBackgroundImage(nil, forBarMetrics: .Default)
//            
//        } else {
//            // Get frame of original bar
//            var frame = origBar.frame
//            
//            // Create new navigation bar with same frame
//            let bar = UINavigationBar(frame: frame)
//            
//            // Tag to ease removal
//            bar.tag = kNavBarTag
//            
//            frame.origin = CGPointMake(0, -20)
//            frame.size.height += 20
//            
//            // Disable animation to prevent fade out animation
//            CATransaction.begin()
//            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
//            
//            // Set new bars background view frame
//            if let barBackgroundView = bar.valueForKey("_backgroundView") as? UIView {
//                barBackgroundView.frame = frame
//            }
//            
//            // Clone shadow image
//            bar.shadowImage = origBar.shadowImage
//            
//            // Add new bar to subview
//            toView.addSubview(bar)
//            
//            CATransaction.commit()
//        }
    }
    
    func positionNavigationBar(bar: UINavigationBar?, position: NavigationBarPosition) {
        if let bar = bar,
            let backgroundView = bar.valueForKey("_backgroundView") as? UIView {
                var frame = backgroundView.frame
                switch position {
                case .Center:
                    frame.origin.x = 0
                case .Left:
                    frame.origin.x = -CGRectGetWidth(frame)
                case .Right:
                    frame.origin.x = CGRectGetWidth(frame)
                }
                backgroundView.frame = frame
        }
    }
    
    func animateViewDisappearingComplete(context: UIViewControllerTransitionCoordinatorContext) {
        
        guard let toController = context.viewControllerForKey(UITransitionContextToViewControllerKey),
            let toView = context.viewForKey(UITransitionContextToViewKey),
            let origBar = toController.navigationController?.navigationBar else {
                print("\(__FUNCTION__): 😵")
                return
        }
        
        if let fakeBar = toView.viewWithTag(kNavBarTag) {
            fakeBar.removeFromSuperview()
        }
        
        // Make real navigation bar is restored
        if let origBarBackgroundView = origBar.valueForKey("_backgroundView") as? UIView {
            origBarBackgroundView.hidden = false
        }
    }
}
