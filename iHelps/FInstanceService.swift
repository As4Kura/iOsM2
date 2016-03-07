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
    
    func creerInstanceS(consommateur: Utilisateur,serviceGlobal: ServiceGlobal, dateRealisation: NSDate , noteConso: Int, commentaireConso: String , noteProposeur: Int ,commentaireProposeur: String )
    {
        
        let SGlobal = NSEntityDescription.insertNewObjectForEntityForName("InstanceService", inManagedObjectContext: contexte)
        
        SGlobal.setValue(consommateur, forKey: "consommateur")
        SGlobal.setValue(serviceGlobal, forKey: "serviceGlobal")        
        SGlobal.setValue(dateRealisation, forKey: "dateRealisation")
        SGlobal.setValue(noteConso, forKey: "noteConso")
        SGlobal.setValue(commentaireConso, forKey: "commentaireConso")
        SGlobal.setValue(noteProposeur, forKey: "noteProposeur")
        SGlobal.setValue(commentaireProposeur, forKey: "commentaireProposeur")
        
        
        
        do
        {
            try contexte.save()
            print ("InstanceS sauvegardée")
            
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
    
    
}
