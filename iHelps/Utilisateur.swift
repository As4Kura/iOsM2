//
//  Utilisateur.swift
//  iHelps
//
//  Created by Moi on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import CoreData


class Utilisateur: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func getServicesProposesAsAnArray() ->Array<ServiceGlobal>
    {
        return servicesProposes!.allObjects as! [ServiceGlobal]
    }
}
