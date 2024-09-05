//
//  ContentView.swift
//  EmptDemo
//
//  Created by 曾政桦 on 2024/8/22.
//

import SwiftUI
import RealityKit
import RealityKitContent
import OSLog

struct ContentView: View {
    @Environment(AppModel.self) private var appVM
    private let logger = Logger(subsystem: "Demo", category: "ContentView")
    
    var body: some View {
        HStack {
            VStack {
                ToggleImmersiveSpaceButton()
            }
            
            if appVM.immersiveSpaceState == .open {
                Button {
                    Task { [weak appVM] in
                        if let url = Bundle.main.url(forResource: "Robot", withExtension: "usdz") {
                            if let model = try? await ModelEntity(contentsOf: url, withName: "Robot") {
                                let pLocation = Unmanaged.passUnretained(model).toOpaque().debugDescription
                                logger.info("Robot-\(pLocation): \(model.debugDescription)")
                                model.setPosition(.init(x: .random(in: 0...1.0), y: .random(in: 1.0...1.6), z: -1), relativeTo: nil)
                                appVM?.root?.add(model)
                            }
                        }
                        
//                        var m = PhysicallyBasedMaterial()
//                        m.baseColor = .init(tint: .blue)
//                        let model = ModelEntity(mesh: .generateSphere(radius: 0.5), materials: [m])
//                        model.setPosition(.init(x: .random(in: 0...1.0), y: .random(in: 1.0...1.6), z: -1), relativeTo: nil)
//                        appVM?.root?.add(model)
                    }
                } label: {
                    Text("Add A Robot")
                }
                
                Button("remove") {
                    appVM.root?.entities.first?.removeFromParent()
                }
            }
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
