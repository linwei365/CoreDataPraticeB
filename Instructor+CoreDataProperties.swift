//
//  Instructor+CoreDataProperties.swift
//  CoreDataPracticeB
//
//  Created by Lin Wei on 2/13/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Instructor {

    @NSManaged var nameLast: String?
    @NSManaged var nameFirst: String?
    @NSManaged var course: NSSet?

}
