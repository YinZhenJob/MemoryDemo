//
//  ImmersiveView.swift
//  EmptDemo
//
//  Created by 曾政桦 on 2024/8/22.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) private var appVM

    var body: some View {
        RealityView { content in
            appVM.root = content
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
