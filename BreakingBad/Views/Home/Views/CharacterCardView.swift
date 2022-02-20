//
//  CharacterCardView.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/20/22.
//

import Foundation
import SwiftUI

struct CharacterCardView : View{
    
    @State var character : CharacterModel?
    let namespace: Namespace.ID
    
    var body : some View{
        if let character = character{
            VStack{
                ZStack(alignment: .bottom){
                    CharacterImageView(character: character)
                        .matchedGeometryEffect(id: character.name, in: namespace)
                        .frame(height: 300)
                        .frame(minWidth:0, maxWidth: .infinity)
                    
                    Text(character.name).foregroundColor(Color.white)
                        .font(.title2)
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .frame(minWidth:0,maxWidth:.infinity)
                        .frame(height:15)
                        .padding()
                        .background(Color.black.opacity(0.7))
                    
                }
                
                .clipShape(RoundedRectangle(cornerRadius: 10,style:.continuous))
            }
        }
    }
    
}

struct CharacterCardView_Previews :  PreviewProvider {
    @Namespace static var namespace;

    static var previews: some View {
        CharacterCardView(character: preview.mainCharacter, namespace: namespace)
            .frame(width: 200)
            .previewLayout(.sizeThatFits)

    }
}
