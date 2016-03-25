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
    @IBOutlet weak var prenomPropo: UILabel!
    @IBOutlet weak var noteEtoiles: CosmosView!
    @IBOutlet weak var textCom: UITextView!
    @IBOutlet weak var validerReview: UIButton!
    
    let facade = Facade()
    
    @IBAction func enregistrerNoteEtCom(sender: AnyObject) {
        if ( textCom.text == "")
        {
            let alertController = facade.alerte("Merci d'ajouter un commentaire ! :-)")
            self.presentViewController(alertController, animated: true, completion: nil)
        } else
        {
            let instances = facade.getAllInstanceS()
            let instance = instances[0]
            let note = Int(noteEtoiles.rating)
            let commentaire = textCom.text
            let currentuser = facade.estConnecte()
            if instance.consommateur == currentuser//consomateur qui note
            {
                facade.consoNoteCommenteProposeur(instance, note: note, commentaire: commentaire)
            } else {
                facade.proposeurNoteCommenteConso(instance, note: note,commentaire: commentaire)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instances = facade.getAllInstanceS()
        let instance = instances[0]
        
        // Récupérer le prénom du proposeur du service
        let prenom = instance.serviceGlobal?.proposeur?.loginUtilisateur
        prenomPropo.text = prenom
        
        // Récupérer le nom du service
        let nom = instance.serviceGlobal?.titre
        nomService.text = nom
        
        
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
