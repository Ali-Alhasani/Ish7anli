//
//  NewOrder2ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/30/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class NewOrder2ViewController : ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
      

        // Do any additional setup after loading the view.
        settings.style.buttonBarBackgroundColor = UIColor(named: "niceBlue")
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor(named: "niceBlue")!
        settings.style.buttonBarItemFont = UIFont(name: "DroidSansArabic", size: 16)!
        
        // settings.style.selectedBarHeight = 2
        
        settings.style.buttonBarHeight = 2
        settings.style.buttonBarMinimumLineSpacing = 0
        // settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        //
        //
          super.viewDidLoad()
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor(named: "niceBlue")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.hideBackButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //let child_1 = TableChildExampleViewController(style: .plain, itemInfo: "FOLLOWING")
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewOrder") as! NewOrderViewController
        child_1.load()
       // let child_2 = NewOrder22ViewController()
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewOrder2") as! NewOrder22ViewController
        child_2.load()
        // child_2.load()
        return [child_1,child_2]
        //, child_2]
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
