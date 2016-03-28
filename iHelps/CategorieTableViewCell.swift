//
//  CategorieTableViewCell.swift
//  iHelps
//
//  Created by nicolas catanoso on 20/03/2016.
//  Copyright © 2016 NXN. All rights reserved.
//

import UIKit

class CategorieTableViewCell: UITableViewCell {

    @IBOutlet weak var titreCategorie: UILabel!
    @IBOutlet weak var imageCategorie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
