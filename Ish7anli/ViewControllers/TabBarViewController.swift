//
//  TabBarViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/6/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let AddOrderNewViewController = storyboard.instantiateViewController(withIdentifier: "AddOrderNewViewController") as! AddOrderNewViewController

            let navController = UINavigationController(rootViewController: AddOrderNewViewController)
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
