//
//  ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 07/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let testsBdd = TestsBdd ()
    let facade = Facade()
    
    @IBOutlet weak var label_error: UILabel!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var motDePasse: UITextField!
    
    @IBAction func seConnecter(sender: AnyObject) {
        
        if  let currentUser = facade.connexionUtilisateur(login.text!, mdp: motDePasse.text!)
        {
            print("--- UTILISATEUR CONNECTE : ---")
            print ( currentUser.loginUtilisateur )
            print ( currentUser.mdpUtilisateur )
            print ( currentUser.adresseUtilisateur )
            print("------------------------------")
            
            NSUserDefaults.standardUserDefaults().setObject(currentUser.loginUtilisateur, forKey: "userLogin")
            NSUserDefaults.standardUserDefaults().setObject(currentUser.mdpUtilisateur, forKey: "userMDP")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            label_error.text = "Connexion effectuée :-)"
            performSegueWithIdentifier("connexionOK", sender: self)
        } else {
            label_error.text = "Erreur de connexion"
        }
        
    }
    
    @IBAction func continuerSansSauvegarder(sender: AnyObject) {
        // remove NSUserDefaults ...
    }
    @IBAction func lancerTestsBDD(sender: AnyObject) {
        testsBdd.fonctionDeTestsEnBase()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
