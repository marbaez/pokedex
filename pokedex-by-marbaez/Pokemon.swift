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
    
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
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
                    
                    print(self._type)
                }
            }
        }
    }
}