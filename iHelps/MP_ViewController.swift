//
//  MP_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 21/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class MP_ViewController: UIViewController {

    let facade = Facade()
    var contact : Utilisateur?
    var listMessages : [MessagePrive] = []
    var listLabel : [UILabel] = []
    var spacer :CGFloat = 75.0


    @IBOutlet weak var buttonContact: UIButton!
    @IBOutlet var myView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var messageToSend: UITextField!

       override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contact : " + (contact?.loginUtilisateur)!
        buttonContact.setTitle(contact?.loginUtilisateur, forState: .Normal)
        updateMessages()
        printMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func envoyerMsg(sender: AnyObject) {
        print("\(messageToSend.text!)")
        facade.envoyerMessagePrive(messageToSend.text!, emetteur: facade.estConnecte()!, receveur: contact!)
        updateMessages()
        printMessages()
    }

    // Affichage de tout les messages précédemment envoyés
    func updateMessages(){
        listMessages.removeAll()
//        print("Clear Messages privés : \(listMessages)")
        let messagesRecus = facade.estConnecte()?.getMpRecusAsAnArray()
        for msg in messagesRecus! {
            if ( msg.emetteur == contact ){
                listMessages.append(msg)
            }
        }

        let messagesEnvoyes = facade.estConnecte()?.getMpEnvoyesAsAnArray()
        for msg in messagesEnvoyes! {
            if (msg.receveur == contact){
                listMessages.append(msg)
            }
        }
        trierListMessages()
//        print("Messages Full : \(listMessages)")
    }

    func trierListMessages(){
        listMessages.sortInPlace({ return $0.dateMP!.earlierDate($1.dateMP!) == $0.dateMP})
    }
    // Fonction de creation de labels dynamiquement
    func printMessages(){

        for lab in listLabel{
            lab.removeFromSuperview()
        }
        listLabel.removeAll()
        spacer = 75.0

        for msg in listMessages {
            let label = UILabel(frame: CGRectMake(myView.frame.minX, 0, scroll.frame.width, 0))
            label.textColor = UIColor.whiteColor()
            label.font = UIFont(name: label.font.fontName, size: 12)
            label.text = msg.contenuMP
            label.numberOfLines = 0
            label.sizeToFit()
            
            if( msg.emetteur == facade.estConnecte()) // J'envoie !!
            {
                let label_center_x = (scroll.frame.maxX  - label.frame.width/2)
                label.center = CGPointMake(label_center_x, spacer + label.frame.height/2 )
                label.backgroundColor = UIColor(red: 0.431, green: 0.900, blue: 0.318, alpha: 1.0)
                label.textAlignment = .Right
            }else // Je recois
            {
                let label_center_x = (scroll.frame.minX  + label.frame.width/2)
                label.center = CGPointMake(label_center_x, spacer + label.frame.height/2)
                label.backgroundColor = UIColor(red: 0.988, green: 0.431, blue: 0.318, alpha: 1.0)
                label.textAlignment = .Left
            }
            
            spacer = spacer + label.frame.height + 8

            let size = CGSize(width: scroll.frame.width, height: spacer)
            self.scroll.contentSize = size

            self.scroll.addSubview(label)
            listLabel.append(label)
        }

    }
    
    
    
    @IBAction func goProfil(sender: AnyObject) {
        self.performSegueWithIdentifier("goProfil", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goProfil" {
            let dvc = segue.destinationViewController as! ProfilUtilisateurViewController
            dvc.utilisateur = contact
        }
    }


}
