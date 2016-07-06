//
//  PhotoEntry+CoreDataProperties.swift
//  PictureDiary
//
//  Created by Flatiron School on 7/5/16.
//  Copyright © 2016 theMan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PhotoEntry {

    @NSManaged var image: NSData?
    @NSManaged var date: NSDate?
    @NSManaged var entry: String?

}
