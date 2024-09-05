//
//  ToggleImmersiveSpaceButton.swift
//  EmptDemo
//
//  Created by 曾政桦 on 2024/8/22.
//

import SwiftUI
import OSLog

struct ToggleImmersiveSpaceButton: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    private let logger = Logger(subsystem: "Demo", category: "ImmersiveButton")
    
    var body: some View {
        Button {
            Task { @MainActor in
                switch appModel.immersiveSpaceState {
                    case .open:
                        appModel.immersiveSpaceState = .inTransition
                        appModel.root = nil
                        logger.log("dismiss immersiveSpace: \(appModel.root == nil)")
                        await dismissImmersiveSpace()

                    case .closed:
                        appModel.immersiveSpaceState = .inTransition
                        switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
                            case .opened:
                                logger.log("open immersiveSpace: \(appModel.root == nil)")
                                break

                            case .userCancelled, .error:
                                logger.error("error immersiveSpace")
                                fallthrough
                            @unknown default:
                                logger.warning("error immersiveSpace")
                                appModel.immersiveSpaceState = .closed
                        }

                    case .inTransition:
                        break
                }
            }
        } label: {
            Text(appModel.immersiveSpaceState == .open ? "Hide Immersive Space" : "Show Immersive Space")
        }
        .disabled(appModel.immersiveSpaceState == .inTransition)
        .animation(.none, value: 0)
        .fontWeight(.semibold)
    }
}
