//
//  TestsBdd.swift
//  iHelps
//
//  Created by Moi on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation

////////////////TESTS BDD ///////////////



class TestsBdd
{

let facade = Facade()


func fonctionDeTestsEnBase()
{
    facade.deleteAllData( "ServiceGlobal")
    facade.deleteAllData( "Utilisateur")
    
    facade.creerUtilisateur("login30", mdp: "mdp1", adresse: "adresse")
    
    let resultats = Array<Utilisateur>(facade.getAllUtilisateur())
    
    if resultats.count > 0
    {
        facade.creerServiceG(resultats[0], temps: "42 ans",periodeDebut: NSDate(),periodeFin: NSDate(),titre :"1er service ",descriptionService: "description")
        facade.creerServiceG(resultats[0], temps: "42 ans",periodeDebut: NSDate(),periodeFin: NSDate(),titre :"2eme service",descriptionService: "description")
        
        var i = 0
        for resultat in resultats
        {
            if let t = resultat.loginUtilisateur
            {
                print(String(i)+"login:"+t)
                
            }
            
            i++
        }
        
    }
    
    
    let resultatsS = Array<ServiceGlobal>(facade.getAllServiceG())
    
    if resultatsS.count > 0
    {
        
        for resultat in resultatsS
        {
            if let t = resultat.titre
            {
                print("titreDepuisService:"+t)
            }
            if let l = resultat.proposeur
            {
                let Sarray = l.getServicesProposesAsAnArray()
                for service in Sarray
                {
                    print("titreService>user>service0:"+service.titre!)
                }
                
            }
            
        }
        
    }
    
}

}