//
//  ARViewContainer.swift
//  SwiftUIARGallery
//
//  Created by Gianluca Capraro on 12/27/24.
//

import ARKit
import SwiftUI

struct ARViewContainer: UIViewControllerRepresentable {
    // This struct helps bridge SwiftUI with UIKit components like ARSCNView
    var paintings: [Painting] // Your data for paintings, e.g., UIImage, coordinates
    
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController(paintings: paintings)
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        // Handle updates to the AR view if necessary
    }
}

class ARViewController: UIViewController, ARSCNViewDelegate {
    var sceneView: ARSCNView!
    var paintings: [Painting]
    
    init(paintings: [Painting]) {
        self.paintings = paintings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize ARSCNView and setup
        sceneView = ARSCNView(frame: self.view.bounds)
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sceneView.delegate = self
        self.view.addSubview(sceneView)
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        // Add paintings to the scene
        addPaintingsToScene()
    }
    
    func addPaintingsToScene() {
        // Add each painting to the AR scene
        // Add each painting to the AR scene
        for painting in paintings {
            let (width, height, thickness) = getRealWorldDimensions(from: painting.image)
            
            let box = SCNBox(width: CGFloat(width), height: CGFloat(height), length: CGFloat(thickness), chamferRadius: 0)
            box.firstMaterial?.diffuse.contents = painting.image
            
            let boxNode = SCNNode(geometry: box)
            boxNode.position = painting.position
            boxNode.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0) // Rotate to face the camera
            
            sceneView.scene.rootNode.addChildNode(boxNode)
        }
    }
    
    // Function to get real-world dimensions from the image's pixel dimensions
    func getRealWorldDimensions(from image: UIImage) -> (Float, Float, Float) {
        // Image dimensions in pixels
        let imageWidthInPixels = Float(image.size.width)
        let imageHeightInPixels = Float(image.size.height)
        
        // Reference width of the painting in real-world units (e.g., 50 cm or 0.5 meters)
        let referenceWidthInMeters: Float = 0.50 // Example: 50 cm or 0.5 meters
        
        // Calculate the scale factor based on the image's width in pixels
        let scaleFactor = referenceWidthInMeters / imageWidthInPixels
        
        // Calculate real-world height based on the aspect ratio
        let realWorldHeight = imageHeightInPixels * scaleFactor
        
        // Set a constant thickness (depth) in meters (e.g., 0.05 meters or 5 cm)
        let thicknessInMeters: Float = 0.05 // Example: 5 cm or 0.05 meters
        
        return (referenceWidthInMeters, thicknessInMeters, realWorldHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Restart AR session
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the AR session
        sceneView.session.pause()
    }
}
