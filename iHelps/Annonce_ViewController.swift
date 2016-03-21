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
    @IBOutlet weak var proposeur: UIButton!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var dateDebut: UILabel!
    @IBOutlet weak var dateFin: UILabel!
    @IBOutlet weak var descriptionAnnonce: UITextView!
    @IBOutlet weak var goDemanderService: UIButton!
   
   
    @IBOutlet weak var mur: UITextView!
    @IBOutlet weak var messageMur: UITextField!
    
    @IBAction func contactPrive(sender: AnyObject) {
        facade.needConnection(self,segueName: "goMessagerie")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if ( service != nil ){
            titre.text = service?.titre
            let propName = "Proposé par " + (service?.proposeur?.loginUtilisateur)!
            proposeur.setTitle(propName, forState: .Normal)
            temps.text = service?.temps
            descriptionAnnonce.text = service?.descriptionService
        
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm" //format style. Browse online to get a format that fits your needs.
            dateFormatter.dateStyle = .LongStyle
            dateFormatter.locale = NSLocale(localeIdentifier: "fr-FR")
            dateDebut.text = dateFormatter.stringFromDate((service?.periodeDebut)!)
            dateFin.text = dateFormatter.stringFromDate((service?.periodeFin)!)
        }
        
        updateMur()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickProposeur(sender: AnyObject) {
        if ( facade.estConnecte() == nil ){
            facade.needConnection(self)
        }else {
            let alertController = UIAlertController(
                title: "iHelps",
                message: "Que voulez vous faire ?",
                preferredStyle: UIAlertControllerStyle.Alert)
        
        
            let contactPrive = UIAlertAction(title: "Contacter en privé", style: UIAlertActionStyle.Default) {
                UIAlertAction in self.performSegueWithIdentifier("goMP", sender: self)
            }
            let annuler = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default) {
                UIAlertAction in
            }
        
        // Add the actions
            alertController.addAction(contactPrive)
            alertController.addAction(annuler)
        
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func demanderService(sender: AnyObject) {
        if ( facade.estConnecte() == nil)
        {
            facade.needConnection(self)
        }
        else {
            self.performSegueWithIdentifier("goDemanderService", sender: self)
        }
    }
    

    @IBAction func publier(sender: AnyObject) {
        if ( messageMur.text != ""){
            if ( facade.estConnecte() == nil ){
                facade.needConnection(self)
            }else {
                facade.envoyerMessageMur(messageMur.text!, emetteur: facade.estConnecte()!, serviceG: service!)
                updateMur()
            }
        }else
        {
            let alertController = facade.alerte("Merci de préciser le message à envoyer")
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goMP" {
            let dvc = segue.destinationViewController as! MP_ViewController
            dvc.contact = service?.proposeur!
        }
        else if segue.identifier == "goDemanderService"
        {
            let dvc = segue.destinationViewController as! DemandeServiceViewController
            dvc.serviceG = service
   
        }
        
    }
    
   

    
    func updateMur(){
        let array = service?.getMessagesMurAsAnArray()
        var texte = ""
        array?.forEach{ mm in
            texte += (mm.emetteur?.loginUtilisateur)!
            texte += " --> "
            texte += mm.contenu!
            texte += "\n"
        }
        mur.text = texte
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
