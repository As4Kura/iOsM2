//
//  ServicesJeProposeTableViewController.swift
//  iHelps
//
//  Created by Moi on 24/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class ServicesJeProposeTableViewController: UITableViewController {
    var servicesWaiting : [InstanceService] = []
    var servicesAccepted : [InstanceService] = []
    var servicesNotes : [InstanceService] = []
    var services : [InstanceService] = []
    
    let facade = Facade()
    var proposeur = Bool()
    
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        servicesWaiting = facade.getInstancesByStatut("waiting", util: Facade().estConnecte()!, proposeur: proposeur)
        servicesAccepted = facade.getInstancesByStatut("accepted", util: Facade().estConnecte()!, proposeur: proposeur)
        servicesNotes = facade.getInstancesByStatut("noté", util: Facade().estConnecte()!, proposeur: proposeur)
        
        services = servicesWaiting
        services.appendContentsOf(servicesAccepted)
        services.appendContentsOf(servicesNotes)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return services.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellJePropose", forIndexPath: indexPath) as! ServicesJeProposeTableViewCell
        
        let service = services[indexPath.row]
        cell.titre.text = service.serviceGlobal!.titre
        var login = ""
        var mess = "demandé par "
        if proposeur
        {
            login = (service.consommateur?.loginUtilisateur)!
            
        }
        else
        {
            login = (service.serviceGlobal?.proposeur?.loginUtilisateur)!
            mess = "proposé par "
        }

        
        cell.consommateur.text = mess + login
        // Configure the cell...
        if service.statut == "waiting"
        {
            cell.backgroundColor = UIColor.redColor()
        }
            
        else if service.statut == "accepted"
        {
            cell.backgroundColor = UIColor.blueColor()
        }

        else if service.statut == "noté"
        {
            cell.backgroundColor = UIColor.greenColor()
        }

       // cell.backgroundColor?.CGColor = [UIColor : redColor];
        return cell
        
       
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // pass any object as parameter, i.e. the tapped row
        let service = services[indexPath.row]
        let date = formaterDate(service.dateRealisation!)
        var titre = "Accepter Demande?"
        var mess = ""
       
        
        
        var login = ""
        if proposeur
        {
            login = (service.consommateur?.loginUtilisateur)!
            mess = login + " à besoin d'aide à la date du " + date
        }
        else
        {
        login = (service.serviceGlobal?.proposeur?.loginUtilisateur)!
            titre = "Demande en attente"
            mess = login + " n'a pas encore accepté votre demande du " + date
        }
        
        
        
        if service.statut == "waiting"
        {
            let alertController = UIAlertController(
                title: titre,
                message: mess,
                preferredStyle: UIAlertControllerStyle.Alert)
            
            if proposeur
            {
                
                let accept = UIAlertAction(title: "Accepter et contacter ", style: UIAlertActionStyle.Default) {
                    UIAlertAction in self.accepter(service,index: indexPath.row)
                }
                
                
                let refus = UIAlertAction(title: "Refuser", style: UIAlertActionStyle.Default) {
                    UIAlertAction in self.deleteCell(service ,index: indexPath.row)
                }
                
                // Add the actions
                alertController.addAction(accept)
                alertController.addAction(refus)
            }
                
            else
            {
                let contacter = UIAlertAction(title: "Contacter " + login, style: UIAlertActionStyle.Default) {
                    UIAlertAction in self.performSegueWithIdentifier("goMP", sender: indexPath.row)}
                
                
                let annuler = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default) {
                    UIAlertAction in }
                
                alertController.addAction(contacter)
                alertController.addAction(annuler)
            }
        
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        else if service.statut == "accepted"
        {
            let alertController = UIAlertController(
                title: "Service accepté",
                message: "Vous n'avez pas encore noté ce service" ,
                preferredStyle: UIAlertControllerStyle.Alert)
            
            
            
            let noter = UIAlertAction(title: "Noter " + login, style: UIAlertActionStyle.Default) {
                UIAlertAction in self.performSegueWithIdentifier("goNoter", sender: indexPath.row)
            }
            
            
            let contacter = UIAlertAction(title: "Contacter " + login, style: UIAlertActionStyle.Default) {
                UIAlertAction in self.performSegueWithIdentifier("goMP", sender: indexPath.row)
            }
            
            // Add the actions
            alertController.addAction(noter)
            alertController.addAction(contacter)
            
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        else {
            let alertController = UIAlertController(
                title: "Service terminé et noté",
                message: "" ,
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let contacter = UIAlertAction(title: "Contacter " + login, style: UIAlertActionStyle.Default) {
                UIAlertAction in self.performSegueWithIdentifier("goMP", sender: indexPath.row)}
            
            
            let annuler = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default) {
                UIAlertAction in }
            
            alertController.addAction(contacter)
            alertController.addAction(annuler)
            
             self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goMP" {
            let dvc = segue.destinationViewController as! MP_ViewController
            let s = services[sender as! Int]
            if(proposeur)
            {
            dvc.contact = s.consommateur
            }
            else{
                dvc.contact = s.serviceGlobal?.proposeur
            }
        }
       else if segue.identifier == "goNoter" {
            //            if let indexpath = table.indexPathForSelectedRow {
            let dvc = segue.destinationViewController as! Note_ViewController
            dvc.instance = services[sender as! Int]
            //           }
        }

       
        
    }
    
    func deleteCell(serv :InstanceService, index :Int)
    {
        
        self.facade.deleteInstance(serv);
        services.removeAtIndex(index)
        self.tableView.reloadData()
        
    }
    
    func accepter(serv :InstanceService, index :Int)
    {
        
        self.facade.modifierDemande(serv,statut: "accepted")
        self.performSegueWithIdentifier("goMP", sender: index)
        self.tableView.reloadData()
        
    }
    
    func formaterDate( date : NSDate)->String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm" //format style. Browse online to get a format that fits your needs.
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "fr-FR")
        return dateFormatter.stringFromDate(date)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
