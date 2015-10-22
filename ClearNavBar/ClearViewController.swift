//
//  ClearViewController.swift
//  ClearNavBarDemo
//
//  Created by Justin on 10/22/15.
//  Copyright © 2015 Guyser. All rights reserved.
//

import UIKit

class ClearViewController: UIViewController {

    var barHandler: NavigationBarHandler = SlidingBarHandler()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        transitionCoordinator()?.animateAlongsideTransition({ context in
            self.barHandler.animateViewAppearing(context, navigationController: self.navigationController)
            }, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        transitionCoordinator()?.animateAlongsideTransition({ context in
            self.barHandler.animateViewDisappearing(context, navigationController: self.navigationController)
            }, completion: { context in
                self.barHandler.animateViewDisappearingComplete(context)
        })
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
