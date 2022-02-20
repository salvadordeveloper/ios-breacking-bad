//
//  HepticManager.swift
//  BreakingBad (iOS)
//
//  Created by Salvador on 2/19/22.
//

import Foundation

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
