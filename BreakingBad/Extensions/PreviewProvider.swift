//
//  PreviewProvider.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/18/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var preview: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let homeViewModel = HomeViewModel()
    
    let mainCharacter = CharacterModel(
        id: 0,
        name: "Walter White",
        birthday: "09-07-1958",
        occupation:  [
        "High School Chemistry Teacher",
        "Meth King Pin"
        ],
        img: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
        status: "Presumed dead",
        nickname: "Heisenberg",
        appearance:[
            1,
            2,
            3,
            4,
            5
        ],
        portrayed: "Bryan Cranston",
        category: "Breaking Bad",
        betterCallSaulAppearance: [],
        isFavorite: false
    );
    
    @State var selectedCharacter : CharacterModel? = CharacterModel(
        id: 0,
        name: "Walter White",
        birthday: "09-07-1958",
        occupation:  [
        "High School Chemistry Teacher",
        "Meth King Pin"
        ],
        img: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
        status: "Presumed dead",
        nickname: "Heisenberg",
        appearance:[
            1,
            2,
            3,
            4,
            5
        ],
        portrayed: "Bryan Cranston",
        category: "Breaking Bad",
        betterCallSaulAppearance: [],
        isFavorite: false
    );

    
}
