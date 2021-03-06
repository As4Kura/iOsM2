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
    var listLabel : [UILabel] = []
    var listMessages : [MessageMur] = []
    var spacer :CGFloat = 0.0


    
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var proposeur: UIButton!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var dateDebut: UILabel!
    @IBOutlet weak var dateFin: UILabel!
    @IBOutlet weak var descriptionAnnonce: UITextView!
    @IBOutlet weak var goDemanderService: UIButton!
   

    @IBOutlet weak var noteEtoile: CosmosView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var messageMur: UITextField!
    
    @IBAction func goMonCompte(sender: AnyObject) {
        facade.needConnection(self,segueName: "goMonCompte")

    }
    @IBAction func contactPrive(sender: AnyObject) {
        facade.needConnection(self,segueName: "goMessagerie")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if ( service != nil ){
            
            if service?.proposeur == Facade().estConnecte()
            {
                goDemanderService.hidden = true
                proposeur.hidden = true
            }
            
            //var moyenneString = ""
            var moyenne  = 0
            var i = 0
            for instance in (service?.getInstancesServiceAsAnArray())!
            {
                if let noteConso = instance.noteConso
                {
                   if Int(noteConso) > 0
                   {
                    i += 1
                    moyenne += Int(noteConso)
                   }
                    
                }
            }
            
            if i > 0
            {
                moyenne = moyenne / i
                noteEtoile.rating =  Double(moyenne)
            }
            
           else
            {
                noteEtoile.removeFromSuperview()
            }
            
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
        self.performSegueWithIdentifier("goProfil", sender: self)
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
    
    @IBAction func creerService(sender: AnyObject) {
        if ( facade.estConnecte() == nil)
        {
            facade.needConnection(self)
        }
        else {
            self.performSegueWithIdentifier("newService", sender: self)
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
         if segue.identifier == "goDemanderService"
        {
            let dvc = segue.destinationViewController as! DemandeServiceViewController
            dvc.serviceG = service
            
        }
        
        else if segue.identifier == "goProfil"
        {
            let dvc = segue.destinationViewController as! ProfilUtilisateurViewController
            dvc.utilisateur = service?.proposeur!
            
        }
        
    }
    
   

    
    func updateMur(){
        listMessages = (service?.getMessagesMurAsAnArray())!
        trierListMessages()
        printMM()
    }
    
    

    func trierListMessages(){
        listMessages.sortInPlace({ return $0.dateMM!.earlierDate($1.dateMM!) == $0.dateMM})
    }
    
    func printMM(){
        for lab in listLabel{
            lab.removeFromSuperview()
        }
        listLabel.removeAll()
        spacer = 0.0
        
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "dd/MM/yy hh:mm"
        
        for msg in listMessages {
            let label = UILabel(frame: CGRectMake(scroll.frame.minX, 0, scroll.frame.width, 0))
            label.textColor = UIColor.whiteColor()
            label.font = UIFont(name: label.font.fontName, size: 12)
            
            
            var texte = msg.emetteur!.loginUtilisateur!
            texte += ": "
           // texte += dateFormater.stringFromDate(msg.dateMM!)
            //texte += ") --> "
            texte += msg.contenu!
            label.text = texte
            label.numberOfLines = 0
            label.sizeToFit()
            
            if( msg.emetteur == facade.estConnecte()) // J'envoie !!
            {
                let label_center_x = (scroll.frame.maxX  - label.frame.width/2)
                label.center = CGPointMake(label_center_x, spacer + label.frame.height/2 )
                label.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 0.5)
                label.textAlignment = .Right
            } else // Je recois
            {
                let label_center_x = (scroll.frame.minX  + label.frame.width/2)
                label.center = CGPointMake(label_center_x, spacer + label.frame.height/2)
                label.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
                label.textAlignment = .Left
            }
            
            if ( msg.emetteur == service?.proposeur)
            {
                label.backgroundColor = UIColor(red: 0.0, green: 0.9, blue: 0.1, alpha: 0.5)
            }
            spacer = spacer + label.frame.height + 8
            
            let size = CGSize(width: scroll.frame.width, height: spacer)
            self.scroll.contentSize = size
            
            self.scroll.addSubview(label)
            listLabel.append(label)
        }
        
    }

}
