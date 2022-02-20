//
//  CharacterImage.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/18/22.
//

import Foundation
import SwiftUI

struct CharacterImageView: View{
    
    @StateObject var vm: CharacterImageViewModel
    
    init(character : CharacterModel) {
        _vm = StateObject(wrappedValue: CharacterImageViewModel(character: character))
    }
    
    var body : some View{
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipped()

            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color(uiColor: UIColor.white))
            }
        }
    }
    
    struct CharacterImageView_Previews: PreviewProvider {
        static var previews: some View {
            CharacterImageView(character: preview.mainCharacter)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }

}
