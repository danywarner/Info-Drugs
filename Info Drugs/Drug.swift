//
//  Drug.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import Foundation

class Drug {
    private var _name: String!
    private var _effects: [String]?
    private var _risks: [String]?
    private var _addictive: [String]?
    private var _legal: [String]?
    private var _riskAvoiding: [String]?
    private var _mixes: [String]?
    
    var name: String {
        get {
                return _name
        }
        set {
            _name = newValue
        }
    }
    
    var effects: [String] {
        get {
            if _effects == nil {
                _effects = [String]()
            }
            return _effects!
        }
    }
    
    var risks: [String] {
        get {
            if _risks == nil {
                _risks = [String]()
            }
            return _risks!
        }
    }
    
    var addictive: [String] {
        get {
            if _addictive == nil {
                _addictive = [String]()
            }
            return _addictive!
        }
    }
    
    var legal: [String] {
        get {
            if _legal == nil {
                _legal = [String]()
            }
            return _legal!
        }
    }
    
    var riskAvoiding: [String] {
        get {
            if _riskAvoiding == nil {
                _riskAvoiding = [String]()
            }
            return _riskAvoiding!
        }
    }
    
    var mixes: [String] {
        get {
            if _mixes == nil {
                _mixes = [String]()
            }
            return _mixes!
        }
    }
    
    init(name: String) {
        _name = name
    }
}