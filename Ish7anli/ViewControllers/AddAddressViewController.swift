//
//  AddAddressViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class AddAddressViewController: UIViewController {

    @IBOutlet weak var addressNameText: UITextField!
    @IBOutlet weak var addressDetailsText: UITextField!
    
    @IBOutlet weak var googleMapView: GMSMapView!
    var lat = 0.0
    var lng = 0.0
    private let locationManager = CLLocationManager()

    var location:String?
    // var mapView:GMSMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        googleMapView.delegate = self
        setupMap()
       //setupLocation()
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

       // mapView!.delegate = self
     

        
    }
    
    
    func load(){
        DataClient.shared.addAddress(title: addressDetailsText.text!, details: addressDetailsText.text!, longitude: lat, latitude: lng, success: {
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
extension AddAddressViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        googleMapView?.isMyLocationEnabled = true
        googleMapView?.settings.myLocationButton = true
        
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
      
                    print("Location: \(location)")
                    lat = location.coordinate.latitude
                    lng = location.coordinate.longitude
        
                let camera = GMSCameraPosition.camera(withLatitude: lat,
                                                      longitude: lng,
                                                          zoom: 12.0)
        
                    googleMapView!.camera = camera
                    googleMapView!.clear()
                    //
                    // Creates a marker in the center of the map.
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude:lat,
                                                             longitude: lng)
        
                    marker.map = googleMapView
                    marker.isDraggable = true
             // googleMapView.selectedMarker = marker
        
        // 7
       // googleMapView?.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        // 8
        locationManager.stopUpdatingLocation()
    }
}
extension AddAddressViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //mapCenterPinImage.fadeOut(0.25)
        return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        //mapCenterPinImage.fadeIn(0.25)
        googleMapView.selectedMarker = nil
        return false
    }
        func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
            lat = marker.position.latitude
            lng = marker.position.longitude
            
            print(lat)
            print(lng)
        }
}

//extension AddAddressViewController : CLLocationManagerDelegate , GMSMapViewDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //if  addressViewOpenForWhat == .new {
//            let location: CLLocation = locations.last!
//            print("Location: \(location)")
//            lat = location.coordinate.latitude
//            lng = location.coordinate.longitude
//
//        let camera = GMSCameraPosition.camera(withLatitude: lat,
//                                              longitude: lng,
//                                                  zoom: Float(12.0))
//
//            mapView!.camera = camera
//            //mapView!.clear()
//            //
//            // Creates a marker in the center of the map.
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude:lat,
//                                                     longitude: lng)
//            marker.map = mapView
//            marker.isDraggable = true
//        //}
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .restricted:
//            print("Location access was restricted.")
//        case .denied:
//            print("User denied access to location.")
//            // Display the map using the default location.
//            mapView?.isHidden = false
//        case .notDetermined:
//            print("Location status not determined.")
//        case .authorizedAlways: fallthrough
//        case .authorizedWhenInUse:
//            print("Location status is OK.")
//        }
//    }
//
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
//    {
//        print("Errors: " + error.localizedDescription)
//    }
//
//    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
//        lat = marker.position.latitude
//        lng = marker.position.longitude
//    }
//
//
//
//
//}

