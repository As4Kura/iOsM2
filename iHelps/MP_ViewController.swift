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
    
    @IBOutlet weak var messageToSend: UITextField!
    @IBOutlet weak var messages: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contact : " + (contact?.loginUtilisateur)!
        // Do any additional setup after loading the view.
        updateMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func envoyerMsg(sender: AnyObject) {
        facade.envoyerMessagePrive(messageToSend.text!, emetteur: facade.estConnecte()!, receveur: contact!)
        updateMessages()
    }

    func updateMessages(){
        let messagesRecus = facade.estConnecte()?.getMpRecusAsAnArray()
        for msg in messagesRecus! {
            listMessages.append(msg)
        }

        let messagesEnvoyes = facade.estConnecte()?.getMpEnvoyesAsAnArray()
        for msg in messagesEnvoyes! {
            listMessages.append(msg)
        }
        
   //     listMessages.sort({$0.dateMP!.timeIntervalSince1970 < $1.dateMP!.timeIntervalSince1970})
        var contenuMsg = ""
        for msg in listMessages{
            contenuMsg += msg.contenuMP!
            contenuMsg += "\n"
        }
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
