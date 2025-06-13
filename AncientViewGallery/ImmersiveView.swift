//
//  ImmersiveView.swift
//  AncientViewGallery
//
//  Created by Bathiya Pathum on 6/13/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

@MainActor
struct ImmersiveView: View {
    
    @State private var box = Entity() // to store box

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "PortalBoxScene", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
                
                guard let box = immersiveContentEntity.findEntity(named: "Box") else {
                    fatalError()
                }
//
                self.box = box
                box.position = [0,1,-2] //meters
                box.scale += [1,2,1]
                
                //make world 1
                let world1 = Entity()
                world1.components.set(WorldComponent())
                let skybox1 = await createSkyboxEntity(texture: "skybox1")
//                content.add(skybox1)
                world1.addChild(skybox1)
                content.add(world1)
            }
        }
    }
    
    func createSkyboxEntity(texture: String) async -> Entity{
        guard let resource = try? await TextureResource(named: texture) else{
            fatalError("Unable to load the skybox")
        }
        
        var material = UnlitMaterial()
        
        material.color = .init(texture: .init(resource))
        
        let entity = Entity()
        entity.components.set(ModelComponent(mesh: .generateSphere(radius: 1000), materials: [material]))
        entity.scale *= .init(x:-1, y:1, z:1)
        return entity
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
