//
//  Facade.swift
//  iHelps
//
//  Created by nicolas catanoso on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let contexte: NSManagedObjectContext = appDel.managedObjectContext

class Facade
{
    //FACADES//
    let fServiceG = FServiceGlobal()
    let fUtilisateur = FUtilisateur()
    let fInstanceS = FInstanceService()
    ////
 
    // AFFICHER UNE ALERTE
    func alerte(msg :String) -> UIAlertController
    {
        let alertController = UIAlertController(
            title: "iHelps",
            message: msg,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "J'ai compris", style: UIAlertActionStyle.Default,handler: nil))
        return alertController

    }
    
    
    func getAllMP() ->Array<MessagePrive>
    {
        
        let requete = NSFetchRequest(entityName: "MessagePrive")
        
        
                
        requete.returnsObjectsAsFaults = false
        
        do
        {
            return try contexte.executeFetchRequest(requete)as! [MessagePrive]
        }
            
        catch
        {
            print("Echec de la requête Fetch !")
            return [MessagePrive] ()
        }
        
        
    }
    
    
    //SERVICE//
    func creerServiceG(proposeur : Utilisateur, temps : String, periodeDebut : NSDate , periodeFin : NSDate ,titre : String , descriptionService : String, categories :[Categorie])
    {
        fServiceG.creerServiceG(proposeur, temps: temps, periodeDebut : periodeDebut , periodeFin : periodeFin ,titre : titre , descriptionService : descriptionService, categories : categories )
    }
    
    
    func getAllServiceG()-> Array<ServiceGlobal>
    {
        return fServiceG.getAllServiceG()
    }
    
    func getAllCategorie()-> Array<Categorie>
    {
        return fServiceG.getAllCategorie()
    }
    
    func getService(login : String, titre : String )-> ServiceGlobal
    {
        return fServiceG.getService(login, titre : titre)
    }
    
    func creerCategorie(nomCategorie : String)
    {
        
        let SGlobal = NSEntityDescription.insertNewObjectForEntityForName("Categorie", inManagedObjectContext: contexte)
        
        SGlobal.setValue(nomCategorie, forKey: "nomCategorie")
        
        do
        {
            try contexte.save()
            //print ("Categorie sauvegardée")
            
        }
            
        catch
        {
            print("Problème lors de la sauvegarde !")
        }
    }

    ////
    
    
    //UTILISATEUR//
    
    func needConnection(moi: AnyObject, segueName : String? = nil )
    {
        if (estConnecte() != nil ){
            if let s = segueName {
            moi.performSegueWithIdentifier(s, sender: moi)
            }
        }
        else // Sinon, une alerte apparait pour expliquer la situation
        {
            
            let alertController = UIAlertController(
                title: "iHelps",
                message: "Vous devez être connecté pour accéder à cette fonctionnalité",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            
            let connexionAction = UIAlertAction(title: "Se Connecter", style: UIAlertActionStyle.Default) {
                UIAlertAction in moi.performSegueWithIdentifier("goConnexion", sender: moi)
            }
            let cancelAction = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            alertController.addAction(connexionAction)
            alertController.addAction(cancelAction)
         
            moi.presentViewController(alertController, animated: true, completion: nil)
            
        }

    }
    func estConnecte()-> Utilisateur?
    {
        if let login = NSUserDefaults.standardUserDefaults().objectForKey("userLogin") as? String {
            if let mdp = NSUserDefaults.standardUserDefaults().objectForKey("userMDP") as? String {
                return connexionUtilisateur(login, mdp: mdp)
            }
        }
        return nil
    }
    
    func connexionUtilisateur (login : String, mdp : String)-> Utilisateur?
    {
        return fUtilisateur.connexionUtilisateur(login, mdp: mdp)
    }
    
    func envoyerMessageMur(contenu : String , emetteur : Utilisateur, serviceG : ServiceGlobal )
    {
        fUtilisateur.envoyerMessageMur(contenu, emetteur: emetteur, serviceG: serviceG)
    }

    
    func envoyerMessagePrive(contenu : String , emetteur : Utilisateur, receveur : Utilisateur)
    {
        fUtilisateur.envoyerMessagePrive(contenu, emetteur: emetteur, receveur : receveur)
    }

    func creerUtilisateur(login : String , mdp : String, adresse : String )
    {
       fUtilisateur.creerUtilisateur(login , mdp: mdp , adresse: adresse )        
    }
    
    func getAllUtilisateur() ->Array<Utilisateur>
    {
        return fUtilisateur.getAllUtilisateur()
    }
    
    func consoNoteCommenteProposeur(instanceS : InstanceService , note : Int, commentaire : String)
    {
        fInstanceS.consoNoteCommenteProposeur(instanceS as NSManagedObject, note: note, commentaire: commentaire)
    }
    
    func proposeurNoteCommenteConso(instanceS : InstanceService , note : Int, commentaire : String)
    {
        fInstanceS.proposeurNoteCommenteConso(instanceS as NSManagedObject, note: note, commentaire: commentaire)
    }
    ////
    
    
    //INSTANCESERVICES//
    func getAllInstanceS()-> Array<InstanceService>
    {
        return fInstanceS.getAllInstanceS()
    }    
    
    func creerInstanceS(consommateur : Utilisateur,serviceGlobal: ServiceGlobal, dateRealisation: NSDate, statut : String)

    {
        fInstanceS.creerInstanceS(consommateur ,serviceGlobal : serviceGlobal, dateRealisation: dateRealisation,statut: statut)
    }
    
    func getInstancesByStatut(statut : String, util : Utilisateur, proposeur : Bool)->Array<InstanceService>
    {
        return fInstanceS.getInstancesByStatut(statut, util : util, proposeur : proposeur)
    }
    
    
    func deleteInstance(service : InstanceService)
    {
        fInstanceS.delete(service)
    }
    
    func modifierDemande(service : InstanceService, statut : String)
    {
        fInstanceS.modifierDemande(service, statut : statut)
    }
    ////
    
    
    
    
    
    /////////CLEAR DATABASE/////////
    func deleteBDD()
    {
        deleteAllData("MessageMur")
        deleteAllData("Categorie")
        deleteAllData("InstanceService")
        deleteAllData("Utilisateur")
        deleteAllData("ServiceGlobal")
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        }
        catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
}
