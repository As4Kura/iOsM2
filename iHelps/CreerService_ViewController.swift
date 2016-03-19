//
//  CreerService_ViewController.swift
//  iHelps
//
//  Created by Xavier Ferry on 19/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class CreerService_ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var categoriePicker: UIPickerView!
    var categories = Facade().getAllCategorie()
    var idCategorie = 0
    
    @IBOutlet weak var titre: UITextField!
    @IBOutlet weak var dateDebut: UIDatePicker!
    @IBOutlet weak var dateFin: UIDatePicker!
    @IBOutlet weak var descriptionService: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriePicker.delegate = self
        categoriePicker.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        idCategorie = row
        return categories[row].nomCategorie
    }
    
    
    @IBAction func validerService(sender: AnyObject) {
        let facade = Facade()
        if ( titre.text != "" && descriptionService.text != "" )
        {
            
            var cat : [Categorie] = []
            cat.append(categories[idCategorie])
            facade.creerServiceG(facade.estConnecte()!, temps: "2 semaines", periodeDebut: dateDebut.date, periodeFin: dateFin.date, titre: titre.text!, descriptionService: descriptionService.text!, categories: cat)
        } else {
            
            let alertController = facade.alerte("Merci de donner tout les renseignements ! :-)")
            self.presentViewController(alertController, animated: true, completion: nil)        }
    }
    

}
