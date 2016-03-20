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
        
     }

}
