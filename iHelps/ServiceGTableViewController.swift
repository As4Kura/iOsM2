//
//  ServiceGTableViewController.swift
//  iHelps
//
//  Created by nicolas catanoso on 17/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class ServiceGTableViewController: UITableViewController {
    
    let facade = Facade()
    var servicesG = [ServiceGlobal]()
    var categorie : Categorie?

    @IBAction func goMonCompte(sender: AnyObject) {
        facade.needConnection(self, segueName: "goMonCompte")
    }
    @IBAction func creerService(sender: AnyObject) {
        facade.needConnection(self, segueName: "newService")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleServiceG()
    }

    
    func loadSampleServiceG()
    {
        servicesG = categorie!.getServicesGAsAnArray()
        //servicesG = facade.getAllServiceG()
        //servicesG = facade.getAllServiceGByCategorie(categorie)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return servicesG.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ServiceGTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ServiceGTableViewCell

        let serviceG = servicesG[indexPath.row]
        cell.titreServiceG.text = serviceG.titre
        cell.descriptionS.text = serviceG.descriptionService
        cell.nomProposeur.text = "proposé par " + (serviceG.proposeur?.loginUtilisateur)!

        
        
        
        return cell
    }

    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // pass any object as parameter, i.e. the tapped row
        performSegueWithIdentifier("goDetailAnnonce", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goDetailAnnonce" {
            //            if let indexpath = table.indexPathForSelectedRow {
            let dvc = segue.destinationViewController as! Annonce_ViewController
            dvc.service = servicesG[sender as! Int]
            //           }g
        }
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
