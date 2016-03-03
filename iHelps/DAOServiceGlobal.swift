//
//  DAO.swift
//  iHelps
//
//  Created by Moi on 02/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

//2
let contexte: NSManagedObjectContext = appDel.managedObjectContext

class DAOServiceGlobal{
    
    func creerServiceG(temps : String, periodeDebut : NSDate , periodeFin : NSDate ,titre : String , descriptionService : String)
    {
        
        //3
        let SGlobal = NSEntityDescription.insertNewObjectForEntityForName("ServiceGlobal", inManagedObjectContext: contexte)
        
        //4
        //SGlobal.setValue(1, forKey: "idServiceGlobal")
        SGlobal.setValue(titre, forKey: "titre")
        SGlobal.setValue(descriptionService, forKey: "descriptionService")
        SGlobal.setValue(temps, forKey: "temps")
        SGlobal.setValue(periodeDebut, forKey: "periodeDebut")
        SGlobal.setValue(periodeFin, forKey: "periodeFin")
        
        
        
        //6
        do {
            try contexte.save() // 5
            print ("sauvegardé")
            
        } catch {
            print("Problème lors de la sauvegarde !")
        }
    }
    
    func retrieve() {
        // 1
        let requete = NSFetchRequest(entityName: "ServiceGlobal")
        
        // 2
        //  requete.predicate = NSPredicate(format: "idServiceGlobal = %d", 1)
        
        // 3
        requete.returnsObjectsAsFaults = false
        
        do {
            let resultats = try contexte.executeFetchRequest(requete) // 4
            
            // 5
            if resultats.count > 0 {
                for resultat in resultats as! [NSManagedObject] { // 6
                    print(resultat.valueForKey("titre")!) // 7
                    if let t = resultat.valueForKey("temps")
                    {
                        print(t)
                    }
                }
            }
        } catch {
            print("Echec de la requête Fetch !")
        }
        
    }
    
    
}
