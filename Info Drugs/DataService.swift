//
//  DataService.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/16/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://infodrugs.firebaseio.com"

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_ES_DRUGS = Firebase(url: "\(URL_BASE)/es_drugs")
    private var _REF_EN_DRUGS = Firebase(url: "\(URL_BASE)/en_drugs")
    private var _REF_DATA_VERSION = Firebase(url: "\(URL_BASE)/dataVersion")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_ES_DRUGS: Firebase {
        return _REF_ES_DRUGS
    }
    
    var REF_EN_DRUGS: Firebase {
        return _REF_EN_DRUGS
    }
    
    


}