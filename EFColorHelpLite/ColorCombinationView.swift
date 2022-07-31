//
//  ColorCombinationView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 08/05/21.
//

import SwiftUI

struct MonoChromaticBlocks: View {
    @EnvironmentObject var appModel: AppModel
    @Binding var tabSelection: Int
    
    var body: some View {
        GeometryReader { m in
            VStack(spacing:0) {
                SubHeader(text: Text(LocalizedStringKey("Monochromatic")))
                    .frame(height: m.size.height * 0.25)
                
                ZStack {
                    GeometryReader { m1 in
                        let squareSideSize :CGFloat = min(m1.size.width,m1.size.height)
                        
                        HStack(spacing:0) {
                            ColorCombinationGradientView(color:appModel.getSelectedColor())
                            
                            ChromaticCircle(ignoreTap:true, isSplashScreen: true,wheelType: .monochromatic,showSelection: false, showColorNames: false)
                                .frame( width: squareSideSize, height: squareSideSize)
                                .onTapGesture {
                                    self.tabSelection = 0
                                    appModel.selectedWheelType = .monochromatic
                                }
                        }
                    }
                }.padding(5)
                .frame(height: m.size.height * 0.75)
            }
        }
    }
}

struct AnalogBlocks: View {
    @EnvironmentObject var appModel: AppModel
    @Binding var tabSelection: Int
    
    var body: some View {
        let colors = Repository.shared.getAnalogColors(color: appModel.selectedColor)
        
        GeometryReader { m in
            VStack(spacing:0) {
                SubHeader(text: Text(LocalizedStringKey("Analog")))
                    .frame(height: m.size.height * 0.25)
                
                ZStack {
                    GeometryReader { m1 in
                        let squareSideSize :CGFloat = min(m1.size.width,m1.size.height)
                        
                        let perc:CGFloat = 1 / 3;
                        
                        HStack(spacing:0) {
                            VStack(spacing:0) {
                                ColorCombinationGradientView(color: Repository.shared.getColorFromCircleColorEnum(color:colors[0]))
                                    .frame(height: m1.size.height * perc)
                                
                                ColorCombinationGradientView(color: appModel.getSelectedColor())
                                    .frame(height: m1.size.height * perc)
                                
                                ColorCombinationGradientView(color: Repository.shared.getColorFromCircleColorEnum(color:colors[1]))
                                    .frame(height: m1.size.height * perc)
                            }
                            
                            ChromaticCircle(ignoreTap:true, isSplashScreen: true,wheelType: .analog,showSelection: false, showColorNames: false)
                                .frame( width: squareSideSize, height: squareSideSize)
                                .onTapGesture {
                                    self.tabSelection = 0
                                    appModel.selectedWheelType = .analog
                                }
                        }
                    }
                }.padding(5)
                .frame(height: m.size.height * 0.75)
            }
        }
    }
}

struct ComplementaryBlocks: View {
    @EnvironmentObject var appModel: AppModel
    @Binding var tabSelection: Int
    
    var body: some View {
        let complementaryColor = Repository.shared.getComplementaryColor(color: appModel.selectedColor)
        
        GeometryReader { m in
            VStack(spacing:0) {
                SubHeader(text: Text(LocalizedStringKey("Complementary")))
                    .frame(height: m.size.height * 0.25)
                
                ZStack {
                    GeometryReader { m1 in
                        let squareSideSize :CGFloat = min(m1.size.width,m1.size.height)
                        
                        let perc:CGFloat = 1 / 2;
                        
                        HStack(spacing:0) {
                            VStack(spacing:0) {
                                ColorCombinationGradientView(color: appModel.getSelectedColor())
                                    .frame(height: m1.size.height * perc)
                                
                                ColorCombinationGradientView(color: Repository.shared.getColorFromCircleColorEnum(color:complementaryColor))
                                    .frame(height: m1.size.height * perc)
                            }
                            
                            ChromaticCircle(ignoreTap:true, isSplashScreen: true,wheelType: .complementary,showSelection: false, showColorNames: false)
                                .frame( width: squareSideSize, height: squareSideSize)
                                .onTapGesture {
                                    self.tabSelection = 0
                                    appModel.selectedWheelType = .complementary
                                }
                        }
                    }
                }.padding(5)
                .frame(height: m.size.height * 0.75)
            }
        }
    }
}

struct TriadicBlocks: View {
    @EnvironmentObject var appModel: AppModel
    @Binding var tabSelection: Int
    
    var body: some View {
        let colors = Repository.shared.getTriadicColors(color: appModel.selectedColor)
        
        GeometryReader { m in
            VStack(spacing:0) {
                SubHeader(text: Text(LocalizedStringKey("Triadic")))
                    .frame(height: m.size.height * 0.25)
                
                ZStack {
                    GeometryReader { m1 in
                        let squareSideSize :CGFloat = min(m1.size.width,m1.size.height)
                        
                        let perc:CGFloat = 1 / 3;
                        
                        HStack(spacing:0) {
                            VStack(spacing:0) {
                                ColorCombinationGradientView(color: appModel.getSelectedColor())
                                    .frame(height: m1.size.height * perc)
                                
                                ColorCombinationGradientView(color: Repository.shared.getColorFromCircleColorEnum(color:colors[0]))
                                    .frame(height: m1.size.height * perc)
                                
                                ColorCombinationGradientView(color: Repository.shared.getColorFromCircleColorEnum(color:colors[1]))
                                    .frame(height: m1.size.height * perc)
                            }
                            
                            ChromaticCircle(ignoreTap:true, isSplashScreen: true,wheelType: .triadic,showSelection: false, showColorNames: false)
                                .frame( width: squareSideSize, height: squareSideSize)
                                .onTapGesture {
                                    self.tabSelection = 0
                                    appModel.selectedWheelType = .triadic
                                }
                        }
                    }
                }.padding(5)
                .frame(height: m.size.height * 0.75)
            }
        }
    }
}

struct ColorCombinationView: View {
    let showTitle: Bool
    @Binding var tabSelection: Int
    @State var orientation : UIDeviceOrientation
    
    var body: some View {
        VStack {
            Group {
                switch orientation {
                case    UIDeviceOrientation.unknown,
                        UIDeviceOrientation.landscapeLeft:
                    UnsupportedOrientationView()
                case    UIDeviceOrientation.landscapeRight:
                    ColorCombinationLandscapeView(showTitle: showTitle, tabSelection: $tabSelection )
                default:
                    ColorCombinationPortraitView(showTitle: showTitle, tabSelection: $tabSelection )
                    
                }
            }
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}

struct ColorCombinationPortraitView: View {
    @EnvironmentObject var appModel: AppModel
    let showTitle: Bool
    @Binding var tabSelection: Int
    
    let header_background = Color(UIColor(named: "header_background") ?? UIColor.white)
    let header_foreground = Color(UIColor(named: "header_foreground") ?? UIColor.white)
    
    func normalizeBlockHeight(blockHeight:CGFloat) -> CGFloat {
        if (blockHeight<150.0) {
            return 150.0
        }
        
        return blockHeight
    }
    
    func getSpecialText() -> String {
        return  String.getLocalizedString(name: "Color-Combination") + "  [ " +
            String.getLocalizedString(name: Repository.shared.getColorName(color: appModel.selectedColor)) + " ]"
    }
    
    var body: some View {
        let foreColor =
            Repository.shared.getTextColor(color: appModel.selectedColor)
        
        GeometryReader { m in
            VStack() {
                if self.showTitle {
                    TextBlock(Text(self.getSpecialText()).font(.callout),
                              backColor: Repository.shared.getColorFromCircleColorEnum(color:appModel.selectedColor),
                              foreColor: foreColor,
                              height: 45)
                }
                HStack() {
                    VStack(spacing:3) {
                        ForEach(Repository.shared.allColors, id: \.self) {
                            color in
                            Rectangle()
                                .fill(Repository.shared.getColorFromCircleColorEnum(color:color))
                                .cornerRadius(appModel.selectedColor==color ? 10 : 0)
                                .onTapGesture {
                                    appModel.selectedColor = color
                                }
                            
                        }
                    }.frame(width:m.size.width*0.15)
                    
                    
                    GeometryReader { m in
                        VStack {
                            TextBlock(Text(LocalizedStringKey("Select-The-Desired-Color"))
                                        .font(.callout),
                                      backColor: header_background,
                                      foreColor: header_foreground,
                                      height: 100)
                            
                            let borderColor = Color.black.opacity(0.25)
                            let blockHeight:CGFloat = self.normalizeBlockHeight(blockHeight: m.size.height / 4.0)
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                MonoChromaticBlocks(tabSelection: $tabSelection)
                                    .frame(height:blockHeight)
                                    .border(borderColor, width: 1)
                                
                                AnalogBlocks(tabSelection: $tabSelection)
                                    .frame(height:blockHeight)
                                    .border(borderColor, width: 1)
                                
                                ComplementaryBlocks(tabSelection: $tabSelection)
                                    .frame(height:blockHeight)
                                    .border(borderColor, width: 1)
                                
                                TriadicBlocks(tabSelection: $tabSelection)
                                    .frame(height:blockHeight)
                                    .border(borderColor, width: 1)
                            }
                        }
                    }
                }
            }.padding(5)
        }
    }
}

struct ColorCombinationLandscapeView: View {
    @EnvironmentObject var appModel: AppModel
    let showTitle: Bool
    @Binding var tabSelection: Int
    
    let header_background = Color(UIColor(named: "header_background") ?? UIColor.white)
    let header_foreground = Color(UIColor(named: "header_foreground") ?? UIColor.white)
    
    func normalizeBlockHeight(blockHeight:CGFloat) -> CGFloat {
        //if (blockHeight<5) {
        //   return 5
        // }
        
        return blockHeight
    }
    
    func getSpecialText() -> String {
        return  String.getLocalizedString(name: "Color-Combination") + "  [ " +
            String.getLocalizedString(name: Repository.shared.getColorName(color: appModel.selectedColor)) + " ]"
    }
    
    var body: some View {
        let foreColor =
            Repository.shared.getTextColor(color: appModel.selectedColor)
        
        GeometryReader { m in
            
            HStack {
                VStack(spacing:3) {
                    ForEach(Repository.shared.allColors, id: \.self) {
                        color in
                        Rectangle()
                            .fill(Repository.shared.getColorFromCircleColorEnum(color:color))
                            .cornerRadius(appModel.selectedColor==color ? 4 : 0)
                            .onTapGesture {
                                appModel.selectedColor = color
                            }
                        
                    }
                }.frame(width:m.size.width*0.08)
                
                VStack(spacing:4) {
                    if self.showTitle {
                        TextBlock(Text(self.getSpecialText()).font(.title2),
                                  backColor: Repository.shared.getColorFromCircleColorEnum(color:appModel.selectedColor),
                                  foreColor: foreColor,
                                  height: 40)
                    }
                    
                    GeometryReader { m in
                        ScrollView {
                            VStack(spacing:10) {
                                TextBlock(Text(LocalizedStringKey("Select-The-Desired-Color"))
                                            .font(.callout),
                                          backColor: header_background,
                                          foreColor: header_foreground,
                                          height: 100)
                                 
                                let borderColor = Color.black//.opacity(0.25)
                                let blockHeight:CGFloat = self.normalizeBlockHeight(blockHeight: m.size.height / 2)
                                
                                HStack {
                                    MonoChromaticBlocks(tabSelection: $tabSelection)
                                        .border(borderColor, width: 1)
                                        .frame(height:blockHeight)
                                    
                                    AnalogBlocks(tabSelection: $tabSelection)
                                        .border(borderColor, width: 1)
                                        .frame(height:blockHeight)
                                }
                                
                                HStack {
                                    ComplementaryBlocks(tabSelection: $tabSelection)
                                        .border(borderColor, width: 1)
                                        .frame(height:blockHeight)
                                    
                                      TriadicBlocks(tabSelection: $tabSelection)
                                        .border(borderColor, width: 1)
                                        .frame(height:blockHeight)
                                }
                                // .frame(height:blockHeight)
                            }
                        }
                    }
                }
            }.padding(5)
        }
    }
}

struct ColorCombinationView_Previews: PreviewProvider {
    static var previews: some View {
       /* Landscape {
            PreviewLandscapeWrapper()
        }
        
        Portrait {*/
            PreviewPortraitWrapper()
       // }
    }
    
    struct PreviewLandscapeWrapper: View {
        var tabSelection: Binding = .constant(0)
        
        var body: some View {
            ColorCombinationView(showTitle: true, tabSelection: tabSelection, orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
        }
    }
    
    struct PreviewPortraitWrapper: View {
        var tabSelection: Binding = .constant(0)
        
        var body: some View {
            ColorCombinationView(showTitle: true, tabSelection: tabSelection, orientation: .portrait)
                .environmentObject(AppModel())
        }
    }
}
