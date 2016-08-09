//
//  Pokemon.swift
//  pokedex-by-marbaez
//
//  Created by Marcos Báez Gutiérrez on 4/8/16.
//  Copyright © 2016 marbaez. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
            return _description
        }

    }
    
    var type: String {
        get {
            if _type == nil {
                _type = ""
            }
            return _type
        }

    }
    
    var height: String {
        get {
            if _height == nil {
                _height = ""
            }
            return _height
        }

    }
    
    var weight: String {
        get {
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }

    }
    
    var attack: String {
        get {
            if _attack == nil {
                _attack = ""
            }
            return _attack
        }

    }
    
    var defense: String {
        get {
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    }
    var nextEvolutionLvl: String {
        get {
            if _nextEvolutionLvl == nil {
                _nextEvolutionLvl = ""
            }
            return _nextEvolutionLvl
        }

    }
    
    var nextEvolutionId: String {
        get {
            if _nextEvolutionId == nil {
                _nextEvolutionId = ""
            }
            return _nextEvolutionId
        }

    }
    
    var nextEvolutionTxt: String {
        get {
            if _nextEvolutionTxt == nil {
                _nextEvolutionTxt = ""
            }
            return _nextEvolutionTxt
        }
    }
    
    init(name: String, id: Int) {
        _name = name
        _pokedexId = id
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: () -> ()) {
        let url = NSURL(string: self._pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                self._type = ""
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    
                    var firstType = true
                    for type in types {
                        if let typeName = type["name"] {
                            if firstType {
                                self._type =  "\(self._type)\(typeName.capitalizedString)"
                                firstType = false
                            } else {
                                self._type = "\(self._type)/\(typeName.capitalizedString)"
                            }
                        }
                    }
                    
                    //print(self._type)
                }
                
                //descriptions
                self._description = ""
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count>0 {
                    if let descUrl = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(descUrl)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let resultDesc = response.result
                            
                            if let descDict = resultDesc.value as? Dictionary<String,AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    //print(self._description)
                                }
                            }
                            
                            //calling for the callback function
                            completed()
                        }
                    }
                }
                
                //evolutions
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        //Mega evoutions are not treated
                        if to.rangeOfString("mega") == nil {
                            if let uri  = evolutions[0]["resource_uri"] {
                                let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let evoId = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionId = evoId
                                self._nextEvolutionTxt = to
                                
                                if let level = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLvl = "\(level)"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}