//
//  DAO.swift
//  iHelps
//
//  Created by nicolas catanoso on 02/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class FServiceGlobal{
    
    func creerServiceG(proposeur : Utilisateur , temps : String, periodeDebut : NSDate , periodeFin : NSDate ,titre : String , descriptionService : String, categories : [Categorie])
    {
        
        let SGlobal = NSEntityDescription.insertNewObjectForEntityForName("ServiceGlobal", inManagedObjectContext: contexte)
        
        SGlobal.setValue(titre, forKey: "titre")
        SGlobal.setValue(descriptionService, forKey: "descriptionService")
        SGlobal.setValue(temps, forKey: "temps")
        SGlobal.setValue(periodeDebut, forKey: "periodeDebut")
        SGlobal.setValue(periodeFin, forKey: "periodeFin")
        SGlobal.setValue(proposeur, forKey: "proposeur")
        SGlobal.setValue(NSSet(array: categories), forKey: "categories")
        
        
        
        do
        {
            try contexte.save()
            //print ("ServiceG sauvegardé")
            
        }
            
        catch
        {
            print("Problème lors de la sauvegarde !")
        }
    }
    
    
    
    func getAllServiceG() ->Array<ServiceGlobal>
    {
        
        let requete = NSFetchRequest(entityName: "ServiceGlobal")
        
        
        //  requete.predicate = NSPredicate(format: "idServiceGlobal = %d", 1)
        
        requete.returnsObjectsAsFaults = false
        
        do
        {
            return try contexte.executeFetchRequest(requete)as! [ServiceGlobal]
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return [ServiceGlobal] ()
        }
        
        
    }

    
    func getAllCategorie() ->Array<Categorie>
    {
        
        let requete = NSFetchRequest(entityName: "Categorie")
        
        
        //  requete.predicate = NSPredicate(format: "idServiceGlobal = %d", 1)
        
        requete.returnsObjectsAsFaults = false
        
        do
        {
            return try contexte.executeFetchRequest(requete)as! [Categorie]
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return [Categorie] ()
        }
        
        
    }

    func getService(login : String, titre : String) ->ServiceGlobal
    {
        
        let requete = NSFetchRequest(entityName: "ServiceGlobal")
        let requeteU = NSFetchRequest(entityName: "Utilisateur")
        var u = [Utilisateur]()
        var services = [ServiceGlobal]()
        
        requeteU.predicate = NSPredicate(format: "loginUtilisateur == %@", login)
        do
        {
            u =  try contexte.executeFetchRequest(requeteU)as! [Utilisateur]
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return ServiceGlobal ()
        }
        
        for e in u
        {
            print("util=" + e.loginUtilisateur!)
        }
        
        requete.predicate = NSPredicate(format: "(proposeur == %@) AND (titre like %@)", u[0],titre)
        requete.returnsObjectsAsFaults = false
        
        
        
        
        do
        {
            services =  try contexte.executeFetchRequest(requete)as! [ServiceGlobal]
            print("titreS:" + services[0].titre!)
            return services[0]
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return ServiceGlobal ()
        }
        
        
    }

        
    
}
