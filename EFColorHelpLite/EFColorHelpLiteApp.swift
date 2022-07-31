//
//  EFColorHelpLiteApp.swift
//  EFColorHelpLite
//
//  Created by Edson José Friedmann on 07/29/22.
//

import SwiftUI

@main
struct EFColorHelpLiteApp: App {
    @StateObject var appModel = AppModel()
   
    init() {        
    }
    
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(appModel)
        }
    }
}
