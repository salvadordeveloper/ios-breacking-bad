//
//  HomeView.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/18/22.
//

import Foundation
import SwiftUI


struct HomeView : View{
    @Namespace var homeNamespace;
    
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel();

    @State private var selectedCharacter : CharacterModel? = nil
    @State private var showFavorites : Bool = false;
    @State private var showDetailView : Bool = false;
    
    @FocusState private var isEditing : Bool
    
    var body: some View{
            NavigationView {
                ZStack(){
                    Color.theme.background.ignoresSafeArea()
                    VStack{
                        SearchBarView(searchText: $homeViewModel.searchText, isEditing: $isEditing)
                        characterListView
                    }
                    .toolbar(content: toolBarContent)
                    .navigationTitle("Breaking Bad")
                }
            }
            .overlay(
                ZStack {
                    if showDetailView {
                        DetailView(showDetailView: $showDetailView,character:selectedCharacter, namespace: homeNamespace, saveFavorite: homeViewModel.saveFavorite)
                    }
                }
            )
            .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ZStack{
                HomeView()
                 .preferredColorScheme(.light)
            }
            ZStack{
                HomeView()
                 .preferredColorScheme(.dark)
            }
        }
    }
}

extension HomeView {
    
    private var characterListView : some View{
        ZStack{
            
            if(!showFavorites && homeViewModel.allCharacters.isEmpty){
                if !homeViewModel.searchText.isEmpty{
                    Text("No results")
                }else{
                    ProgressView()
                }
            }
            if (showFavorites && homeViewModel.favoriteCharacters.isEmpty){
                VStack{
                    if isEditing{
                        Text("No results")
                    }else{
                        Text("No favorites")
                        
                    }
    
                }
            }
            
            ScrollView(showsIndicators: false){
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 150, maximum: 200),spacing: 15)], spacing: 10) {
                    ForEach(showFavorites ? homeViewModel.favoriteCharacters : homeViewModel.allCharacters){ character in
                        
                        CharacterCardView(character: character, namespace: homeNamespace)
                            .onTapGesture {
                                selectedCharacter = character
                                withAnimation() {
                                    showDetailView.toggle()
                                    self.isEditing = false
                                    
                                }
                            }
                        
                    }
                    
                    
                }
                .padding(.horizontal)
            }
        }
    }
    
    @ToolbarContentBuilder
    private func toolBarContent() -> some ToolbarContent{
        ToolbarItemGroup( placement: .bottomBar){
            Spacer();
            VStack {
                Image(systemName: "person.2.fill")
                    .foregroundColor(!showFavorites ? Color.theme.accent : Color.gray)
            }
            .onTapGesture {
                withAnimation{
                    showFavorites = false;
                }
            }
            Spacer();
            VStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(showFavorites ? Color.theme.accent : Color.gray)
                    .padding()
            }
            .onTapGesture {
                withAnimation{
                    showFavorites = true;
                }
            }
            Spacer();
            
        }
    }
    
}
