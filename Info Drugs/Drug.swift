//
//  Drug.swift
//  
//
//  Created by Daniel Warner on 2/8/16.
//

import Foundation
import CoreData

class Drug: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var mixes: [String]
    @NSManaged var riskAvoiding: [String]
    @NSManaged var legal: NSObject?
    @NSManaged var addictive: [String]
    @NSManaged var risks: [String]
    @NSManaged var effects: [String]
    @NSManaged var drugDescription: [String]
}
