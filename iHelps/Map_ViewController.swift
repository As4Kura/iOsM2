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
    let services = Facade().getAllServiceG()
    var currentPin = ServiceGlobal? ()
    var tableau: [MKPointAnnotation] = []
    let pinutilisateur = ColorPointAnnotation(pinColor: UIColor.blueColor())
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func creerService(sender: AnyObject) {
        if ( facade.estConnecte() == nil)
        {
            facade.needConnection(self)
        }
        else {
            self.performSegueWithIdentifier("newService", sender: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Demande d'autorisation de l'utilisateur
        self.locationManager.requestAlwaysAuthorization()
        
        // Pour l'utilisation en premier plan
        self.locationManager.requestWhenInUseAuthorization()
        
        // Centrage de la carte
        if (CLLocationManager.locationServicesEnabled().boolValue) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            if let coord  = locationManager.location?.coordinate  {
                pinutilisateur.coordinate = coord
            }
            //pinutilisateur.title = "Je suis ici !"
            self.mapView.addAnnotation(pinutilisateur)
        }
        
        mapView.delegate = self
        
        //mapView.mapType = MKMapType(rawValue: 0)!
        //mapView.setUserTrackingMode(MKUserTrackingMode(rawValue: 2)!, animated: true)
        //mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        // Génération des annotations
        getMapAnnotations()
        
        //mapView.showsUserLocation = true
        //let myLocation:MKUserLocation = mapView.userLocation
        //myLocation.title = "Je suis ici !"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        if let coord  = manager.location?.coordinate  {
            pinutilisateur.coordinate = coord
        }
        //pinutilisateur.title = "Je suis ici !"
        self.mapView.addAnnotation(pinutilisateur)
        
        let coords:CLLocationCoordinate2D = manager.location!.coordinate
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let center = CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude)
        let region = MKCoordinateRegion(center: center, span: span)
        self.mapView.setRegion(region, animated:true)
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
        if annotation is MKUserLocation {
            return nil
        }
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view!.canShowCallout = true
        } else {
            view!.annotation = annotation
        }
        
        view?.leftCalloutAccessoryView = nil
        //if (annotation.subtitle! != facade.estConnecte()?.loginUtilisateur) {
        if (CLLocationManager.locationServicesEnabled()) {
            if (annotation.subtitle! != pinutilisateur.subtitle) {
                view?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            } else {
                view?.alpha = 0.5
            }
        }
        return view
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure {
            mapView.deselectAnnotation(view.annotation, animated: false)
            // vvv---vvv
            performSegueWithIdentifier("goDetailAnnonce", sender: view)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goDetailAnnonce" {
            let aux = sender as! MKAnnotationView
            
            let dvc = segue.destinationViewController as! Annonce_ViewController
            let serviceG = facade.getService(((aux.annotation?.subtitle)!)!,titre: ((aux.annotation?.title)!)!)
            dvc.service = serviceG
            
        }
    }
    
    // Récupération des informations utilisateurs
    func getMapAnnotations() {
        for s in services {
            let proposeur = s.proposeur
            let adr = proposeur!.adresseUtilisateur
            let login = proposeur!.loginUtilisateur
            
            placer(adr!, titre: s.titre!, login:login!)
        }
    }
    
    // Placement des annotations sur la map
    func placer(adr:NSString,titre: String, login:String) {
        let geocoder = CLGeocoder()
        let annotation = MKPointAnnotation()
        
        
        geocoder.geocodeAddressString(adr as String, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                annotation.coordinate = coordinates
                annotation.title = titre
                annotation.subtitle = login
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in self.mapView.addAnnotation(annotation)})
                
                self.tableau.append(annotation)
            }
        })
    }
    
}
