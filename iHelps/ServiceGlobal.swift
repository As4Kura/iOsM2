//
//  ServiceGlobal.swift
//  iHelps
//
//  Created by nicolas catanoso on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
import CoreData


class ServiceGlobal: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func getInstancesServiceAsAnArray() ->Array<InstanceService>
    {
        return instancesService!.allObjects as! [InstanceService]
    }
}
