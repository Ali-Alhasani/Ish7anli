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
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
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
               MBProgressHUD.hide(for: self.view, animated: true)
            self.dismiss(animated: true, completion: {
                
            })
        }) { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
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
extension CaptainAddAddressViewController :CLLocationManagerDelegate {
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
extension CaptainAddAddressViewController: GMSMapViewDelegate {
    
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

