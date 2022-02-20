//
//  CharacterImageService.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/18/22.
//

import Foundation
import SwiftUI
import Combine

class CharacterImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let character: CharacterModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "characters_images"
    private let imageName: String
    
    init(character : CharacterModel) {
        self.character = character
        self.imageName = character.name
        getCharacterImage()
    }
    
    private func getCharacterImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCharacterImage()
        }
    }
    
    private func downloadCharacterImage() {
        guard let url = URL(string: character.img) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
}
