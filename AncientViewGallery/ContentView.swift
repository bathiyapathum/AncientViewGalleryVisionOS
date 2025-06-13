//
//  ContentView.swift
//  AncientViewGallery
//
//  Created by Bathiya Pathum on 6/13/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            Button("Enter Immersive View") {
                Task {
                    await openImmersiveSpace(id: appModel.immersiveSpaceID)
                    appModel.immersiveSpaceState = .inTransition
                }
            }

            if appModel.immersiveSpaceState == .open || appModel.immersiveSpaceState == .inTransition {
                Button("Exit Immersive View") {
                    Task {
                        await dismissImmersiveSpace()
                        appModel.immersiveSpaceState = .closed
                    }
                }
            }
        }
        .padding()
    }
}


//struct ContentView: View {
//
//    var body: some View {
//        VStack {
//            Model3D(named: "Scene", bundle: realityKitContentBundle)
//                .padding(.bottom, 50)
//
////            Text("Hello, world!")
//
////            ToggleImmersiveSpaceButton()
//            ImmersiveView()
//        }
//        .padding()
//    }
//}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
