//
//  ServicesJeProposeTableViewCell.swift
//  iHelps
//
//  Created by Moi on 24/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class ServicesJeProposeTableViewCell: UITableViewCell {

    @IBOutlet weak var consommateur: UILabel!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var monimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
