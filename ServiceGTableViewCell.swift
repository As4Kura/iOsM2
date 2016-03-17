//
//  ServiceGTableViewCell.swift
//  iHelps
//
//  Created by nicolas catanoso on 17/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class ServiceGTableViewCell: UITableViewCell {

    @IBOutlet weak var titreServiceG: UILabel!
    @IBOutlet weak var descriptionS: UILabel!
    @IBOutlet weak var nomProposeur: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
