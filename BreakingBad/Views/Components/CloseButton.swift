//
//  CloseButton.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/20/22.
//

import Foundation
import SwiftUI


class CloseButton : View{
    
    @State var character : CharacterModel?

    var body : some View{
        
        VStack(){
            Spacer()
            HStack{
                Spacer()
                HStack{
                    
                    Image(systemName: "heart.fill")
                        .font(.title)
                        .foregroundColor(character.isFavorite ?? false ? Color.theme.accent : Color.gray)
                        .frame(width: 80, height: 80)
                        .background(
                            Circle()
                                .foregroundColor(Color.theme.background)
                        )
                        .shadow(
                            color: Color.black.opacity(0.25),
                            radius: 10, x: 0, y: 0)
                        .onTapGesture {
                            //setAsFavorite(character: character)
                        }
                }
                Spacer()
                    .frame(width:20)
                
            }
            Spacer()
                .frame(height:20)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
