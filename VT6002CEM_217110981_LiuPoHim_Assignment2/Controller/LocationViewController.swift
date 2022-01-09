//
//  LocationViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/2/22.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    struct Location {
        let title : String
        let latitude : Double
        let longitude : Double
    }
    let shopList = [
        Location(title: "testlocation", latitude: 22.30, longitude: 114.177),
        Location(title: "testlocation2", latitude: 22.20, longitude: 114.170)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for shop in shopList{
            let annotation = MKPointAnnotation();
            annotation.title = shop.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
            mapView.addAnnotation(annotation)
            mapView.showAnnotations([annotation], animated: true)
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
