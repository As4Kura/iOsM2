//
//  TestsBdd.swift
//  iHelps
//
//  Created by nicolas catanoso on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation

////////////////TESTS BDD ///////////////



class TestsBdd
{

let facade = Facade()


func fonctionDeTestsEnBase()
{
    facade.deleteBDD()
    
    facade.creerUtilisateur("login0", mdp: "mdp0", adresse: "adresse0")
    facade.creerUtilisateur("login1", mdp: "mdp1", adresse: "adresse1")
    
    if let utilisateur = facade.connexion("login", mdp: "iugh")
    {
        print("connecté !!!!!!"+utilisateur.adresseUtilisateur!)
    }
    else
    {
        print("mauvais login/mdp")
    }
    
    
    let utilisateurs = Array<Utilisateur>(facade.getAllUtilisateur())
    
    if utilisateurs.count > 0
    {
        facade.creerServiceG(utilisateurs[0], temps: "42 ans",periodeDebut: NSDate(),periodeFin: NSDate(),titre :"1er service ",descriptionService: "description")
        facade.creerServiceG(utilisateurs[0], temps: "42 ans",periodeDebut: NSDate(),periodeFin: NSDate(),titre :"2eme service",descriptionService: "description")
                
        
       
        for util in utilisateurs
        {
            if let u = util.loginUtilisateur
            {
                print("login:"+u)
                
            }
            
        }
        
    }
    
    
    let services = Array<ServiceGlobal>(facade.getAllServiceG())
    
    if services.count > 0
    {
        facade.creerInstanceS(utilisateurs[1], serviceGlobal: services[0], dateRealisation: NSDate(), noteConso: 6, commentaireConso: "commentaireConso1", noteProposeur:7, commentaireProposeur: "commentaireProposeur1")
        
        for servG in services
        {
            if let s = servG.titre
            {
                print("titreDepuisService:"+s)
            }
            if let p = servG.proposeur
            {
                
                for serviceG in p.getServicesProposesAsAnArray()
                {
                    print("titreService>user>service0:"+serviceG.titre!)
                }
                
                
                
                for serviceRecu in p.getServicesRecusAsAnArray()
                {
                    print("commentaireServiceRecu:"+serviceRecu.commentaireConso!)
                }
            }
            
        }
        
    }
    
    
     let instancesS = Array<InstanceService>(facade.getAllInstanceS())
    
    
    if instancesS.count > 0
    {
        for instance in instancesS
        {
            if let conso = instance.consommateur
            {
                print("description:"+instance.description)
                print("loginConso:"+conso.loginUtilisateur!)
                
                for i in instance.serviceGlobal!.getInstancesServiceAsAnArray()
                {
                    print("instance>serviceGlobal>instance:"+i.commentaireConso!)
                }
                
                for serviceRecu in conso.getServicesRecusAsAnArray()
                {
                    print("instance>consommateur>instance:"+serviceRecu.commentaireConso!)
                }
                
            }
        }
    }
}

}