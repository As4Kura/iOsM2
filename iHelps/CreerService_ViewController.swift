//
//  CreerService_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 19/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class CreerService_ViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet var switchs: [UISwitch]!
   
    
    var categories = Facade().getAllCategorie()
    var oldTitre = ""
    
    
    @IBOutlet weak var titre: UITextField!
    @IBOutlet weak var dateDebut: UIDatePicker!
    @IBOutlet weak var dateFin: UIDatePicker!
    @IBOutlet weak var descriptionService: UITextView!
    @IBOutlet weak var tmpAConsacrer: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        for s in switchs
        {
            s.transform = CGAffineTransformMakeScale(0.75, 0.75)
            
        }

      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    
    @IBAction func validerService(sender: AnyObject) {
        let facade = Facade()
        var boolSwitch = false
        var cat : [Categorie] = []
        
        print("-----------OldTitre = \(oldTitre) et NewTitre =\(titre.text!)")
        for s in switchs
        {
            s.transform = CGAffineTransformMakeScale(0.75, 0.75)
            if s.on
            {
                boolSwitch = true
                cat.append(categories[s.tag])
            }
        }
        
        if (oldTitre == titre.text! && titre.text != ""){
            let msgAlerte = "Votre demande précédente a bien été prise en compte."
            let alertController = facade.alerte(msgAlerte)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        else if ( titre.text != "" && descriptionService.text != "" && boolSwitch && tmpAConsacrer.text != "" && tmpAConsacrer.text != "")
        {
            
          
            let aux =  dateDebut.date.timeIntervalSince1970
            let p = aux + 3600
            let periodeDebut = NSDate(timeIntervalSince1970: p)
            
            let aux2 =  dateFin.date.timeIntervalSince1970
            let p2 = aux2 + 3600
            let periodeFin = NSDate(timeIntervalSince1970: p2)
            
            

            facade.creerServiceG(facade.estConnecte()!, temps: tmpAConsacrer.text!, periodeDebut: periodeDebut, periodeFin: periodeFin, titre: titre.text!, descriptionService: descriptionService.text!, categories: cat)
            oldTitre = titre.text!
       
            
            let alertController = UIAlertController(
                title: "iHelps",
                message: "Annonce crée !",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            
            
            let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
                UIAlertAction in
            }
            
            // Add the actions
            alertController.addAction(ok)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
        
        
        }else {
            var msgAlerte = "Merci de renseigner tous les champs ! :-)"
            if(boolSwitch == false)
            {
                msgAlerte = "Veuillez selectionner au moins une catégorie"
            }
            
            let alertController = facade.alerte(msgAlerte)
            self.presentViewController(alertController, animated: true, completion: nil)        }
    }
    

}
