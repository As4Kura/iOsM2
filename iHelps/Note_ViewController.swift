//
//  Note_ViewController.swift
//  iHelps
//
//  Created by Nicolas Opal on 24/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class Note_ViewController: UIViewController {

    @IBOutlet weak var nomService: UILabel!
   
    @IBOutlet weak var noteEtoiles: CosmosView!
    @IBOutlet weak var textCom: UITextView!
    @IBOutlet weak var validerReview: UIButton!
    @IBOutlet weak var proposeRecu: UILabel!
    
    let facade = Facade()
    var instance = InstanceService? ()
    var login = ""
    var conso = false
    var proposeRecuString = " proposé par: "
    
    @IBAction func enregistrerNoteEtCom(sender: AnyObject) {
        if ( textCom.text == "")
        {
            let alertController = facade.alerte("Merci d'ajouter un commentaire ! :-)")
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        else
        {
            let note = Int(noteEtoiles.rating)
            let commentaire = textCom.text
            
            if conso
            {
            facade.consoNoteCommenteProposeur(instance!, note: note, commentaire: commentaire)
            }
            else
            {
            facade.proposeurNoteCommenteConso(instance!, note: note,commentaire: commentaire)
            }
            
            
            
            facade.modifierDemande(instance!, statut : "noté")
            let alertController = UIAlertController(
                title: "iHelps",
                message:"Note attribuée! :-)",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in self.navigationController?.popViewControllerAnimated(true)
            }
            
              
            // Add the actions
            alertController.addAction(ok)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            // Add the actions
        
            
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentuser = facade.estConnecte()
        var login = ""
        if instance!.consommateur == currentuser//consomateur qui note
        {
            conso = true
            login =  (instance!.serviceGlobal?.proposeur?.loginUtilisateur)!
        }
        // Récupérer le prénom du proposeur du service
        else
        {
            login = (instance?.consommateur?.loginUtilisateur)!
            proposeRecuString = " reçu par: "
        }
        
       
        validerReview.setTitle((validerReview.titleLabel?.text)! + login, forState: .Normal)        // Récupérer le nom du service
        proposeRecu.text = proposeRecu.text! + proposeRecuString + login
        nomService.text = instance!.serviceGlobal?.titre
        
        
        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        noteEtoiles.didFinishTouchingCosmos = { rating in }
        
        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        noteEtoiles.didTouchCosmos = { rating in }
        
        // Changer la note
        // noteEtoiles.rating = 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
