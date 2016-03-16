//
//  Home_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 16/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class Home_ViewController: UIViewController {

    let facade = Facade()
    
    
    @IBAction func creerService(sender: AnyObject) {
        facade.needConnection(self, segueName: "newService")
    }
 
    @IBAction func goMonCompte(sender: AnyObject) {
        facade.needConnection(self, segueName: "goMonCompte")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = facade.estConnecte()
        print ( " Home_ViewController login : \(user?.loginUtilisateur)" )
        print ( " Home_ViewController Mot de Passe : \(user?.mdpUtilisateur)" )
        print ( " Home_ViewController Adresse : \(user?.adresseUtilisateur)" )
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
