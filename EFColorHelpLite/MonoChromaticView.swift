//
//  MonoChromaticView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 03/05/21.
//

import SwiftUI

struct MonoChromaticView: View {
    @State var orientation : UIDeviceOrientation
    
    init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
        VStack {
            /*Group {
             switch orientation {
             case    UIDeviceOrientation.unknown:
             Text("Unknow")
             case    UIDeviceOrientation.portrait:
             Text("portrait")
             case    UIDeviceOrientation.portraitUpsideDown:
             Text("portraitUpsideDown")
             case    UIDeviceOrientation.landscapeLeft:
             Text("landscapeLeft")
             case    UIDeviceOrientation.landscapeRight:
             Text("landscapeRight")
             case    UIDeviceOrientation.faceUp:
             Text("faceUp")
             case    UIDeviceOrientation.faceDown:
             Text("faceDown")
             }
             }*/
            Group {
                switch orientation {
                case    UIDeviceOrientation.landscapeRight:
                    MonoChromaticLandscapeView()
                default:
                    MonoChromaticPortraitView()
                }
            }
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}

struct  MonoChromaticPortraitView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        GeometryReader { m in
            VStack (spacing:0) {
                Text(LocalizedStringKey("Monochromatic"))
                    .font(Font.title)
                
                Spacer(minLength: 20)
                
                ChromaticCircle(isSplashScreen: false,wheelType: .monochromatic,showSelection: true)

            }
        }
    }
}

struct  MonoChromaticLandscapeView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        GeometryReader { m in
            VStack (spacing:0) {
                GeometryReader { m1 in
                    HStack(spacing:0) {
                        ChromaticCircle(isSplashScreen: false,wheelType: .monochromatic,showSelection: true,showPicker: false)
                            .frame(width: m1.size.width * 0.50)
                        
                        Divider()
                        
                        VStack(spacing:0) {
                            Text(LocalizedStringKey("Monochromatic"))
                                .font(Font.title)
                           
                            Spacer(minLength: 20)
                            
                            Picker(selection: $appModel.selectedWheelHue, label: Text(LocalizedStringKey("Settings-Ton")), content: {
                                Text(LocalizedStringKey("Bright")).tag(WheelHueEnum.bright)
                                Text(LocalizedStringKey("Dark")).tag(WheelHueEnum.dark)
                            })
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal,5)
                            
                            /*GeometryReader { m2 in
                                VStack(spacing:0) {
                                    Spacer()
                                        .frame(height: m2.size.height * 0.25)
                                    
                                    GradientBlocksView(color: appModel.selectedColor,
                                                       title: Text(LocalizedStringKey("Selected-Color")),
                                                       titlePosition: .top)
                                        .frame(height: m2.size.height * 0.25)
                                    
                                    
                                    Spacer()
                                        .frame(height: m2.size.height * 0.25)
                                }
                            }*/
                        }
                        .frame(width: m1.size.width*0.5)
                    }
                }
            }
        }
    }
}

struct  MonoChromaticView_Previews: PreviewProvider {
    static var previews: some View {
       /* Landscape {
            MonoChromaticView(orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
        }
        
        Portrait {*/
            MonoChromaticView(orientation: .portrait)
                .environmentObject(AppModel())
      //  }
    }
}
