//
//  MessagePrive+CoreDataProperties.swift
//  iHelps
//
//  Created by nicolas catanoso on 20/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MessagePrive {

    @NSManaged var contenuMP: String?
    @NSManaged var dateMP: NSDate?
    @NSManaged var emetteur: Utilisateur?
    @NSManaged var receveur: Utilisateur?

}
