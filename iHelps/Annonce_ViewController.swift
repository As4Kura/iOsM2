//
//  Annonce_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 16/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class Annonce_ViewController: UIViewController {

    let facade = Facade()
    
    @IBAction func contactPrive(sender: AnyObject) {
        facade.needConnection(self,segueName: "goMessagerie")
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
