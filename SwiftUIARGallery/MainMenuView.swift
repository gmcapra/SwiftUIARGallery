//
//  MainMenuView.swift
//  SwiftUIARGallery
//
//  Created by Gianluca Capraro on 12/27/24.
//

import SwiftUI
import ARKit

struct MainMenuView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "photo.artframe.circle")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .padding(.bottom)
                Text("Welcome to the SwiftUI AR Gallery App")
                    .padding(.bottom)
                NavigationLink("Enter the Gallery") {
                    GalleryARView() // This is your AR view
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    MainMenuView()
}
