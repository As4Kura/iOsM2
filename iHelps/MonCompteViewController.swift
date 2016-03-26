//
//  MonCompteViewController.swift
//  iHelps
//
//  Created by nicolas catanoso on 26/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class MonCompteViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goPropose(sender: AnyObject) {
        self.performSegueWithIdentifier("goPropose", sender: self)
    }

    @IBAction func goDemande(sender: AnyObject) {
        self.performSegueWithIdentifier("goDemande", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goPropose" {
            let dvc = segue.destinationViewController as! ServicesJeProposeTableViewController
            dvc.proposeur = true
        }
        else if segue.identifier == "goDemande"
        {
            let dvc = segue.destinationViewController as! ServicesJeProposeTableViewController
            dvc.proposeur = false
            
        }
        
    }

}
