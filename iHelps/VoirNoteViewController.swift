//
//  VoirNoteViewController.swift
//  iHelps
//
//  Created by nicolas catanoso on 28/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class VoirNoteViewController: UIViewController {
var instance = InstanceService? ()
    
    @IBOutlet weak var boutonProfil: UIButton!
    @IBOutlet weak var commentaire: UITextView!
    @IBOutlet weak var etoiles: CosmosView!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var nomService: UILabel!
    
     let currentUser = Facade().estConnecte()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomService.text = instance!.serviceGlobal!.titre
        var loginU = ""
        var mess = "Demandé par "
        commentaire.text = "Vous n'avez pas encore reçu de note pour ce service"
       
        
        if instance?.serviceGlobal?.proposeur == currentUser
        {
            print("note conso ! " + String(instance?.noteConso))
            loginU = (instance!.consommateur?.loginUtilisateur)!
            etoiles.rating = Double((instance?.noteConso)!)
            
            if(instance?.cAnote == true)
            {
            commentaire.text = instance?.commentaireConso
            }
        }
            
        else
        {
            loginU = (instance!.serviceGlobal?.proposeur?.loginUtilisateur)!
            mess = "Proposé par "
            etoiles.rating = Double((instance?.noteProposeur)!)
            if(instance?.pAnote == true)
            {
                commentaire.text = instance?.commentaireProposeur
            }
        }
        //cell.notestars.rating = Double(service.noteProposeur!)
        boutonProfil.setTitle((boutonProfil.titleLabel?.text)! + loginU, forState: .Normal)
        login.text = mess + loginU

        // Do any additional setup after loading the view.
    }

    @IBAction func goProfil(sender: AnyObject) {
        self.performSegueWithIdentifier("goProfil", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goProfil" {
            let dvc = segue.destinationViewController as! ProfilUtilisateurViewController
            
             if instance?.serviceGlobal?.proposeur == currentUser
             {
            dvc.utilisateur = instance?.consommateur
            }
            else
             {
                dvc.utilisateur = instance?.serviceGlobal?.proposeur
            }
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
