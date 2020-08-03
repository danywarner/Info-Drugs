//
//  DataService.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/16/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import Foundation
import FirebaseDatabase

let URL_BASE = "https://infodrugs.firebaseio.com"

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE: DatabaseReference = Database.database().reference(fromURL: URL_BASE)
    private var _REF_DRUGS = Database.database().reference(fromURL: "\(URL_BASE)/\(NSLocalizedString("es_drugs", comment: "drugsEndUrl"))")
    private var _REF_DATA_VERSION = Database.database().reference(fromURL: "\(URL_BASE)/dataVersion")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_DRUGS: DatabaseReference {
        return _REF_DRUGS
    }
    
    var REF_DATA_VERSION: DatabaseReference {
        return _REF_DATA_VERSION
    }
    
    


}
