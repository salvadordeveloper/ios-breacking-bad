//
//  FavoriteCharactersService.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/19/22.
//

import Foundation
import CoreData

class FavoritesDataService{
    
    private let container: NSPersistentContainer
    private let containerName: String = "FavoritesContainer"
    private let entityName: String = "FavoriteEntity"
    
    @Published var savedEntities: [FavoriteEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getFavorites();
        }
    }
    
    func saveFavorite(character: CharacterModel) {
        if let entity = savedEntities.first(where: { $0.name == character.name }) {
            if let favorite = character.isFavorite{
                if !favorite{
                    delete(entity: entity)

                }

            }
          
        } else {
            if let favorite = character.isFavorite{
                if favorite{
                    add(character: character)
                }
            }
        }
        
    }
    
    private func getFavorites() {
        let request = NSFetchRequest<FavoriteEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        
        } catch let error {
            print("Error fetching Favorities Entities. \(error)")
        }
    }
    
    private func add(character: CharacterModel) {
        let entity = FavoriteEntity(context: container.viewContext)
        entity.name = character.name;
        applyChanges()
    }
    
    
    private func delete(entity: FavoriteEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getFavorites();
    }
}
