
//
//  DetailView.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/18/22.
//

import Foundation
import SwiftUI

struct DetailView : View{
    
    @Binding var showDetailView : Bool
    @State var character : CharacterModel?
    @State private var scale : CGFloat = 1;

    let namespace: Namespace.ID
    let saveFavorite: (_ characterModel : CharacterModel) -> ()
    @EnvironmentObject var orientationInfo: OrientationInfo
    var body : some View{
        
        if let character = character {
            ZStack{
                Color.theme.background.opacity(scale == 1 ? scale : scale*0.7).ignoresSafeArea()
                
                if orientationInfo.orientation == .landscape {
                    HStack(spacing: 0){
                        DetailSection(character: character)
                    }
                    
                } else{
                    ScrollView(showsIndicators: false){
                        VStack(spacing: 0){
                            DetailSection(character: character)
                        }
                    }
                }
                
                if canShowElement(){
                    CloseButton(character: character)
                    
                }
                
            }
            .ignoresSafeArea()
            .navigationTitle("")
        }
    }
    
    func canShowElement() -> Bool{
        return scale == 1 && showDetailView;
    }
    
    func setAsFavorite(character : CharacterModel){
        withAnimation{
            self.character?.toggleFavorite()
        }
        HapticManager.notification(type: .success)
    }
    
    func onChanged(value : DragGesture.Value){
        
        let scale = value.translation.height / UIScreen.main.bounds.height;
        
        if 1 - scale > 0.7 {
            self.scale = 1 - scale;
        }
    }
    
    func onEnded(value: DragGesture.Value){
        withAnimation(){
            if(scale < 0.95){
                closeDetailView();
            }
            scale = 1;
        }
    }
    
    func closeDetailView(){
        withAnimation{
            showDetailView.toggle();
        }
        if let character = character{
            self.saveFavorite(character);
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    
    @Namespace static var homeNamespace;
    @State static var showDetailView: Bool = true
    
    static var previews: some View {
        Group{
            NavigationView {
                DetailView(showDetailView: $showDetailView, character: preview.mainCharacter, namespace: homeNamespace, saveFavorite: {characterModel in })
            }.preferredColorScheme(.light)
            NavigationView {
                DetailView(showDetailView: $showDetailView, character: preview.mainCharacter, namespace: homeNamespace, saveFavorite: {characterModel in })
            }.preferredColorScheme(.dark)
        }.environmentObject(OrientationInfo())
       
    }
}

extension DetailView{
    
    func DetailSection(character : CharacterModel) -> some View{
        Group{
            ZStack(){

                CharacterImageView(character: character)
                    .matchedGeometryEffect(id: character.name, in: namespace)
                    .frame(minHeight: 0, maxHeight : UIScreen.main.bounds.size.height, alignment:.top)
                    .frame(minWidth:0, maxWidth:.infinity)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: scale == 1 ? 0 : 20,style:.continuous))
                    .scaleEffect(scale)
                    .onTapGesture(count: 2) {
                        setAsFavorite(character: character)
                    }
                    .simultaneousGesture(DragGesture(minimumDistance: 0).onChanged(onChanged(value: )).onEnded(onEnded(value: )))
                
                if canShowElement(){
                    FavoriteButton(character: character)
                }
            }
            
            if canShowElement(){
                CharacterDescription(character: character)
            }
        }
        
    }
    
    func CharacterDescription(character: CharacterModel) -> some View{
        List() {
            Section(header: Text("Name")) {
                Text(character.name)
            }
            Section(header: Text("Occupations")) {
                ForEach(character.occupation, id: \.self){ occupation in
                    Text(occupation)
                }
            }
            Section(header: Text("Status")) {
                Text(character.status)
            }
            Section(header: Text("Seasons")) {
                Text(character.appearance.map(String.init).joined(separator: ", "))
            }
            Section(header: Text("Nickname")) {
                Text(character.nickname)
            }
            Section(header: Text("Portrayed")) {
                Text(character.portrayed)
            }
        }
        .id(UUID())
        .frame(minHeight: UIScreen.main.bounds.size.height)
        .frame(minWidth:0, maxWidth:.infinity)

    }
    
    
    func FavoriteButton(character: CharacterModel) -> some View{
    
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
                            setAsFavorite(character: character)
                        }
                }
                Spacer()
                    .frame(width:20)
                
            }
            Spacer()
                .frame(height:20)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
    
    func CloseButton(character : CharacterModel) -> some View{
        VStack{
            Spacer()
                .frame(height:35)
            HStack{
                Spacer()
                    .frame(width:5)
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(Color.black)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .foregroundColor(Color.gray)
                    )
                    .shadow(
                        color: Color.black.opacity(0.25),
                        radius: 10, x: 0, y: 0)
                    .padding()
                    .onTapGesture {
                        self.closeDetailView()
                    }
                Spacer()
            }
            Spacer()
        }
    }
}
