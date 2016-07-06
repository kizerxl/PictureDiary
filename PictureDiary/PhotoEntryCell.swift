//
//  PhotoEntryCell.swift
//  PictureDiary
//
//  Created by Flatiron School on 7/5/16.
//  Copyright © 2016 theMan. All rights reserved.
//

import UIKit

class PhotoEntryCell: UITableViewCell {
    
    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
