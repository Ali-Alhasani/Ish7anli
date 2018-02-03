//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
         if MOLHLanguage.isRTL() {
//            self.addLeftBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
//            self.addRightBarButtonWithImage(UIImage(named: "menu")!)
            self.addLeftBarButtonWithImage(UIImage(named: "notifications")!)
            self.addRightBarButtonWithImage(UIImage(named: "menu")!)
         } else{
            self.addRightBarButtonWithImage(UIImage(named: "notifications")!)
            self.addLeftBarButtonWithImage(UIImage(named: "menu")!)
       }
        

        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    

    
   
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    func setBackButton(){
        let yourBackImage = UIImage(named: "backNav")
        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    func setBackButton2(){
        let yourBackImage = UIImage(named: "leftback")
        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func hideBackButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
