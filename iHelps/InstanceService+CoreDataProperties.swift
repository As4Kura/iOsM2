//
//  InstanceService+CoreDataProperties.swift
//  iHelps
//
//  Created by nicolas catanoso on 23/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension InstanceService {

    @NSManaged var commentaireConso: String?
    @NSManaged var commentaireProposeur: String?
    @NSManaged var dateRealisation: NSDate?
    @NSManaged var noteConso: NSNumber?
    @NSManaged var noteProposeur: NSNumber?
    @NSManaged var statut: String?
    @NSManaged var consommateur: Utilisateur?
    @NSManaged var serviceGlobal: ServiceGlobal?

}
