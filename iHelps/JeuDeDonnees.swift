//
//  File.swift
//  iHelps
//
//  Created by nicolas catanoso on 17/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation

class JeuDeDonnee
{
        
    let facade = Facade()
    
    func creationJeuDonnees()
    {
        facade.deleteBDD()
        
        facade.creerCategorie("Service maison")
        facade.creerCategorie("Cours particuliers")
        facade.creerCategorie("Animaux")
        facade.creerCategorie("Dépannage")
        facade.creerCategorie("Autre")
        
        facade.creerUtilisateur("login0", mdp: "0", adresse: "3 rue Issoudin Orleans", maDescription: "J'adore les poneys")
        facade.creerUtilisateur("login1", mdp: "1", adresse: "2 rue Madeleine Orleans", maDescription: "J'adore les furets")
        facade.creerUtilisateur("Michel", mdp: "m", adresse: "5 rue Jeanne dArc Orleans", maDescription: "J'adore les bonobos")
        facade.creerUtilisateur("Fernande", mdp: "f", adresse: "6 rue du Bourdon Blanc Orleans", maDescription: "J'adore les carottes rapées")
        facade.creerUtilisateur("Emma", mdp: "e", adresse: "1 rue Charles de Coulomb Orleans", maDescription: "J'adore les points d'exclamations !!!!!!!")
        facade.creerUtilisateur("Natacha", mdp: "n", adresse: "7 avenue du President John Kennedy Orleans", maDescription: "J'ai faim")
        facade.creerUtilisateur("Robert", mdp: "r", adresse: "8 rue Romain Rolland Orleans", maDescription: "J'adore les sushis")
        facade.creerUtilisateur("Jean", mdp: "j", adresse: "3 rue de la paix Paris", maDescription: "Oui")
        
        let categories = facade.getAllCategorie()
        let unCat = [Categorie](arrayLiteral: categories [1])
        let deuxCat = [Categorie](arrayLiteral: categories [0],categories [1])
        var quatreCat = [Categorie](deuxCat)
        quatreCat.append(categories [2])
        quatreCat.append(categories [3])
        
        let utilisateurs = facade.getAllUtilisateur()
        
        if utilisateurs.count > 1
        {
            facade.envoyerMessagePrive("Bonjour, êtes vous disponible le Samedi?", emetteur: utilisateurs[0], receveur : utilisateurs[1])
            facade.envoyerMessagePrive("Oui", emetteur: utilisateurs[1], receveur : utilisateurs[0])
            facade.envoyerMessagePrive("Est-ce que vers 15h cela irait?", emetteur: utilisateurs[0], receveur : utilisateurs[1])
            facade.envoyerMessagePrive("Parfait pour 15h", emetteur: utilisateurs[1], receveur : utilisateurs[0])
            
            facade.creerServiceG(utilisateurs[0], temps: "2h",periodeDebut: NSDate(),periodeFin: NSDate(timeIntervalSinceNow: 500000),titre :"Garde d'enfants",descriptionService: "mettre des somniferes dans le biberon",categories: deuxCat)
            facade.creerServiceG(utilisateurs[2], temps: "3h",periodeDebut: NSDate(),periodeFin: NSDate(timeIntervalSinceNow: 500000),titre :"Cours de chat",descriptionService: "dormir, rien faire, dormir",categories : quatreCat)
            facade.creerServiceG(utilisateurs[1], temps: "1h",periodeDebut: NSDate(),periodeFin: NSDate(timeIntervalSinceNow: 500000),titre :"Cours de ukulele",descriptionService: "Somewhere over the rainbow",categories : unCat)
        }

        
        let services = facade.getAllServiceG()
        
        if services.count > 0
        {
            
            facade.creerInstanceS(utilisateurs[1], serviceGlobal: services[0], dateRealisation: NSDate(timeIntervalSinceNow: 5000),statut: "waiting")
            
            facade.creerInstanceS(utilisateurs[2], serviceGlobal: services[0], dateRealisation: NSDate(timeIntervalSinceNow: 8000),statut: "accepted")
            
            facade.envoyerMessageMur("Ca marche pour les animaux?", emetteur: utilisateurs[4], serviceG: services[0])
            facade.envoyerMessageMur("Les somnifères? Oui.", emetteur: services[0].proposeur!, serviceG: services[0])
            facade.envoyerMessageMur("Ah pardon, non je gardes que les enfants", emetteur: services[0].proposeur!, serviceG: services[0])
            facade.envoyerMessageMur("J'aime pas les enfants", emetteur: utilisateurs[5], serviceG: services[0])
            
            facade.envoyerMessageMur("Combien d'expérience avez-vous?", emetteur: utilisateurs[1], serviceG: services[1])
            facade.envoyerMessageMur("9 vies", emetteur: services[1].proposeur!, serviceG: services[1])
             facade.envoyerMessageMur("LoL", emetteur: services[1].proposeur!, serviceG: services[1])
             facade.envoyerMessageMur("j'adore l'humour", emetteur: services[1].proposeur!, serviceG: services[1])
            
            /*facade.envoyerMessageMur("pijuhrgf  (1)", emetteur: utilisateurs[1], serviceG: services[0])
             facade.envoyerMessageMur("aiyhgr  (2)", emetteur: services[0].proposeur!, serviceG: services[0])
             facade.envoyerMessageMur("noij (3)", emetteur: utilisateurs[1], serviceG: services[0])
            facade.envoyerMessageMur("yfuk(4)", emetteur: services[0].proposeur!, serviceG: services[0])*/

        }
        
        
        /*let instancesS = facade.getAllInstanceS()
        
        
        if instancesS.count > 0
        {
            
            facade.proposeurNoteCommenteConso(instancesS[0], note:5, commentaire: "R.A.S.")
            facade.consoNoteCommenteProposeur(instancesS[0], note:4, commentaire: "S'est très bien passé")
                        
        }*/
     }

}
