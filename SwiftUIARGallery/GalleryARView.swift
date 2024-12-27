//
//  GalleryARView.swift
//  SwiftUIARGallery
//
//  Created by Gianluca Capraro on 12/27/24.
//

import SwiftUI
import ARKit

struct GalleryARView: View {
    
    var paintings: [Painting] = [
        Painting(image: UIImage(named: "painting1.jpg")!, position: SCNVector3(0, 0, -2)),
        Painting(image: UIImage(named: "painting2.jpg")!, position: SCNVector3(2, 0, -2)),
        Painting(image: UIImage(named: "painting3.jpg")!, position: SCNVector3(-2, 0, -2))
    ]

    var body: some View {
        VStack {
            Text("Gallery AR View")
                .font(.title)

            // Here we pass the paintings data to ARViewContainer
            ARViewContainer(paintings: paintings)
                .edgesIgnoringSafeArea(.all) // Ensures that the AR view takes up the entire screen
        }
    }
}
