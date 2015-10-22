//
//  SecondViewController.swift
//  Demo
//
//  Created by Justin on 10/18/15.
//  Copyright © 2015 Guyser. All rights reserved.
//

import UIKit

class SecondViewController: ClearViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        transitionCoordinator()?.animateAlongsideTransition({ context in
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
            }, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        transitionCoordinator()?.animateAlongsideTransition({ context in
            self.navigationController?.navigationBar.tintColor = nil
            self.navigationController?.navigationBar.titleTextAttributes = nil
            }, completion: { context in
                if context.isCancelled() == true {
                    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
                    self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
                }
        })
    }
    
    override func viewWillLayoutSubviews() {
        for constraint in view.constraints {
            let firstItem = constraint.firstItem as? NSObject
            let secondItem = constraint.secondItem as? NSObject
            let topLayoutGuide = self.topLayoutGuide
            if firstItem === topLayoutGuide && secondItem == self.view ||
                secondItem === topLayoutGuide && firstItem == self.view {
                    constraint.constant = -topLayoutGuide.length - CGRectGetHeight(UIApplication.sharedApplication().statusBarFrame)
            }
        }
    }
}
