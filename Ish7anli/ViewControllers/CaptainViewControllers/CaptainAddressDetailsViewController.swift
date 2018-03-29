//
//  CaptainAddressDetailsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/31/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import GoogleMaps
class CaptainAddressDetailsViewController: UIViewController {
    @IBOutlet weak var addressNameText: UITextField!
    @IBOutlet weak var addressDetailsText: UITextField!
    
    @IBOutlet weak var googleMapView: GMSMapView!
    var mapView2:GMSMapView?
    
    var lat:Double?
    var lng:Double?
    var addressName,addressDetails:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        addressNameText.text = addressName
        addressDetailsText.text = addressDetails
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadMap()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.setBackButton2()
//        
//    }
    
    func loadMap(){
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lng!, zoom: 12.0)
        mapView2 = GMSMapView.map(withFrame: self.googleMapView.bounds, camera: camera)
        //self.mapView?.delegate = self
        self.googleMapView.addSubview(mapView2!)
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat!, longitude: lng!))
        marker.map = mapView2
        
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
