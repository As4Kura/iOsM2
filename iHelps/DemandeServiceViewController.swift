//
//  demandeServiceViewController.swift
//  iHelps
//
//  Created by Moi on 21/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class DemandeServiceViewController: UIViewController {
    let facade = Facade()
    var serviceG : ServiceGlobal?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func envoyerDemande(sender: AnyObject)
    {
                 let alertController = UIAlertController(
                    title: "iHelps",
                    message: "Demande envoyée",
                    preferredStyle: UIAlertControllerStyle.Alert)
                
                
        
                let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                }
                
                // Add the actions
                 alertController.addAction(ok)
        
        facade.creerInstanceS(facade.estConnecte()!, serviceGlobal: serviceG!, dateRealisation: NSDate())
        
        
                self.presentViewController(alertController, animated: true, completion: nil)
        
        
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
