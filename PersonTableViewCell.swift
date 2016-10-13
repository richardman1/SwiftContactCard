//
//  PersonTableViewCell.swift
//  sep1
//
//  Created by Richard de Jongh on 08/09/16.
//  Copyright © 2016 Richard de Jongh. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    
    @IBOutlet internal var firstName: UILabel!
    
    @IBOutlet internal var lastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
