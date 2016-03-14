//
//  ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 07/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let testsBdd = TestsBdd ()

    @IBAction func lancerTestsBDD(sender: AnyObject) {
        testsBdd.fonctionDeTestsEnBase()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
