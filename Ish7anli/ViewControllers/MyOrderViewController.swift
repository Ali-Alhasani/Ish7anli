//
//  tmpViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/11/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    var cellIsSelected: IndexPath?

    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
   
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var weightImage: UIImageView!
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var destinationCityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.hideBackButton()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Hide the Bcc Text Field , until CC gets focused in didSelectRowAtIndexPath()
        if cellIsSelected == indexPath {
            return 125
        }
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TmpTableViewCell", owner: self, options: nil)?.first as! TmpTableViewCell
        cell.selectionStyle = .none
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        cellIsSelected = cellIsSelected == indexPath ? nil : indexPath
        tableView.beginUpdates()
        tableView.endUpdates()
    

        
        
    }
    
    @IBAction func previousButton(_ sender: Any) {
    }
    
    @IBAction func nextButton(_ sender: Any) {
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
