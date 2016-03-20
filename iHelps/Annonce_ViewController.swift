//
//  Annonce_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 16/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class Annonce_ViewController: UIViewController {

    let facade = Facade()
    var service : ServiceGlobal?
    
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var proposeur: UILabel!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var dateDebut: UILabel!
    @IBOutlet weak var dateFin: UILabel!
    @IBOutlet weak var descriptionAnnonce: UITextView!
   
   
    @IBAction func contactPrive(sender: AnyObject) {
        facade.needConnection(self,segueName: "goMessagerie")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if ( service != nil ){
            titre.text = service?.titre
            proposeur.text = "Proposé par " + (service?.proposeur?.loginUtilisateur)!
            temps.text = service?.temps
            descriptionAnnonce.text = service?.descriptionService
        
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm" //format style. Browse online to get a format that fits your needs.
            dateFormatter.dateStyle = .LongStyle
            dateFormatter.locale = NSLocale(localeIdentifier: "fr-FR")
            dateDebut.text = dateFormatter.stringFromDate((service?.periodeDebut)!)
            dateFin.text = dateFormatter.stringFromDate((service?.periodeFin)!)
        }
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
