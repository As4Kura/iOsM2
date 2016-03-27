//
//  ProfilUtilisateurViewController.swift
//  iHelps
//
//  Created by nicolas catanoso on 26/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class ProfilUtilisateurViewController: UIViewController {
    var utilisateur = Utilisateur? ()

    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var noteEtoiles: CosmosView!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var maDescription: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Profil " + (utilisateur?.loginUtilisateur)!
        login.text = utilisateur?.loginUtilisateur
        maDescription.text = utilisateur?.maDescription
        let note = utilisateur?.getNote()
        
        if  note > 0
        {
            noteEtoiles.rating =  Double(note!)
            noteLabel.removeFromSuperview()
        }
            
        else
        {
            noteEtoiles.removeFromSuperview()
        }
        
        
        // Do any additional setup after loading the view.
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