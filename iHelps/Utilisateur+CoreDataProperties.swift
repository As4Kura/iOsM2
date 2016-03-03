//
//  Utilisateur+CoreDataProperties.swift
//  iHelps
//
//  Created by Moi on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Utilisateur {

    @NSManaged var adresseUtilisateur: String?
    @NSManaged var idUtilisateur: NSNumber?
    @NSManaged var loginUtilisateur: String?
    @NSManaged var mdpUtilisateur: String?
    @NSManaged var servicesProposes: NSSet?

}
