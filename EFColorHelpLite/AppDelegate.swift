//
//  AppDelegate.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 06/06/21.
//

import Foundation
import SwiftUI

func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    
    // Support only one orientation value.
    return UIInterfaceOrientationMask.portrait
    
    // Support multiple orientation values.
    //return ( UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue | //UIInterfaceOrientationMask.landscape.rawValue | UIInterfaceOrientationMask.portraitUpsideDown.rawValue) )
}
