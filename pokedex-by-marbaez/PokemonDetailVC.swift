//
//  PokemonDetailVCViewController.swift
//  pokedex-by-marbaez
//
//  Created by Marcos Báez Gutiérrez on 6/8/16.
//  Copyright © 2016 marbaez. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var pokeNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokeNameLbl.text = pokemon.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
