//
//  Categorie.swift
//  iHelps
//
//  Created by nicolas catanoso on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import CoreData


class Categorie: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func getServicesGAsAnArray() ->Array<ServiceGlobal>
    {
        return servicesG!.allObjects as! [ServiceGlobal]
    }
}
