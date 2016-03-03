//
//  FUtilisateur.swift
//  iHelps
//
//  Created by Moi on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class FUtilisateur{
    
    
    func creerUtilisateur(login : String , mdp : String, adresse : String )
    {
        
        let SGlobal = NSEntityDescription.insertNewObjectForEntityForName("Utilisateur", inManagedObjectContext: contexte)
        
        
        //SGlobal.setValue(1, forKey: "idUtilisateur")
        SGlobal.setValue(login, forKey: "loginUtilisateur")
        SGlobal.setValue(mdp, forKey: "mdpUtilisateur")
        SGlobal.setValue(adresse, forKey: "adresseUtilisateur")
        
        //6
        do
        {
            try contexte.save() // 5
            print ("user sauvegardé")
            
        }
        catch
        {
            print("Problème lors de la sauvegarde !")
        }
    }
    
    
    func getAllUtilisateur() ->Array<Utilisateur>
    {
        // 1
        let requete = NSFetchRequest(entityName: "Utilisateur")
        
        // 2
        //  requete.predicate = NSPredicate(format: "idServiceGlobal = %d", 1)
        
        // 3
        requete.returnsObjectsAsFaults = false
        
        do
        {
            return try contexte.executeFetchRequest(requete)as! [Utilisateur]
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return [Utilisateur] ()
        }
        
        
}

}