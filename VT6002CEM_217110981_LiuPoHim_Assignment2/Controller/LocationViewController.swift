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
        Utilities.setButtonStyle(backButton, cornerRadius: 40.0)
        
        let annotation = MKPointAnnotation();
        annotation.title = location?.title
        annotation.coordinate = CLLocationCoordinate2D(latitude: location!.latitude, longitude: location!.longitude)
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        
        
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
