//
//  ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 07/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    

    let facade = Facade()
    let jeu = JeuDeDonnee()
    
    @IBOutlet weak var label_error: UILabel!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var motDePasse: UITextField!
    
    @IBAction func seConnecter(sender: AnyObject) {
        
        if  let currentUser = facade.connexionUtilisateur(login.text!, mdp: motDePasse.text!)
        {
            /*print("--- UTILISATEUR CONNECTE : ---")
            print ( currentUser.loginUtilisateur )
            print ( currentUser.mdpUtilisateur )
            print ( currentUser.adresseUtilisateur )
            print("------------------------------")*/
            
            NSUserDefaults.standardUserDefaults().setObject(currentUser.loginUtilisateur, forKey: "userLogin")
            NSUserDefaults.standardUserDefaults().setObject(currentUser.mdpUtilisateur, forKey: "userMDP")
            NSUserDefaults.standardUserDefaults().synchronize()
            
                       
                        
            
//            label_error.text = "Connexion effectuée :-)"
            performSegueWithIdentifier("connexionOK", sender: self)
        } else {
            
            let alertController = facade.alerte("Connexion échouée. Vérifiez les infos saisies")
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    // Utile aussi pour la déconnexion.
    @IBAction func continuerSansSauvegarder(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userLogin")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userMDP")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userAdresse")
    }
    
    @IBAction func lancerTestsBDD(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let firstRun = NSUserDefaults.standardUserDefaults().objectForKey("firstRun")
        if firstRun == nil {
            NSUserDefaults.standardUserDefaults().setObject(true, forKey:"firstRun")
            jeu.creationJeuDonnees()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
