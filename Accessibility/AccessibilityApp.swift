//
//  AccessibilityApp.swift
//  Accessibility
//
//  Created by Tekla on 12/27/23.
//

import SwiftUI

@main
struct AccessibilityApp: App {
    @State var viewModel = NewsViewModel()
    
    var body: some Scene {
        WindowGroup {
            NewsPageView()
                .environmentObject(viewModel)
        }
    }
}
