//
//  HomeViewModel.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/18/22.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    
    private let charactersDataService = CharacterDataService();
    private let favoritesDataService = FavoritesDataService();
    
    @Published var allCharacters: [CharacterModel] = []
    @Published var favoriteCharacters: [CharacterModel] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        dataCharactersSubscribe()
    }
    
    func dataCharactersSubscribe(){
        
        charactersDataService.$allCharacters
            .combineLatest(favoritesDataService.$savedEntities, $searchText )
            .map(mapCharactersAndFilterByText)
            .sink { [weak self] (characters) in
                guard let self = self else { return }
                self.allCharacters = characters
                self.favoriteCharacters = self.filterByFavorites(characters: characters)
            }
            .store(in: &cancellables)
    }
    
   
    
    private func mapCharactersAndFilterByText(characters: [CharacterModel], favoritiesEntities: [FavoriteEntity], searchText: String) -> [CharacterModel] {
        
        var characters = characters.map{ (character) -> CharacterModel in
            var character = character;
            guard favoritiesEntities.first(where: { $0.name == character.name }) != nil else {
                return character;
            }
            character.toggleFavorite();
            return character;
        }
        
        characters = filterCharacterbyText(searchText: searchText, characters: characters)
        return characters;
        
    }
    
    private func filterCharacterbyText(searchText: String, characters: [CharacterModel]) -> [CharacterModel] {
        guard !searchText.isEmpty else {
            return characters
        }
        
        let lowercasedText = searchText.lowercased()
        
        return characters.filter { (character) -> Bool in
            return character.name.lowercased().contains(lowercasedText) ||
            character.nickname.lowercased().contains(lowercasedText) ||
            character.portrayed.lowercased().contains(lowercasedText)
        }
    }
    
    private func filterByFavorites(characters: [CharacterModel]) -> [CharacterModel]{
        return characters.filter{$0.isFavorite ?? false};
    }
    
    func saveFavorite(character : CharacterModel){
        favoritesDataService.saveFavorite(character: character)
    }
    
}
