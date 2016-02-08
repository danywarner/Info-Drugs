//
//  Drug+CoreDataProperties.swift
//  
//
//  Created by Daniel Warner on 2/8/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Drug {

    @NSManaged var name: String?
    @NSManaged var mixes: NSObject?
    @NSManaged var riskAvoiding: NSObject?
    @NSManaged var legal: NSObject?
    @NSManaged var addictive: NSObject?
    @NSManaged var risks: NSObject?
    @NSManaged var effects: NSObject?
    @NSManaged var drugDescription: NSObject?

}
