//
//  UIProperties.swift
//  SwiftUIARGallery
//
//  Created by Gianluca Capraro on 12/27/24.
//

import Foundation
import SwiftUI

struct Screen {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}

struct Sizing {
    
    static let buttonWidth: CGFloat = 3*Screen.width/5
    static let buttonHeight: CGFloat = Screen.height/20
    
    static let defaultPadding: CGFloat = Screen.width/20
}

