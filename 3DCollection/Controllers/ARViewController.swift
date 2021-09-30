//
//  ARViewController.swift
//  3DCollection
//
//  Created by João Pedro Picolo on 30/09/21.
//

import UIKit
import RealityKit
import ARKit

class ARViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupARView()
        setupEntities()
    }
      
    // MARK: Setup Methods
    func setupARView() {
        arView.cameraMode = .ar
        arView.automaticallyConfigureSession = true
    }
    
    func setupEntities() {
        let modelEntity = try! ModelEntity.loadModel(named: "Saturn")
        modelEntity.generateCollisionShapes(recursive: true)
        enableGestures(modelEntity)

        let anchorEntity = AnchorEntity(plane: .horizontal)
        anchorEntity.scale = SIMD3(SCNVector3(x: 0.2, y: 0.2, z: 0.2))
        anchorEntity.addChild(modelEntity)
        
        arView.scene.addAnchor(anchorEntity)
    }
    
    func enableGestures(_ modelEntity: ModelEntity) {
        arView.installGestures([.translation, .rotation, .scale], for: modelEntity)
    }
}

