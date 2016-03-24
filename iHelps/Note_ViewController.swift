//
//  Note_ViewController.swift
//  iHelps
//
//  Created by Nicolas Opal on 24/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class Note_ViewController: UIViewController {

    @IBOutlet weak var nomService: UILabel!
    @IBOutlet weak var prenomPropo: UILabel!
    @IBOutlet weak var noteEtoiles: CosmosView!
    @IBOutlet weak var textCom: UITextView!
    @IBOutlet weak var validerReview: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Changer la note
        noteEtoiles.rating = 4
        
        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        noteEtoiles.didFinishTouchingCosmos = { rating in }
        
        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        noteEtoiles.didTouchCosmos = { rating in }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
