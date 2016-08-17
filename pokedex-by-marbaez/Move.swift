//
//  Move.swift
//  pokedex-by-marbaez
//
//  Created by Marcos Báez Gutiérrez on 10/8/16.
//  Copyright © 2016 marbaez. All rights reserved.
//

import UIKit
import Alamofire

class Move {
    private var alreadyLoaded = false
    private var _uri: String!
    private var _name: String!
    private var _learnType: String!
    private var _description: String!
    private var _id: Int!
    private var _power: String!
    private var _pp: String!
    private var _accuracy: String!

    var accuracy: String {
        get {
            if _accuracy == nil {
                _accuracy = ""
            }
            return _accuracy
        }
    }
    
    var pp: String {
        get {
            if _pp == nil {
                _pp = ""
            }
            return _pp
        }
    }
    
    var power: String {
        get {
            if _power == nil {
                _power = ""
            }
            return _power
        }
    }
    
    var learnType: String {
        get {
            if _learnType == nil {
                _learnType = ""
            }
            return _learnType
        }
    }
    
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
            return _description
        }
    }
    
    var name: String {
        get {
            if _name == nil {
                _name = ""
            }
            return _name
        }
    }
    
    func loadMove(completed: ()->()) {
        if (alreadyLoaded) {
            completed()
        } else {
            let url = NSURL(string: self._uri)!
            Alamofire.request(.GET, url).responseJSON { response in
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject> {
                    if let accuracy = dict["accuracy"] as? Int {
                        self._accuracy = "\(accuracy)"
                    }
                    if let power = dict["power"] as? Int {
                        self._power = "\(power)"
                    }
                    if let pp = dict["pp"] as? Int {
                        self._pp = "\(pp)"
                    }
                    if let id = dict["id"] as? Int {
                        self._id = id
                    }
                    if let description = dict["description"] as? String {
                        self._description = description
                    }
                    
                    completed()
                }
            }
        }
    }
    
    init(name: String, uri: String) {
        _name = name
        _uri = "\(URL_BASE)\(uri)/"
    }
}
