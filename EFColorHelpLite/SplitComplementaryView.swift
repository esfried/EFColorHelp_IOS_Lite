//
//  SplitComplementaryViewq.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 04/05/21.
//

import SwiftUI


struct SplitComplementaryView: View {
    @State var orientation : UIDeviceOrientation
    
    init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
        Group {
            switch orientation {
            case   UIDeviceOrientation.landscapeRight:
                SplitComplementaryLandscapeView()
            default:
                SplitComplementaryPortraitView()
                
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

struct SplitComplementaryPortraitView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        let colors = Repository.shared.getSplitComplementaryColors(color: appModel.selectedColor)
        
        GeometryReader { m in
            VStack (spacing:0) {
                Text(LocalizedStringKey("Split-Complementary"))
                    .font(Font.title)
                
                Spacer(minLength: 20)
                
                GeometryReader { m1 in
                    VStack(spacing:0) {
                        ChromaticCircle(isSplashScreen: false,wheelType: .splitComplementary,showSelection: true)
                            .frame(height: m1.size.height * 0.70)
                        
                        Spacer(minLength: 0)
                            .frame(height: m1.size.height * 0.05)
                        
                        GeometryReader { m2 in
                            let fraction_m2:CGFloat = 1.0 / 3.0
                            
                            VStack(spacing: 0) {
                                GradientBlocksView(color: appModel.selectedColor,
                                                   title: Text(LocalizedStringKey("Selected-Color")))
                                    .frame(height: m2.size.height * fraction_m2)
                                
                                GradientBlocksView(color: colors[0],
                                                   title: Text(LocalizedStringKey("1st-Color")))
                                    .frame(height: m2.size.height * fraction_m2)
                                
                                GradientBlocksView(color: colors[1],
                                                   title: Text(LocalizedStringKey("2nd-Color")))
                                    .frame(height: m2.size.height * fraction_m2)
                            }
                            .frame(height: m2.size.height)
                        }
                        
                        Spacer(minLength: 0)
                            .frame(height: m1.size.height * 0.05)
                    }
                }
            }
        }
    }
}

struct SplitComplementaryLandscapeView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        let colors = Repository.shared.getSplitComplementaryColors(color: appModel.selectedColor)
        
        GeometryReader { m in
            VStack (spacing:0) {
                
                GeometryReader { m1 in
                    HStack(spacing:0) {
                        ChromaticCircle(isSplashScreen: false,wheelType: .splitComplementary,showSelection: true,showPicker: false)
                            .frame(width: m1.size.width * 0.50)
                        
                        Divider()
                        
                        VStack() {
                            Text(LocalizedStringKey("Split-Complementary"))
                                .font(Font.title)
                            
                            Spacer(minLength: 20)
                            
                            Picker(selection: $appModel.selectedWheelHue, label: Text(LocalizedStringKey("Settings-Ton")), content: {
                                Text(LocalizedStringKey("Bright")).tag(WheelHueEnum.bright)
                                Text(LocalizedStringKey("Dark")).tag(WheelHueEnum.dark)
                            })
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal,5)
                            
                            GeometryReader { m2 in
                                let fraction_m2:CGFloat = 1.0 / 3.0
                                
                                
                                VStack(spacing: 0) {
                                    GradientBlocksView(color: appModel.selectedColor,
                                                       title: Text(LocalizedStringKey("Selected-Color")))
                                        .frame(height: m2.size.height * fraction_m2)
                                    
                                    GradientBlocksView(color: colors[0],
                                                       title: Text(LocalizedStringKey("1st-Color")))
                                        .frame(height: m2.size.height * fraction_m2)
                                    
                                    GradientBlocksView(color: colors[1],
                                                       title: Text(LocalizedStringKey("2nd-Color")))
                                        .frame(height: m2.size.height * fraction_m2)
                                }
                                .frame(width: m2.size.width)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SplitComplementaryView_Previews: PreviewProvider {
    static var previews: some View {
       /* Landscape {
            SplitComplementaryView(orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
        }
        
        Portrait {*/
            SplitComplementaryView(orientation: .portrait)
                .environmentObject(AppModel())
      //  }
    }
}
