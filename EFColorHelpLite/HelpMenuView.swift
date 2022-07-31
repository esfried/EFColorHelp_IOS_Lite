//
//  HelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 04/05/21.
//

import SwiftUI

struct HelpMenuView: View {
    @State var orientation : UIDeviceOrientation
    
    init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
        VStack {
            switch orientation {
            case    UIDeviceOrientation.unknown,
                UIDeviceOrientation.landscapeLeft:
                UnsupportedOrientationView()
            default:
                HelpMenuLandscapeView()
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

struct HelpMenuLandscapeView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        GeometryReader { m in
            VStack(alignment: .leading)  {
                HelpHeader(text: Text(LocalizedStringKey("Help")))
                ScrollView {
                    ChromaticCircleHelpView()
                        .frame(height: 700)
                    ColorCombinationHelpView()
                    MonochromaticHelpView()
                    AnalogHelpView()
                    ComplementaryHelpView()
                    TriadicHelpView()
                    FullVersionHelpView()
                }
            }
            .padding()
        }
    }
}

struct HelpMenuPreviewView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10)  {
            HelpHeader(text: Text(LocalizedStringKey("Help")))
            
            ScrollView {
                VStack() {
                    Group {
                        HelpMenuButton(text: Text(LocalizedStringKey("Chromatic-Circle")),helpIndex: .chromaticCircle)
                        HelpMenuButton(text: Text(LocalizedStringKey("Color-Selection")),helpIndex: .colorSelection)
                        HelpMenuButton(text: Text(LocalizedStringKey("Color-Combination")),helpIndex: .colorCombination)
                        HelpMenuButton(text: Text(LocalizedStringKey("Monochromatic")),helpIndex: .monochromatic)
                        HelpMenuButton(text: Text(LocalizedStringKey("Analog")),helpIndex: .analog)
                    }
                    
                    Group {
                        HelpMenuButton(text: Text(LocalizedStringKey("Complementary")),helpIndex: .complementary)
                        HelpMenuButton(text: Text(LocalizedStringKey("Triadic")),helpIndex: .triadic)
                        FullVersionHelpView()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct HelpMenuView_Previews: PreviewProvider {
    static var previews: some View {
        /*Landscape {
         HelpMenuView(orientation: .landscapeRight)
         .environmentObject(AppModel())
         .environment(\.horizontalSizeClass, .regular)
         .environment(\.verticalSizeClass, .compact)
         }
         
         Portrait {*/
        HelpMenuView(orientation: .portrait)
            .environmentObject(AppModel())
        //   }
    }
}
