//
//  Coordinator.swift
//  SwiftUIARGallery
//
//  Created by Gianluca Capraro on 12/27/24.
//

import Foundation
import RealityKit
import UIKit

class Coordinator {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let arView = sender.view as? ARView else { return }
        let location = sender.location(in: arView)

        if let entity = arView.entity(at: location) {
            print("Tapped on entity: \(entity.name)")
        }
    }
}
