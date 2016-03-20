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
    @IBOutlet weak var descriptionService: UITextField!
    
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
        
        if (oldTitre == titre.text!){
            let msgAlerte = "Votre demande précédente a bien été prise en compte."
            let alertController = facade.alerte(msgAlerte)
            self.presentViewController(alertController, animated: true, completion: nil)
        }  else if ( titre.text != "" && descriptionService.text != "" && boolSwitch && tmpAConsacrer.text != "" && tmpAConsacrer.text != "")
        {
            
          
         
            facade.creerServiceG(facade.estConnecte()!, temps: tmpAConsacrer.text!, periodeDebut: dateDebut.date, periodeFin: dateFin.date, titre: titre.text!, descriptionService: descriptionService.text!, categories: cat)
            oldTitre = titre.text!
            let services = facade.getAllServiceG()
            
            if services.count > 0
            {
                
                for servG in services
                {
                    for c in servG.getCategoriesAsAnArray()
                    {
                        print( servG.titre! + " nom categorie:"+c.nomCategorie!)
                    }

                }
            }
        
        
        }else {
            var msgAlerte = "Merci de donner tout les renseignements ! :-)"
            if(boolSwitch == false)
            {
                msgAlerte = "Veuillez selectionner au moins une catégorie"
            }
            
            let alertController = facade.alerte(msgAlerte)
            self.presentViewController(alertController, animated: true, completion: nil)        }
    }
    

}
