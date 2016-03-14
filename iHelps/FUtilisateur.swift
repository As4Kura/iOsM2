//
//  FUtilisateur.swift
//  iHelps
//
//  Created by nicolas catanoso on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class FUtilisateur{
    
    
    func creerUtilisateur(login : String , mdp : String, adresse : String )
    {
        
        let SGlobal = NSEntityDescription.insertNewObjectForEntityForName("Utilisateur", inManagedObjectContext: contexte)
        
        SGlobal.setValue(login, forKey: "loginUtilisateur")
        SGlobal.setValue(mdp, forKey: "mdpUtilisateur")
        SGlobal.setValue(adresse, forKey: "adresseUtilisateur")
        
        
        do
        {
            try contexte.save()
            print ("user sauvegardé")
            
        }
        catch
        {
            print("Problème lors de la sauvegarde !")
        }
    }
    
    
    func connexion (login : String, mdp : String)-> Utilisateur?
    {
        let requete = NSFetchRequest(entityName: "Utilisateur")
        
        // 2
        requete.predicate = NSPredicate(format: "loginUtilisateur = %@", login)
        requete.predicate = NSPredicate(format: "mdpUtilisateur = %@", mdp)
        
        // 3
        requete.returnsObjectsAsFaults = false
        
        do {
            let utilisateurs = try contexte.executeFetchRequest(requete) as! [Utilisateur]
            return utilisateurs[0]
            
           }
        
        catch {
            print("Echec de la requête Fetch !")
            return nil
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