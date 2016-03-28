//
//  ServicesJeProposeTableViewController.swift
//  iHelps
//
//  Created by Moi on 24/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit
import CoreGraphics

class ServicesJeProposeTableViewController: UITableViewController {
    var servicesWaiting : [InstanceService] = []
    var servicesAccepted : [InstanceService] = []
    var servicesNotes : [InstanceService] = []
    var services : [InstanceService] = []
    
    let facade = Facade()
    var proposeur = Bool()
    
    override func viewWillAppear(animated: Bool) {
        servicesWaiting = facade.getInstancesByStatut("waiting", util: Facade().estConnecte()!, proposeur: proposeur)
        servicesAccepted = facade.getInstancesByStatut("accepted", util: Facade().estConnecte()!, proposeur: proposeur)
        servicesNotes = facade.getInstancesByStatut("noté", util: Facade().estConnecte()!, proposeur: proposeur)
        
        services = servicesWaiting
        services.appendContentsOf(servicesAccepted)
        services.appendContentsOf(servicesNotes)

        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        var mess = "Demandé par "
        let noteString = "Note reçue de "
        if proposeur
        {
            login = (service.consommateur?.loginUtilisateur)!
            
               if service.cAnote == true
            {
            cell.note.text = noteString + String(service.noteConso!) + "/5"
            }
        }
        else
        {
            login = (service.serviceGlobal?.proposeur?.loginUtilisateur)!
            mess = "Proposé par "
            
            if service.pAnote == true
            {
                cell.note.text = noteString + String(service.noteProposeur!) + "/5"
            }
        }
        //cell.notestars.rating = Double(service.noteProposeur!)
        
        
        cell.consommateur.text = mess + login
        // Configure the cell...
        
        if servicesWaiting.contains(service)
        {
            /*
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = cell.bounds
            let color1 = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor as CGColorRef
            let color2 = UIColor.yellowColor().CGColor as CGColorRef
            gradientLayer.colors = [color1, color2]
            gradientLayer.locations = [0.7, 1.0]
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            cell.layer.addSublayer(gradientLayer)*/
            cell.monimage.backgroundColor = UIColor.yellowColor()
            cell.monimage.image = UIImage(named: "clock.png")
        }
            
        
        else if servicesAccepted.contains(service)
        {
            /*
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = cell.bounds
            let color1 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0).CGColor as CGColorRef
            let color2 = UIColor.greenColor().CGColor as CGColorRef
            gradientLayer.colors = [color1, color2]
            gradientLayer.locations = [0.7, 1.0]
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            cell.layer.addSublayer(gradientLayer)
            */
            cell.monimage.backgroundColor = UIColor.greenColor()
            cell.monimage.image = UIImage(named: "basket.png")
        }
            
            
        else if servicesNotes.contains(service)
        {
            /*
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = cell.bounds
            let color1 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0).CGColor as CGColorRef
            let color2 = UIColor.lightGrayColor().CGColor as CGColorRef
            gradientLayer.colors = [color1, color2]
            gradientLayer.locations = [0.7, 1.0]
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            cell.layer.addSublayer(gradientLayer)
            */
            cell.monimage.backgroundColor = UIColor.lightGrayColor()
            cell.monimage.image = UIImage(named: "paper.png")
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // pass any object as parameter, i.e. the tapped row
        let service = services[indexPath.row]
        let date = formaterDate(service.dateRealisation!)
        var titre = "Accepter la demande ?"
        var mess = ""
        var login = ""
        if proposeur
        {
            login = (service.consommateur?.loginUtilisateur)!
            mess = login + " a besoin d'aide à la date du " + date
        }
        else
        {
        login = (service.serviceGlobal?.proposeur?.loginUtilisateur)!
            titre = "Demande en attente"
            mess = login + " n'a pas encore accepté votre demande du " + date
        }
        
        
        
        if servicesWaiting.contains(service)
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
        
        
        else if servicesAccepted.contains(service)
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
       // self.tableView.reloadData()
        
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
