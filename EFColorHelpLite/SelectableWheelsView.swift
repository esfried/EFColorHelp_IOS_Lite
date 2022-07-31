//
//  CirclesView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 03/05/21.
//

import SwiftUI

struct ColorWheelsView: View {
    @EnvironmentObject var appModel: AppModel
    @State var orientation : UIDeviceOrientation
    
    init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
        SelectableWheelsView(orientation: self.orientation)
                    .tabItem {
                        Image( systemName: "circles.hexagongrid")
                        //Image("cromatic-icon")
                        Text(LocalizedStringKey("Chromatic"))
                    }
                    .tag(0)
                    .padding(2)
          .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

struct ShowSelectedWheel: View {
    @EnvironmentObject var appModel: AppModel
    @State var orientation : UIDeviceOrientation
    
    init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
        switch(appModel.selectedWheelType) {
        case .monochromatic:
            MonoChromaticView(orientation: self.orientation)
        case .analog:
            AnalogView(orientation: self.orientation)
        case .complementary:
            ComplementaryView(orientation: self.orientation)
        case .triadic:
            TriadicView(orientation: self.orientation)
        case .none, .chromatic:
            ChromaticCircleView(orientation: self.orientation)
        case .splitComplementary:
            SplitComplementaryView(orientation: self.orientation)
        case .doubleComplementary:
            DoubleComplementaryView(orientation: self.orientation)
        }
    }
}

struct SelectableWheelsView: View {
    @EnvironmentObject var appModel: AppModel
    @State var orientation: UIDeviceOrientation
    
     init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
     
        let w:CGFloat = UIDevice.current.model=="iPad"  ? 50 :  36
        
        let icons = Group {
            Image(appModel.selectedWheelType == .chromatic ? "cromatic-icon" : "cromatic-icon-bw")
                .resizable()
                .frame(width: w, height: w)
                .onTapGesture {
                    appModel.selectedWheelType = .chromatic
                }
            Image(appModel.selectedWheelType == .monochromatic ? "mono-icon" : "mono-icon-bw")
                .resizable()
                .frame(width: w, height: w)
               .onTapGesture {
                    appModel.selectedWheelType = .monochromatic
                }
            Image(appModel.selectedWheelType == .analog ? "analog-icon" : "analog-icon-bw")
                .resizable()
                .frame(width: w, height: w)
               .onTapGesture {
                    appModel.selectedWheelType = .analog;
                }
            Image(appModel.selectedWheelType == .complementary ? "complement-icon" : "complement-icon-bw")
                .resizable()
                .frame(width: w, height: w)
               .onTapGesture {
                    appModel.selectedWheelType = .complementary
                }
            Image(appModel.selectedWheelType == .triadic ? "triad-icon" : "triad-icon-bw")
                .resizable()
                .frame(width: w, height: w)
               .onTapGesture {
                    appModel.selectedWheelType = .triadic
                }
        }
        
        VStack(spacing:0) {
             Group {
                switch orientation {
                case    UIDeviceOrientation.unknown,
                        UIDeviceOrientation.landscapeLeft:
                        UnsupportedOrientationView()
                case    UIDeviceOrientation.landscapeRight:
                    HStack {
                        VStack {
                            icons
                        }
                        ShowSelectedWheel(orientation: self.orientation)
                    }
                default:
                    ShowSelectedWheel(orientation: self.orientation)
                    HStack {
                        icons
                    }
                }
            }
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}


struct CirclesView_Previews: PreviewProvider {
    static var previews: some View {
        /*Landscape {
            SelectableWheelsView(orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
        }
        
        Portrait {*/
            SelectableWheelsView(orientation: .portrait)
                .environmentObject(AppModel())
       // }
        .preferredColorScheme(.light)
    }
}

