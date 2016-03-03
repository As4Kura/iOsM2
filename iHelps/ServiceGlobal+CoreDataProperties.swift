//
//  ServiceGlobal+CoreDataProperties.swift
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

extension ServiceGlobal {

    @NSManaged var descriptionService: String?
    @NSManaged var idServiceGlobal: NSNumber?
    @NSManaged var periodeDebut: NSDate?
    @NSManaged var periodeFin: NSDate?
    @NSManaged var temps: String?
    @NSManaged var titre: String?
    @NSManaged var proposeur: Utilisateur?

}
