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
    //facade.deleteBDD()
    
    let utilisateurs = facade.getAllUtilisateur()
    
   /* 
    
    let categories = facade.getAllCaterogie()
    
    if categories.count > 0
    {
        
        for c in categories
        {
            if let n = c.nomCategorie
            {
                print("nom:"+n)
                
            }
            
        }
        
    }*/

    
   /* if let utilisateur = facade.connexionUtilisateur("login1", mdp: "mdp0")
    {
        print("connecté !!!!!!"+utilisateur.adresseUtilisateur!)
    }
    else
    {
        print("mauvais login/mdp")
    }*/
    
    
        
    /*let mps = facade.getAllMP()
    
    if mps.count > 0
    {
        for mp in mps
        {
            
                print("contenuMP" + mp.contenuMP!)
        }
    }*/

    let services = facade.getAllServiceG()
    
  /*  if services.count > 0
    {
        
     
        
        for servG in services
        {
            for c in servG.getCategoriesAsAnArray()
            {
                print( servG.titre! + " nom categorie:"+c.nomCategorie!)
            }
            
            for m in servG.getMessagesMurAsAnArray()
            {
                print("contenu MMur:"+m.contenu!)
            }
           /* if let p = servG.proposeur
            {
                
                for serviceG in p.getServicesProposesAsAnArray()
                {
                    print("titreService>user>service0:"+serviceG.titre!)
                }
                
                
                
                for serviceRecu in p.getServicesRecusAsAnArray()
                {
                    print("commentaireServiceRecu:"+serviceRecu.commentaireConso!)
                }
            }*/
            
        }
        
    }*/
    
    
     let instancesS = facade.getAllInstanceS()
    
    
   /* if instancesS.count > 0
    {
        
        
        
        for instance in instancesS
        {
            
            if let conso = instance.consommateur
            {
               // print("description:"+instance.description)
                print("loginConso:"+conso.loginUtilisateur!)
                
                for i in instance.serviceGlobal!.getInstancesServiceAsAnArray()
                {
                    print("instance>serviceGlobal>instance:"+i.commentaireConso!)
                }
                
                for serviceRecu in conso.getServicesRecusAsAnArray()
                {
                    print("instance>consommateur>instance:"+serviceRecu.commentaireProposeur!)
                }
                
            }
        }
    }*/
}

}