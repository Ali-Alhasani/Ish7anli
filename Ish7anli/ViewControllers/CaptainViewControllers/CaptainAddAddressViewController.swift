//
//  CaptainAddAddressViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/31/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
class CaptainAddAddressViewController: UIViewController {

    @IBOutlet weak var addressNameText: UITextField!
    @IBOutlet weak var addressDetailsText: UITextField!
    
    @IBOutlet weak var googleMapView: GMSMapView!
    var lat = 0.0
    var lng = 0.0
    var locationManager: CLLocationManager = CLLocationManager()
    var location:String?
    var mapView:GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     setupLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addAddressAction(_ sender: Any) {
        if ((addressNameText.text?.isEmpty)! || (addressDetailsText.text?.isEmpty)!){
            let alert = UIAlertController(title: "Alert", message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            load()
        }
        
    }
    
    
    func setupLocation() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.distanceFilter = 50
        
        locationManager.startUpdatingLocation()
        
        locationManager.delegate = self
        
        //        if addressViewOpenForWhat == .edit{
        //
        //            if currentAddress != nil{
        //
        //                addressNameTextField.text = currentAddress.title
        //
        //                addressDetailsTextField.text = currentAddress.description
        //
        //lat = currentAddress.lattitude
        //
        //  lng = currentAddress.longitude
        //
        //            }
        //
        //        }
        
        setupMap()
        
    }
    
    private func setupMap(){
        mapView = GMSMapView()
        mapView!.isMyLocationEnabled = true
        // mapView.settings.myLocationButton = true
        //
        //        mapView.anchorSupportRTL(top: addressDetailsStack.bottomAnchor, leading: view.leadingAnchor, bottom: saveButton.topAnchor, trailing: view.trailingAnchor, paddingTop: 16, paddingLeading: 16, paddingBottom: 32, paddingTrailing: 16, width: 0, height: 0)
        
        mapView!.delegate = self
        googleMapView.addSubview(mapView!)
        
        
    }
    
    
    func load(){
        DataClient.shared.CaptainAddAddress(title: addressDetailsText.text!, details: addressDetailsText.text!, longitude: 10, latitude: 10, success: {
            self.dismiss(animated: true, completion: {
                
            })
        }) { (_ error) in
            
        }
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
extension CaptainAddAddressViewController : CLLocationManagerDelegate , GMSMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //if  addressViewOpenForWhat == .new {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        lat = location.coordinate.latitude
        lng = location.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: lng,
                                              zoom: Float(12.0))
        
        mapView!.camera = camera
        //mapView!.clear()
        //
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:lat,
                                                 longitude: lng)
        marker.map = mapView
        marker.isDraggable = true
        //}
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView?.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Errors: " + error.localizedDescription)
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        lat = marker.position.latitude
        lng = marker.position.longitude
    }
    
    
    
    
}
