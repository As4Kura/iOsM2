//
//  CreerUtilisateur_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 14/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class CreerUtilisateur_ViewController: UIViewController {

    @IBOutlet weak var label_error: UILabel!
    
    @IBAction func creerUtilisateur(sender: AnyObject) {
        label_error.text = "We did it"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
