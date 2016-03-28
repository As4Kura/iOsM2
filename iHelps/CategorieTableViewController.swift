//
//  CategorieTableViewController.swift
//  iHelps
//
//  Created by nicolas catanoso on 20/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class CategorieTableViewController: UITableViewController {
    let facade = Facade()
    let categories = Facade().getAllCategorie()
    
    
    @IBAction func creerService(sender: AnyObject) {
        facade.needConnection(self, segueName: "newService")
    }
    
    @IBAction func goMonCompte(sender: AnyObject) {
        facade.needConnection(self, segueName: "goMonCompte")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
       
        return categories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategorieTableViewCell", forIndexPath: indexPath) as! CategorieTableViewCell
        let categorie = categories[indexPath.row]

        cell.titreCategorie.text = categorie.nomCategorie
        if categorie.nomCategorie == "Service maison"
        {
            cell.imageCategorie.image = UIImage(named: "home.png")
        }
        else if categorie.nomCategorie == "Cours particuliers"
        {
            cell.imageCategorie.image = UIImage(named: "work.png")
        }
        else if categorie.nomCategorie == "Animaux"
        {
            cell.imageCategorie.image = UIImage(named: "animal.png")
        }
        else if categorie.nomCategorie == "Dépannage"
        {
            cell.imageCategorie.image = UIImage(named: "settings.png")
        }
        else
        {
            cell.imageCategorie.image = UIImage(named: "notebook.png")
        }

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // pass any object as parameter, i.e. the tapped row
        performSegueWithIdentifier("goAnnoncesParCategorie", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goAnnoncesParCategorie" {
            //            if let indexpath = table.indexPathForSelectedRow {
            let dvc = segue.destinationViewController as! ServiceGTableViewController
            dvc.categorie = categories[sender as! Int]
            //           }
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
