//
//  PokeCell.swift
//  pokedex-by-marbaez
//
//  Created by Marcos Báez Gutiérrez on 5/8/16.
//  Copyright © 2016 marbaez. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func configureYourself(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.layer.cornerRadius = 5
        
        nameLbl.text = pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
        /*nameLbl.clipsToBounds = true
        thumbImg.clipsToBounds = true*/
    }
}
