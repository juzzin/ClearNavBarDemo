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

protocol NavigationBarHandler: NSObjectProtocol {
    func animateViewAppearing(context: UIViewControllerTransitionCoordinatorContext, navigationController: UINavigationController?)
    func animateViewDisappearing(context: UIViewControllerTransitionCoordinatorContext, navigationController: UINavigationController?)
    func animateViewDisappearingComplete(context: UIViewControllerTransitionCoordinatorContext)
}

class SlidingBarHandler: NSObject, NavigationBarHandler {
    
    func animateViewAppearing(context: UIViewControllerTransitionCoordinatorContext, navigationController: UINavigationController?) {
        
        guard let bar = navigationController?.navigationBar else {
            print("\(__FUNCTION__): 😤")
            return
        }
        
        guard let navigationController = navigationController else {
            print("Navigation controller must be an instance of the NavigationController class.")
            return
        }
        
        guard let fromController = context.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
                return
        }

        // When from controller is second to last, we've pushed a new controller
        var toBarPosition = NavigationBarPosition.Left
        let controllers = navigationController.viewControllers
        if controllers.count > 1 && fromController !== controllers[controllers.endIndex - 2] {
            toBarPosition = .Right
        }
        
        positionNavigationBar(bar, position: toBarPosition)
    }
    
    func animateViewDisappearing(context: UIViewControllerTransitionCoordinatorContext, navigationController: UINavigationController?) {
        
        guard let bar = navigationController?.navigationBar else {
                print("\(__FUNCTION__): 😤")
                return
        }
        
        guard let navigationController = navigationController else {
            print("Navigation controller must be an instance of the NavigationController class.")
            return
        }
        
        guard let fromController = context.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
                return
        }
        
        
        // When from controller is second to last, we've pushed a new controller
        var toBarPosition = NavigationBarPosition.Left
        let controllers = navigationController.viewControllers
        if controllers.count > 2 && fromController === controllers[controllers.endIndex - 2] {
            toBarPosition = .Right
        }
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        positionNavigationBar(bar, position: toBarPosition)
        CATransaction.commit()
        
        positionNavigationBar(bar, position: .Center)
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
    }
}