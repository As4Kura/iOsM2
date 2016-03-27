//
//  Utilisateur.swift
//  iHelps
//
//  Created by nicolas catanoso on 03/03/2016.
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
    
    func getServicesRecusAsAnArray() ->Array<InstanceService>
    {
        return servicesRecus!.allObjects as! [InstanceService]
    }
    
    func getMpRecusAsAnArray() ->Array<MessagePrive>
    {
        return mpRecus!.allObjects as! [MessagePrive]
    }
    
    func getMpEnvoyesAsAnArray() ->Array<MessagePrive>
    {
        return mpEnvoyes!.allObjects as! [MessagePrive]
    }
    
    
    func getNote() ->Int
    {
        var index = 0
        var note = 0
        
        for i in getServicesRecusAsAnArray()
        {
            note += Int(i.noteProposeur!)
            index++
        }
        
        for servicesG in getServicesProposesAsAnArray()
        {
            for i in servicesG.getInstancesServiceAsAnArray()
            {
                note += Int(i.noteConso!)
                index++
            }
            
        }
        
        if(index != 0)
        {
            return note / index
        }
        
        return 0
    }
    
}
