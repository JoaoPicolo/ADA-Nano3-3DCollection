//
//  ModelViewController.swift
//  3DCollection
//
//  Created by João Pedro Picolo on 30/09/21.
//

import UIKit
import ARKit
import RealityKit

class ProjectViewController: UIViewController {
    @IBOutlet var arView: ARView!
    @IBOutlet var contentView: UIView!
    
    var project: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    private func setupLayout() {
        view.insetsLayoutMarginsFromSafeArea = false
        setUpContent()
        addGesture()
    }
    
    private func addGesture() {
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.addTarget(self, action: #selector(backSegue))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc
    private func backSegue() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    private func setUpContent() {
        placeModelInformation(width: contentView.frame.width)
        placeModelDescription(width: contentView.frame.width)
    }
    
    private func placeModelInformation(width: CGFloat) {
        let viewHalfWidth = width / 2
        
        let nameView = UITextView(frame: CGRect(x: 0, y: 0,
                                                width: viewHalfWidth, height: 50))
        nameView.text = project.projectName
        nameView.font = .systemFont(ofSize: 34, weight: .bold)
        contentView.addSubview(nameView)
        

        let button = UIButton(frame: CGRect(x: viewHalfWidth, y: 0,
                                            width: viewHalfWidth, height: 60))
        button.setTitle("Settings >", for: .normal)
        button.setTitleColor(nameView.textColor, for: .normal)
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        contentView.addSubview(button)
    }
    
    private func placeModelDescription(width: CGFloat) {
        let label = UILabel(frame: CGRect(x: 0, y: 80,
                                          width: width, height: 20))
        label.text = "Project Description"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        contentView.addSubview(label)

        let description = UILabel(frame: CGRect(x: 0, y: 100,
                                                width: width - 15, height: 120))
        description.text = project.projectDescription
        description.numberOfLines = 0
        description.font = .systemFont(ofSize: 14, weight: .regular)
        contentView.addSubview(description)
    }
    
    @objc
    func openSettings() {
        print("Settings here")
    }
}


extension ProjectViewController {
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
        let modelEntity = try! ModelEntity.loadModel(named: project.projectModelName)
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
