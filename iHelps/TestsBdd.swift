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
    
    facade.creerCategorie("Babysitting")
    facade.creerCategorie("Cours particuliers")
    facade.creerCategorie("Entretien maison")
    facade.creerCategorie("Animaux")
    facade.creerCategorie("Dépannage")
    facade.creerCategorie("Autre")
    
    let categories = facade.getAllCategorie()
    let deuxCat = [Categorie](arrayLiteral: categories [0],categories [1])
    var quatreCat = [Categorie](deuxCat)
    quatreCat.append(categories [2])
    quatreCat.append(categories [3])
    
    
    /*if categories.count > 0
    {
        
        for c in categories
        {
            if let n = c.nomCategorie
            {
                print("nom:"+n)
                
            }
            
        }
        
    }*/

    
    if let utilisateur = facade.connexionUtilisateur("login0", mdp: "mdp0")
    {
        print("connecté !!!!!!"+utilisateur.adresseUtilisateur!)
    }
    else
    {
        print("mauvais login/mdp")
    }
    
    
    let utilisateurs = facade.getAllUtilisateur()
    
    if utilisateurs.count > 1
    {
        
        
        facade.creerServiceG(utilisateurs[0], temps: "2h",periodeDebut: NSDate(),periodeFin: NSDate(),titre :"garde d'enfants, hmmm",descriptionService: "mettre des somniferes dans le biberon",categories: deuxCat)
        facade.creerServiceG(utilisateurs[0], temps: "3h",periodeDebut: NSDate(),periodeFin: NSDate(),titre :"cours de chat",descriptionService: "dormir,rien faire, dormir",categories : quatreCat)
    }
    
    
    let services = facade.getAllServiceG()
    
    if services.count > 0
    {
        
        
        
        facade.creerInstanceS(utilisateurs[1], serviceGlobal: services[0], dateRealisation: NSDate())
        facade.envoyerMessageMur("wesh t fraîche madmoizel", emetteur: utilisateurs[0], serviceG: services[0])
        
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
        
    }
    
    
     let instancesS = facade.getAllInstanceS()
    
    
    if instancesS.count > 0
    {
        
        facade.proposeurNoteCommenteConso(instancesS[0], note:7, commentaire: "agrrléable!")
        facade.consoNoteCommenteProposeur(instancesS[0], note: 6, commentaire: "ca va imhotep")
        
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
    }
}

}