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
    
    /*
    @IBOutlet weak var labelNomService: UILabel!
    @IBOutlet weak var labelPrenomUtil: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var textCommentaire: UITextView!
    @IBOutlet weak var buttonValider: UIButton!
    */
    
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
