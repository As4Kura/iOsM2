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

    @IBOutlet weak var dateReal: UIDatePicker!
    @IBAction func envoyerDemande(sender: AnyObject)
    {
                 let alertController = UIAlertController(
                    title: "iHelps",
                    message: "Demande envoyée",
                    preferredStyle: UIAlertControllerStyle.Alert)
                
                
        
                let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
                    UIAlertAction in self.navigationController?.popViewControllerAnimated(true)
                }
                
                // Add the actions
                 alertController.addAction(ok)
        
    
       let aux =  dateReal.date.timeIntervalSince1970
       let p = aux + 3600
       let dateRealisation = NSDate(timeIntervalSince1970: p)
      
        
        
        
        facade.creerInstanceS(facade.estConnecte()!, serviceGlobal: serviceG!, dateRealisation: dateRealisation, statut : "waiting"	)
        
        
                self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
        
      /*  let instancesS = facade.getAllInstanceS()
        let services = facade.getAllServiceG()
            for s in services
            {
                print("serviceG : " + String(s.periodeDebut!))
                
        }
        
        
        if instancesS.count > 0
        {
            
            
            
            for instance in instancesS
            {
                
                if let conso = instance.serviceGlobal
                {
                    // print("description:"+instance.description)
                    print("titre:" + conso.titre! + "date:" + String(instance.dateRealisation!) )
                    
                    
                    
                }
            }
        }*/
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
    }*/


}
