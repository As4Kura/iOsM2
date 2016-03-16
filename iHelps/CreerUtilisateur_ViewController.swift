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
    
    @IBAction func creerUtilisateur(sender: AnyObject) {
        if ( login.text == "" || motDePasse.text == "" || adresse.text == "")
        {
            label_error.text = "Merci de donner tout les renseignements ! :-)"
        } else
        {
            facade.creerUtilisateur(login.text!, mdp: motDePasse.text!, adresse: adresse.text!)
            label_error.text = "Utilisateur créé"
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