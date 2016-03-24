//
//  CosmosSize.swift
//  iHelps
//
//  Created by Nicolas Opal on 24/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

// ----------------------------
//
// CosmosSize.swift
//
// ----------------------------

import UIKit

/**
 
 Helper class for calculating size for the cosmos view.
 
 */
class CosmosSize {
    /**
     
     Calculates the size of the cosmos view. It goes through all the star and text layers and makes size the view size is large enough to show all of them.
     
     */
    class func calculateSizeToFitLayers(layers: [CALayer]) -> CGSize {
        var size = CGSize()
        
        for layer in layers {
            if layer.frame.maxX > size.width {
                size.width = layer.frame.maxX
            }
            
            if layer.frame.maxY > size.height {
                size.height = layer.frame.maxY
            }
        }
        
        return size
    }
}

