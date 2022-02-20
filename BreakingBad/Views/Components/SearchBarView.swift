//
//  SearchBarView.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/20/22.
//

import Foundation
import SwiftUI

struct SearchBarView : View{
    
    @Binding var searchText: String
    @FocusState.Binding var isEditing: Bool
    
    var body : some View{
        
        HStack {
            TextField("Search ...", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    withAnimation{
                        self.isEditing = true
                    }
                }.focused($isEditing)
            
            if isEditing {
                Button(action: {
                    withAnimation{
                        self.isEditing = false
                    }
                    searchText = ""
                    
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 15)
                .transition(.move(edge: .trailing))
            }
        }.padding(.horizontal,5)
            .frame(height:40)
    }
}
