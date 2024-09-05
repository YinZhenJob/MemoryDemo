//
//  AppModel.swift
//  EmptDemo
//
//  Created by 曾政桦 on 2024/8/22.
//

import SwiftUI
import RealityKit

/// Maintains app-wide state
@MainActor
@DebugDescription
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
    
    var root: RealityViewContent? = nil
    
    var debugDescription: String {
        "[AppModel]\(immersiveSpaceState) - \(root)"
    }
}
