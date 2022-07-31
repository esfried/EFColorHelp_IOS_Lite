//
//  AnalogView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 04/05/21.
//

import SwiftUI

struct AnalogView: View {
    @State var orientation : UIDeviceOrientation
    
    init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
        Group {
            switch orientation {
            case  UIDeviceOrientation.landscapeRight:
                AnalogLandscapeView()
            default:
                AnalogPortraitView()
                
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

struct AnalogPortraitView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
         GeometryReader { m in
            VStack (spacing:0) {
                Text(LocalizedStringKey("Analog"))
                    .font(Font.title)
                
                Spacer(minLength: 20)
                ChromaticCircle(isSplashScreen: false,wheelType: .analog,showSelection: true)
                
                /*GeometryReader { m1 in
                    VStack(spacing:0) {
                        ChromaticCircle(isSplashScreen: false,wheelType: .analog,showSelection: true)
                            .frame(height: m1.size.height * 0.70)
                        
                        Spacer(minLength: 0)
                            .frame(height: m1.size.height * 0.05)
                        
                        GeometryReader { m2 in
                            let fraction_m2:CGFloat = 1.0 / 3.0
                            
                            VStack(spacing: 0) {
                                GradientBlocksView(color: colors[0],
                                                  title: Text(LocalizedStringKey("Previous-Color")))
                                    .frame(height: m2.size.height * fraction_m2)
                                
                                GradientBlocksView(color: appModel.selectedColor,
                                                   title: Text(LocalizedStringKey("Selected-Color")))
                                 .frame(height: m2.size.height * fraction_m2)
                                
                                GradientBlocksView(color: colors[1],
                                                   title: Text(LocalizedStringKey("Next-Color")))
                                 .frame(height: m2.size.height * fraction_m2)
                            }
                            .frame(height: m2.size.height)
                        }
                        
                        Spacer(minLength: 0)
                            .frame(height: m1.size.height * 0.05)
                    }
                }*/
            }
        }
    }
}

struct AnalogLandscapeView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        let colors = Repository.shared.getAnalogColors(color: appModel.selectedColor)
        
        GeometryReader { m in
            VStack (spacing:0) {
                GeometryReader { m1 in
                    HStack(spacing:0) {
                        ChromaticCircle(isSplashScreen: false,wheelType: .analog,showSelection: true,showPicker: false)
                            .frame(width: m1.size.width * 0.50)
                        
                        Divider()
                        
                        VStack() {
                            Text(LocalizedStringKey("Analog"))
                                .font(Font.title)
                            
                            Spacer(minLength: 20)
                            
                            Picker(selection: $appModel.selectedWheelHue, label: Text(LocalizedStringKey("Settings-Ton")), content: {
                                Text(LocalizedStringKey("Bright")).tag(WheelHueEnum.bright)
                                Text(LocalizedStringKey("Dark")).tag(WheelHueEnum.dark)
                            })
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal,5)
                            
                            /*GeometryReader { m2 in
                                let fraction_m2:CGFloat = 1.0 / 3.0
                                
                                
                                VStack(spacing: 0) {
                                    GradientBlocksView(color: colors[0],
                                                      title: Text(LocalizedStringKey("Previous-Color")))
                                       .frame(height: m2.size.height * fraction_m2)
                                   
                                   GradientBlocksView(color: appModel.selectedColor,
                                                      title: Text(LocalizedStringKey("Selected-Color")))
                                       .frame(height: m2.size.height * fraction_m2)
                                   
                                   GradientBlocksView(color: colors[1],
                                                      title: Text(LocalizedStringKey("Next-Color")))
                                       .frame(height: m2.size.height * fraction_m2)
                                    }
                                .frame(width: m2.size.width)
                            }*/
                        }
                    }
                }
            }
        }
    }
}

struct AnalogView_Previews: PreviewProvider {
    static var previews: some View {
        /*Landscape {
            AnalogView(orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
        }
        */
       // Portrait {
            AnalogView(orientation: .portrait)
                .environmentObject(AppModel())
       // }
    }
}
