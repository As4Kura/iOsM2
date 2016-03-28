//
//  Home_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 16/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class Home_ViewController: UIViewController,UITabBarDelegate {

    let facade = Facade()
    
    
    @IBAction func creerService(sender: AnyObject) {
        facade.needConnection(self, segueName: "newService")
    }
 
    @IBAction func goMonCompte(sender: AnyObject) {
        facade.needConnection(self, segueName: "goMonCompte")
    }
    
    
    @IBAction func deconnexion(sender: AnyObject) {
        for view in self.view.subviews
        
        {
            view.removeFromSuperview()
            
        }
        self.performSegueWithIdentifier("goDeconnexion", sender: self)
        }
    
   
       
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if let currentUser = facade.estConnecte()
        {
            
            let instances = facade.getInstancesByStatut("waiting",util: currentUser, proposeur: true)
            if instances.count>0
            {
                let alertController = UIAlertController(
                    title: "Nouvelle demande !",
                    message: "Quelqu'un a besoin de votre aide ! :)" ,
                    preferredStyle: UIAlertControllerStyle.Alert)
                
                
                
                let aller = UIAlertAction(title: "Me rendre à mes services" , style: UIAlertActionStyle.Default) {
                    UIAlertAction in self.performSegueWithIdentifier("goMesServices", sender: self)
                }
                
                
                let annuler = UIAlertAction(title: "Plus tard" , style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                }
                
                // Add the actions
                alertController.addAction(aller)
                alertController.addAction(annuler)
                
                
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goMesServices" {
            let dvc = segue.destinationViewController as! ServicesJeProposeTableViewController
            dvc.proposeur = true
        }
      
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
