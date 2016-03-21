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
    
    let locationManager = CLLocationManager()
    
    let facade = Facade()
    
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
            print("> Yo, Manager !")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coords:CLLocationCoordinate2D = manager.location!.coordinate
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let center = CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude)
        let region = MKCoordinateRegion(center: center, span: span)
        print("> Définition de la région !")
        mapView.setRegion(region, animated:true)
        locationManager.stopUpdatingLocation()
        getMapAnnotations()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Erreur pendant la localisation " + error.localizedDescription)
    }
    
    func locationManagerDidPauseLocationUpdates(manager: CLLocationManager) {
    }
    
    func getMapAnnotations() {
        
        let geocoder = CLGeocoder()
        let utilsateurs = facade.getAllUtilisateur()
        var tableau: [MKPointAnnotation] = []
        //var adresses: [String] = []
        //var coords: [Double:Double]
        //var span = MKCoordinateSpanMake(0.5, 0.5)
        
        for u in utilsateurs {
            let annotation = MKPointAnnotation()
            //print("> Un utilisateur !")
            let adresse = u.adresseUtilisateur
            if let adr = adresse {
                print(adr)
                geocoder.geocodeAddressString(adr, completionHandler: {(placemarks, error) -> Void in
                    if((error) != nil){
                        print("Error", error)
                    }
                    if let placemark = placemarks?.first {
                        let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                        annotation.coordinate = coordinates
                        let login = u.loginUtilisateur
                        annotation.title = login
                        annotation.subtitle = "Adresse"
                        self.mapView.addAnnotation(annotation)
                        tableau.append(annotation)
                        //print("> On est là ! - " + login!)
                    }
                })
            }
        }
        //print("> Y'a quoi dans le tableau ?")
        mapView.addAnnotations(tableau)
        for t in tableau {
            print(t)
        }
    }
}
