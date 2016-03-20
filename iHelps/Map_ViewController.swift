//
//  Map_ViewController.swift
//  iHelps
//
//  Created by Nicolas Opal on 20/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Map_ViewController: UIViewController, CLLocationManagerDelegate {
/*
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
  */
    // Initialiser avec les adresses à afficher
    //var listedesadresses = [String]()
    
    let locationManager = CLLocationManager()
    /*
    var address = "1 rue Jeanne D'Arc, Orléans"
    var geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address, {(placemarks: [AnyObject]!, error: NSError!) -> Void in if let placemark = placemarks?[0] as? CLPlacemark {
            self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
        }
    })
    */
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Demande d'autorisation de l'utilisateur
        self.locationManager.requestAlwaysAuthorization()
        
        // Pour l'utilisation en premier plan
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //let initialLocatio
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated:true)
        var currentLocation = CLLocation()
        
        var locationLat = currentLocation.coordinate.latitude
        var locationLong = currentLocation.coordinate.longitude
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Erreur pendant la localisation " + error.localizedDescription)
    }
    
    func locationManagerDidPauseLocationUpdates(manager: CLLocationManager) {
        
    }
    
    /*
    func getMapAnnotations(){
        var annotations:Array = listedesadresses
        
    
        // load plist file
        var addresses: NSArray?
        
        if let items = addresses {
            for item in items {
                let lat = item.valueForKey("lat") as! Double
                let long = item.valueForKey("long") as! Double
                let annotation = Station(latitude:lat, longitude:long)
                annotation.
            }
        }
    }*/
    
   /*
    @IBAction func findMyLocation(sender:AnyObject)
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let location = self.locationManager.location
        
        var latitude: Double = location.coordinate.latitude
        var longitude: Double = location.coordinate.longitude
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
