//
//  CharacterDataService.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/18/22.
//

import Foundation
import Combine

class CharacterDataService{
    
    @Published var allCharacters: [CharacterModel] = []
    
    var characterSubscription: AnyCancellable?
    
    init() {
        getCharacters()
    }
    
    func getCharacters() {
        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else { return }
        
        characterSubscription = NetworkingManager.download(url: url)
            .decode(type: [CharacterModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCharacters) in
                self?.allCharacters = returnedCharacters
                self?.characterSubscription?.cancel()
            })
    }
    
}
