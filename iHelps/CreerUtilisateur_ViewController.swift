//
//  CreerUtilisateur_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 14/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class CreerUtilisateur_ViewController: UIViewController {

    let facade = Facade()
    
    
    @IBOutlet weak var label_error: UILabel!
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var motDePasse: UITextField!
    @IBOutlet weak var adresse: UITextField!
    
    @IBOutlet weak var maDescription: UITextView!
    @IBAction func creerUtilisateur(sender: AnyObject) {
        
        if ( login.text == "" || motDePasse.text == "" || adresse.text == "")
        {
            let alertController = facade.alerte("Merci de renseigner tous les champs ! :-)")
            self.presentViewController(alertController, animated: true, completion: nil)
        } else
        {
            var ok = true
            let users = facade.getAllUtilisateur()
            for user in users {
                if (login.text == user.loginUtilisateur ){  ok = false  }
            }
            if ( !ok ){
                let alertController = facade.alerte("L'utilisateur demandé existe déjà")
                self.presentViewController(alertController, animated: true, completion: nil)
            } else
            {
                facade.creerUtilisateur(login.text!, mdp: motDePasse.text!, adresse: adresse.text!, maDescription: maDescription.text)
                
//                label_error.text = "Compte créé !"
                
                
                
                let alertController = UIAlertController(
                    title: "iHelps",
                    message: "Compte créé :-)",
                    preferredStyle: UIAlertControllerStyle.Alert)
                
                let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel) {
                    UIAlertAction in
                    self.performSegueWithIdentifier("newService", sender: self)
                }
                
                // Add the actions
                alertController.addAction(ok)
                
                self.presentViewController(alertController, animated: true, completion: nil)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
