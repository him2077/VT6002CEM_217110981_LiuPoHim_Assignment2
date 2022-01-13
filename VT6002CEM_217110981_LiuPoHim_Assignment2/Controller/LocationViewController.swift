//
//  LocationViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/2/22.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager : CLLocationManager?
    var location : Location?
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    struct Location {
        let title : String
        let latitude : Double
        let longitude : Double
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.setButtonStyle(backButton, cornerRadius: 35.0)
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        let annotation = MKPointAnnotation();
        annotation.title = location?.title
        annotation.coordinate = CLLocationCoordinate2D(latitude: location!.latitude, longitude: location!.longitude)
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        
        
    }
    
    func requestLocation(){
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager = CLLocationManager();
            self.locationManager?.delegate = self
            if locationManager?.authorizationStatus != .authorizedAlways{
                locationManager?.requestWhenInUseAuthorization()
            }
            else {
                self.setupAndStartLocationManager()
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .authorizedAlways, .authorizedWhenInUse:
            self.setupAndStartLocationManager()
        default:
            return
        }
    }
    
    func setupAndStartLocationManager(){
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = kCLDistanceFilterNone
        locationManager?.startUpdatingLocation()
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            let pin = "pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pin)
            if pinView == nil{
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pin)
                pinView?.canShowCallout = false
                pinView?.image = UIImage(systemName: "person.circle")
            }
            else{
                pinView?.annotation = annotation
            }
            return pinView
        }
        else{
            let pin = "pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pin) as? MKPinAnnotationView

                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pin)
                pinView?.canShowCallout = true
                pinView?.pinTintColor = UIColor.green                

                pinView?.annotation = annotation
            
            return pinView
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
