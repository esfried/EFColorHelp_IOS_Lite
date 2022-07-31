//
//  MobileOrientation.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 06/06/21.
//

import Foundation
import SwiftUI

// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                
                //landscapeLeft botao home do celula a esquerda
                //quando celular deitado
                
                 if (UIDevice.current.orientation ==  UIDeviceOrientation.landscapeRight ||
                    (UIDevice.current.orientation ==  UIDeviceOrientation.portrait)) {
                        action(UIDevice.current.orientation)
                }
            }
    }
}
