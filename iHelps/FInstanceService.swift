//
//  FInstanceService.swift
//  iHelps
//
//  Created by nicolas catanoso on 06/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class FInstanceService
{
    
    func creerInstanceS(consommateur: Utilisateur,serviceGlobal: ServiceGlobal, dateRealisation: NSDate,statut : String)
    {
        
        let SGlobal = NSEntityDescription.insertNewObjectForEntityForName("InstanceService", inManagedObjectContext: contexte)
        
        SGlobal.setValue(consommateur, forKey: "consommateur")
        SGlobal.setValue(serviceGlobal, forKey: "serviceGlobal")        
        SGlobal.setValue(dateRealisation, forKey: "dateRealisation")
        SGlobal.setValue(statut, forKey: "statut")
             
        
        
        do
        {
            try contexte.save()
            //print ("InstanceS sauvegardée")
            
        }
            
        catch
        {
            print("Problème lors de la sauvegarde !")
        }
    }
    
    
    func getAllInstanceS() ->Array<InstanceService>
    {
        
        let requete = NSFetchRequest(entityName: "InstanceService")
        
        
        //  requete.predicate = NSPredicate(format: "idServiceGlobal = %d", 1)
        
        requete.returnsObjectsAsFaults = false
        
        do
        {
            return try contexte.executeFetchRequest(requete)as! [InstanceService]
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return [InstanceService] ()
        }
        
        
    }
    
    
    func delete(service : InstanceService)
        
    {
        
        // let requete = NSFetchRequest(entityName: "InstanceService")
        // let deleteRequest = NSBatchDeleteRequest(fetchRequest: requete)
        
        //  requete.returnsObjectsAsFaults = false
        
        
        
        
        do
        {
            try contexte.deleteObject(service)            // print("titreS:" + services[0].titre!)
            
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            
        }
        
    }
    
    
    func accepterDemande(service : InstanceService)
        
    {
        
        // let requete = NSFetchRequest(entityName: "InstanceService")
        // let deleteRequest = NSBatchDeleteRequest(fetchRequest: requete)
        
        //  requete.returnsObjectsAsFaults = false
        let s = service as NSManagedObject
        
        s.setValue("accepted", forKey: "statut")
        
        
        
        do
        {
            try contexte.save()            // print("titreS:" + services[0].titre!)
            
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            
        }
        
    }


    
    
    
    func getInstancesByStatutAndProposeur(statut : String, util: Utilisateur)->Array<InstanceService>
        
    {
        
        
        let requete = NSFetchRequest(entityName: "InstanceService")
        
        requete.predicate = NSPredicate(format: "(statut like %@) AND (serviceGlobal.proposeur = %@)", statut,util)
        requete.returnsObjectsAsFaults = false
        
        
        
        
        do
        {
            return try contexte.executeFetchRequest(requete)as! [InstanceService]
            // print("titreS:" + services[0].titre!)
            
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return [InstanceService] ()
        }
        
    }

    
    func getInstancesByStatutAndConsommateur(statut : String, util: Utilisateur)->Array<InstanceService>
        
    {
        
        
        let requete = NSFetchRequest(entityName: "InstanceService")
        
        requete.predicate = NSPredicate(format: "(statut like %@) AND (consommateur = %@)", statut,util)
        requete.returnsObjectsAsFaults = false
        
        
        
        
        do
        {
            return try contexte.executeFetchRequest(requete)as! [InstanceService]
            // print("titreS:" + services[0].titre!)
            
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return [InstanceService] ()
        }
        
    }

    
    
    func consoNoteCommenteProposeur(instanceS : NSManagedObject , note : Int, commentaire : String)
    {
        instanceS.setValue(note, forKey: "noteConso")
        instanceS.setValue(commentaire, forKey: "commentaireConso")
        
        do
        {
            try contexte.save()
            //print ("consoNoteComment Ajouté")
            
        }
        catch
        {
            print("Problème lors de la modification !")
        }
        
    }
    
    
    
    func proposeurNoteCommenteConso(instanceS : NSManagedObject , note : Int, commentaire : String)
    {
        instanceS.setValue(note, forKey: "noteProposeur")
        instanceS.setValue(commentaire, forKey: "commentaireProposeur")
        
        do
        {
            try contexte.save()
            //  print ("proposeurNoteComment Ajouté")
            
        }
        catch
        {
            print("Problème lors de la modification !")
        }
        
    }

    
}
