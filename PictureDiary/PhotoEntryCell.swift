//
//  PhotoEntryCell.swift
//  PictureDiary
//
//  Created by Flatiron School on 7/5/16.
//  Copyright © 2016 theMan. All rights reserved.
//

import UIKit
import CoreData

class PhotoEntryCell: UITableViewCell {
    
    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dateFormatter = NSDateFormatter()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    }
    
    func configureWithEntry(entry: NSManagedObject) {
        
        let date = entry.valueForKey("date") as? NSDate
        let imageData = entry.valueForKey("image") as? NSData
        let dateStr = niceDateString(date!)
        let myImg = UIImage(data:imageData!)
        
        dateLabel.text = dateStr
        entryImage.image = myImg
        
    }
    
    func niceDateString(date: NSDate) -> String {
        return dateFormatter.stringFromDate(date)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
