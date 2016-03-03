//
//  Facade.swift
//  iHelps
//
//  Created by Moi on 03/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import Foundation
class Facade
{
    let fServiceG = FServiceGlobal()
    
    func creerServiceG(temps : String, periodeDebut : NSDate , periodeFin : NSDate ,titre : String , descriptionService : String)
    {
        fServiceG.creerServiceG(temps, periodeDebut : periodeDebut , periodeFin : periodeFin ,titre : titre , descriptionService : descriptionService)
        //(temps, pD : periodeDebut, pF : periodeFin,tit : titre, dS : descriptionService)
    }
    
    func getAllServiceG()->Array<ServiceGlobal>
    {
        return fServiceG.getAllServiceG()
    }

}
