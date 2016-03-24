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
    
    
    func getMapAnnotations() {
       
        
        for s in services {
            let proposeur = s.proposeur
            let adr = proposeur!.adresseUtilisateur
            let login = proposeur!.loginUtilisateur
            
                placer(adr!, titre: s.titre!, login:login!)
            
        }
    }
    
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
