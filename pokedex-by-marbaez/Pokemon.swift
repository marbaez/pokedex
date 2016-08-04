//
//  Pokemon.swift
//  pokedex-by-marbaez
//
//  Created by Marcos Báez Gutiérrez on 4/8/16.
//  Copyright © 2016 marbaez. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, id: Int) {
        _name = name
        _pokedexId = id
    }
}