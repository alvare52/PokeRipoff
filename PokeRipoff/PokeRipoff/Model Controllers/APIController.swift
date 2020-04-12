//
//  APIController.swift
//  PokeRipoff
//
//  Created by Jorge Alvarez on 4/11/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

@objc class APIController: NSObject {

    @objc (sharedController) static let shared = APIController()

    //
    @objc func fetchRandomPokemon(completion: @escaping (JLAPokemon?, Error?) -> Void) {
        
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/gengar")!
                
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                print("ERROR: \(error)")
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                print("no data")
                return
            }
                    
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
                //let results = dictionary["results"] as! String: Any // array of array of dictionaries
                //let pokemonResults = dictionary["results"]
                //print(dictionary)
                let randomPokemon = JLAPokemon(dictionary: dictionary as! [AnyHashable : Any])
                print("pokemon.name = \(randomPokemon.name)")
                print("pokemon.identifier = \(randomPokemon.identifier)")
                print("pokemon.moves = \(randomPokemon.moves)")
                print("pokemon.sprite = \(randomPokemon.sprite)")
                print("pokemon.backSprite = \(randomPokemon.backSprite)")
                completion(randomPokemon, nil) //
            } catch {
                print("DECODE error: \(error)")
                completion(nil, NSError())
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: JLAPokemon) {
                
        var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        baseURL = baseURL.appendingPathComponent(pokemon.name)
                
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let fetchedPokemon = JLAPokemon(dictionary: dictionary)
                
                pokemon.name = fetchedPokemon.name
                pokemon.identifier = fetchedPokemon.identifier
                pokemon.sprite = fetchedPokemon.sprite
                pokemon.abilities = fetchedPokemon.abilities
                                
            } catch {
                print("DECODE error: \(error)")
                return
            }
        }.resume()
    }
}
