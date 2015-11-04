//
//  myTableViewCell.swift
//  FlickrAPIExample
//
//  Created by Cina Mehrvar on 2015-11-04.
//  Copyright © 2015 Cina Mehrvar. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
