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
        
        let em = NSEntityDescription.insertNewObjectForEntityForName("Utilisateur", inManagedObjectContext: contexte)
        
        em.setValue(login, forKey: "loginUtilisateur")
        em.setValue(mdp, forKey: "mdpUtilisateur")
        em.setValue(adresse, forKey: "adresseUtilisateur")
        
        
        do
        {
            try contexte.save()
            //print ("user sauvegardé")
            
        }
        catch
        {
            print("Problème lors de la sauvegarde !")
        }
    }
    
    
    func connexionUtilisateur (login : String, mdp : String)-> Utilisateur?
    {
        let requete = NSFetchRequest(entityName: "Utilisateur")
        
        // 2
        requete.predicate = NSPredicate(format: "(loginUtilisateur == %@) AND (mdpUtilisateur like %@)", login,mdp)
                requete.returnsObjectsAsFaults = false
        
        do {
            let utilisateurs = try contexte.executeFetchRequest(requete) as! [Utilisateur]
            if utilisateurs.isEmpty
            {
                return nil
            }
            
            else
            {            
            return utilisateurs[0]
            }
            
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
    
    func envoyerMessageMur(contenu : String , emetteur : Utilisateur, serviceG : ServiceGlobal )
    {
        
        let em = NSEntityDescription.insertNewObjectForEntityForName("MessageMur", inManagedObjectContext: contexte)
        
        em.setValue(contenu, forKey: "contenu")
        em.setValue(emetteur, forKey: "emetteur")
        em.setValue(serviceG, forKey: "serviceG")
        em.setValue(NSDate(), forKey: "dateMM")
        
        
        do
        {
            try contexte.save()
            //print ("MessageMur sauvegardé")
            
        }
        catch
        {
            print("Problème lors de la sauvegarde !")
        }
    }

    
    func envoyerMessagePrive(contenu : String , emetteur : Utilisateur, receveur : Utilisateur)
    {
        
        let em = NSEntityDescription.insertNewObjectForEntityForName("MessagePrive", inManagedObjectContext: contexte)
        
        em.setValue(contenu, forKey: "contenuMP")
        em.setValue(emetteur, forKey: "emetteur")
        em.setValue(receveur, forKey: "receveur")
        
        
        do
        {
            try contexte.save()
            //print ("MessagePrive sauvegardé")
            
        }
        catch
        {
            print("Problème lors de la sauvegarde !")
        }
    }

    
    

}