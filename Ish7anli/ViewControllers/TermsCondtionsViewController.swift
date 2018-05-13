//
//  TermsCondtionsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 5/2/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class TermsCondtionsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButton2()
        
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
    
    func load(){
        
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        spiningActivity.label.text = ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text = ErrorHelper.shared.message
        
        DataClient.shared.getTerms(success: { (_ terms) in
               MBProgressHUD.hide(for: self.view, animated: true)
            print(terms)
            self.textView.text = terms
        }) { (_ error) in
               MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

}
