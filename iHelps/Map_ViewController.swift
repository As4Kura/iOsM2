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
import Foundation

class Map_ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    
    let facade = Facade()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Demande d'autorisation de l'utilisateur
        self.locationManager.requestAlwaysAuthorization()
        
        // Pour l'utilisation en premier plan
        self.locationManager.requestWhenInUseAuthorization()
        
        // Centrage de la carte
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        
        // Génération des annotations
        getMapAnnotations()
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
        mapView.setRegion(region, animated:true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Erreur pendant la localisation " + error.localizedDescription)
    }
    
    func locationManagerDidPauseLocationUpdates(manager: CLLocationManager) {
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view!.canShowCallout = true
        } else {
            view!.annotation = annotation
        }
        
        view?.leftCalloutAccessoryView = nil
        view?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        return view
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure {
            mapView.deselectAnnotation(view.annotation, animated: false)
            // vvv---vvv
            performSegueWithIdentifier("your segue Id to detail vc", sender: view)
        }
    }
    
    func getMapAnnotations() {
        let utilsateurs = facade.getAllUtilisateur()
        
        for u in utilsateurs {
            let adresse = u.adresseUtilisateur
            let login = u.loginUtilisateur
            
            if let adr = adresse {
                placer(adr, login:login!)
            }
        }
    }
    
    func placer(adr:NSString, login:String) {
        let geocoder = CLGeocoder()
        let annotation = MKPointAnnotation()
        var tableau: [MKPointAnnotation] = []
        
        geocoder.geocodeAddressString(adr as String, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                annotation.coordinate = coordinates
                annotation.title = login
                annotation.subtitle = adr as String
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in self.mapView.addAnnotation(annotation)})
                
                tableau.append(annotation)
            }
        })
    }
    
}
