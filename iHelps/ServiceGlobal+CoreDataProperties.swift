//
//  ServiceGlobal+CoreDataProperties.swift
//  iHelps
//
//  Created by nicolas catanoso on 21/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ServiceGlobal {

    @NSManaged var descriptionService: String?
    @NSManaged var periodeDebut: NSDate?
    @NSManaged var periodeFin: NSDate?
    @NSManaged var temps: String?
    @NSManaged var titre: String?
    @NSManaged var categories: NSSet?
    @NSManaged var instancesService: NSSet?
    @NSManaged var messagesMur: NSSet?
    @NSManaged var proposeur: Utilisateur?

}
