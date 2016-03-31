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
        
        let instance = NSEntityDescription.insertNewObjectForEntityForName("InstanceService", inManagedObjectContext: contexte)
        
        instance.setValue(consommateur, forKey: "consommateur")
        instance.setValue(serviceGlobal, forKey: "serviceGlobal")        
        instance.setValue(dateRealisation, forKey: "dateRealisation")
        instance.setValue(statut, forKey: "statut")
        instance.setValue(false, forKey: "cAnote")
        instance.setValue(false, forKey: "pAnote")
             
        
        
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
        
    
        contexte.deleteObject(service)
        // print("titreS:" + services[0].titre!)
        
    }
    
 
    
    func modifierDemande(service : InstanceService, statut : String)
        
    {
        
        // let requete = NSFetchRequest(entityName: "InstanceService")
        // let deleteRequest = NSBatchDeleteRequest(fetchRequest: requete)
        
        //  requete.returnsObjectsAsFaults = false
       
            
            let s = service as NSManagedObject
            
            s.setValue(statut, forKey: "statut")
            
            
            
            do
            {
                try contexte.save()            // print("titreS:" + services[0].titre!)
                
            }
                
         catch
            {
                print("Echec de la requête Fetch !")
                
            }
       
        
    }



    
    
    func getInstancesByStatut(var statut : String, util: Utilisateur, proposeur : Bool)->Array<InstanceService>
        
    {
        
        let requete = NSFetchRequest(entityName: "InstanceService")
        
        if statut == "waiting"
        {
            
            if proposeur
            {
                requete.predicate = NSPredicate(format: "(statut like %@) AND (serviceGlobal.proposeur = %@)", statut,util)
                
            }
            else
            {
                requete.predicate = NSPredicate(format: "(statut like %@) AND (consommateur = %@)", statut,util)
            }
            
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
            
            
        else
        {
            var noteBool = false
            
            if statut == "noté"
            {
                statut = "accepted"
                noteBool = true
            }
            
            
            if proposeur
            {
                requete.predicate = NSPredicate(format: "(statut like %@) AND (serviceGlobal.proposeur = %@) AND (pAnote == %@)", statut,util,noteBool)
                
            }
            else
            {
                requete.predicate = NSPredicate(format: "(statut like %@) AND (consommateur = %@) AND (cAnote == %@)", statut,util,noteBool)
            }
            
            
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
        
            
        
        
       
    }
    
            
    
    
    func consoNoteCommenteProposeur(instanceS : InstanceService , note : Int, commentaire : String)
    {
        let instance = instanceS as NSManagedObject
        
        instance.setValue(note, forKey: "noteConso")
        instance.setValue(commentaire, forKey: "commentaireConso")
        instance.setValue(true, forKey: "cAnote")
       
        
        do
        {
            try contexte.save()
            print ("consoNoteComment Ajouté")
            print(String(note) + "/com:" + commentaire)
            
        }
        catch
        {
            print("Problème lors de la modification !")
            
        }
        
    }
    
    
    
    func proposeurNoteCommenteConso(instanceS : InstanceService , note : Int, commentaire : String)
    {
        
        let instance = instanceS as NSManagedObject
        
        instance.setValue(note, forKey: "noteProposeur")
        instance.setValue(commentaire, forKey: "commentaireProposeur")
        instance.setValue(true, forKey: "pAnote")
        
        
        do
        {
            try contexte.save()
              print ("proposeurNoteComment Ajouté")
            print(String(note) + "/com:" + commentaire)
            
        }
        catch
        {
            print("Problème lors de la modification !")
        }
        
    }

    

    
}
