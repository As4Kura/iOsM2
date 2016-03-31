//
//  ColorPointAnnotation.swift
//  iHelps
//
//  Created by Nicolas Opal on 31/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit
import MapKit

class ColorPointAnnotation: MKPointAnnotation {
    var pinColor: UIColor
    
    init(pinColor: UIColor) {
        self.pinColor = pinColor
        super.init()
    }
}