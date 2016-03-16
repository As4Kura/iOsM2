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
    
    
    func creerCategorie(nomCategorie : String)
    {
        fServiceG.creerCategorie(nomCategorie)
    }
    ////
    
    
    //UTILISATEUR//
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
    
    func creerUtilisateur(login : String , mdp : String, adresse : String )
    {
       fUtilisateur.creerUtilisateur(login , mdp: mdp , adresse: adresse )        
    }
    
    func getAllUtilisateur() ->Array<Utilisateur>
    {
        return fUtilisateur.getAllUtilisateur()
    }
    ////
    
    
    //INSTANCESERVICES//
    func getAllInstanceS()-> Array<InstanceService>
    {
        return fInstanceS.getAllInstanceS()
    }    
    
    func creerInstanceS(consommateur : Utilisateur,serviceGlobal: ServiceGlobal, dateRealisation: NSDate , noteConso: Int, commentaireConso: String , noteProposeur: Int ,commentaireProposeur: String)

    {
        fInstanceS.creerInstanceS(consommateur ,serviceGlobal : serviceGlobal, dateRealisation: dateRealisation , noteConso: noteConso, commentaireConso: commentaireConso , noteProposeur: noteProposeur ,commentaireProposeur: commentaireProposeur )
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
