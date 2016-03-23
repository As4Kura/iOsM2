//
//  Messagerie_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 21/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class Messagerie_ViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    let facade = Facade()
    var senders = [] as [Utilisateur]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
 
        let user = facade.estConnecte()
        let msgRecus = user?.getMpRecusAsAnArray()
        let msgEnvoyes = user?.getMpEnvoyesAsAnArray()
        
        for msg in msgRecus! {
            if ( !senders.contains(msg.emetteur!) ){
                senders.append(msg.emetteur!)
            }
        }
        for msg in msgEnvoyes! {
            if ( !senders.contains(msg.receveur!) ){
                senders.append(msg.receveur!)
            }
        }
        
        print(senders)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "messagerieCell")
        
        cell.textLabel?.text = senders[indexPath.row].loginUtilisateur
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // pass any object as parameter, i.e. the tapped row
        performSegueWithIdentifier("goMP", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goMP" {
            let dvc = segue.destinationViewController as! MP_ViewController
            dvc.contact = senders[sender as! Int]
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
