//
//  ColorDetailsView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct DetailBlockView: View {
    @EnvironmentObject var appModel: AppModel
    
    let color:Color;
    let index:Int;
    
    var body: some View {
        VStack {
            Text(String(index))
                .font(.caption)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(color)
                .foregroundColor(Repository.shared.getTextColor(color: appModel.selectedColorDetail))
                .border(Color.gray, width: 0.4)
        }
        .onTapGesture {
            appModel.isSliderVisible = false
            appModel.selectedColorDetailRawColor = color
            appModel.selectedColorDetailIndex = index
            //appModel.colorDetailsLevel = .full
        }
    }
}

struct ListOfColorDetailsLandscapeView: View {
    @EnvironmentObject var appModel: AppModel
    
    @State var foreColor:Color
    @State var showTitle: Bool
    @State var orientation : UIDeviceOrientation
    
    init(foreColor:Color = .black,showTitle:Bool = true, orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.foreColor = foreColor
        self.showTitle = showTitle
        self.orientation = orientation
    }
    
    func getTitle(appModel: AppModel) -> String {
        return appModel.getTranslatedSelectedWheelString() + "  [ " +
            String.getLocalizedString(name: Repository.shared.getColorName(color: appModel.selectedColor)) + " ]"
    }
    
    var body: some View {
        let rawColor:Color = Repository.shared.getColorFromCircleColorEnum(color: .yellow);
        
        let ringColors = Repository.shared.getRingColors(wheelHue:appModel.selectedWheelHue, from: rawColor)
        
        GeometryReader { m in
            HStack {
                VStack(spacing:0) {
                    TextBlock(Text(getTitle(appModel: appModel)),
                              backColor: Color.gray.opacity(0.5), foreColor: foreColor, height: m.size.height * 0.10)
                    
                    let factor:CGFloat = 1.0 / 8.0
                    
                    VStack {
                        ForEach(0..<8) {
                            let ringColor = Repository.shared.getRingShadowOrTintColor(appModel: appModel, ringColor: ringColors[$0])
                            
                            DetailBlockView(color: ringColor,index: $0+1)
                                .frame(height: (m.size.height*0.9) * factor)
                            
                        }
                    }
                    .brightness(appModel.brightness * 0.01)
                    .saturation(appModel.saturation * 0.01)
                }
                .frame(width: m.size.width*0.5)
                
                Divider()
                    .frame(width: m.size.width*0.001)
                
                ZStack {
                    GeometryReader { m1 in
                        if !appModel.isSliderVisible {
                            VStack(spacing:0) {
                                showWheelHuePicker()
                                    .frame(width:m1.size.width, height: m1.size.height*0.10)
                                
                                VStack(spacing:0) {
                                    Text(LocalizedStringKey("Tap-Here-To-Show-Sliders"))
                                        .font(.caption)
                                        .onTapGesture {
                                            withAnimation {
                                                appModel.isSliderVisible = true
                                            }
                                        }
                                    //     .frame(height:5)
                                    
                                    HStack(spacing:0) {
                                        Text(LocalizedStringKey("Brightness"))
                                        Text(String(format: ": %.0f%%  ", appModel.brightness))
                                        Text(LocalizedStringKey("Saturation"))
                                        Text(String(format: ": %.0f%%  ", appModel.saturation))
                                        Text(LocalizedStringKey(appModel.selectedWheelHue == .dark ? "Shade" : "Tint"))
                                        Text(String(format: ": %.0f%%", appModel.shadeOrTint))
                                    }
                                    .font(.caption)
                                }
                                .frame(width:m1.size.width, height: m1.size.height*0.9)
                            }
                            .frame(width:m1.size.width, height: m1.size.height)
                            .padding()
                            .foregroundColor(.gray)
                            
                        }
                        else {
                            VStack(spacing:0) {
                                showWheelHuePicker()
                                ChromaticCircleSliders()
                                Text(LocalizedStringKey("Tap-Here-To-Hide-Sliders"))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        withAnimation {
                                            appModel.isSliderVisible = false
                                        }
                                    }
                            }
                            .frame(width:m1.size.width, height: m1.size.height)
                        }
                    }
                }
                .frame(width: m.size.width*0.47, height: m.size.height)
            }
        }
    }
}

struct ListOfColorDetailsPortraitView: View {
    @EnvironmentObject var appModel: AppModel
    @State var foreColor:Color
    
    @State var showTitle: Bool
    @State var orientation : UIDeviceOrientation
    
    init(foreColor:Color = .black,showTitle:Bool = true, orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.foreColor = foreColor
        self.showTitle = showTitle
        self.orientation = orientation
    }
    
    func getTitle(appModel: AppModel) -> String {
        return appModel.getTranslatedSelectedWheelString() + "  [ " +
            String.getLocalizedString(name: Repository.shared.getColorName(color: appModel.selectedColor)) + " ]"
    }
    
    var body: some View {
        let rawColor:Color = Repository.shared.getColorFromCircleColorEnum(color: .yellow);
        
        let ringColors = Repository.shared.getRingColors(wheelHue:appModel.selectedWheelHue, from: rawColor)
        
        if showTitle {
            TextBlock(Text(getTitle(appModel: appModel)),
                      backColor: Color.gray.opacity(0.5), foreColor: foreColor, height: 50)
        }
        
        GeometryReader { m in
            VStack() {
                Spacer()
                    .frame(height: m.size.height * 0.005)
                
                ZStack {
                    GeometryReader { m1 in
                        VStack(spacing:0) {
                            let factor:CGFloat = 1.0 / 8.0
                            
                            GeometryReader { m2 in
                                VStack {
                                    ForEach(0..<8) {
                                        let ringColor = Repository.shared.getRingShadowOrTintColor(appModel: appModel, ringColor: ringColors[$0])
                                        
                                        DetailBlockView(color: ringColor,index: $0+1)
                                            .frame(height: m2.size.height * factor)
                                        
                                    }
                                    .brightness(appModel.brightness * 0.01)
                                    .saturation(appModel.saturation * 0.01)
                                }
                            }
                            .frame(width: m1.size.width, height: m.size.height *  (!appModel.isSliderVisible ? 0.90 : 0.55))
                            
                            
                            if !appModel.isSliderVisible {
                                VStack {
                                    Text(LocalizedStringKey("Tap-Here-To-Show-Sliders"))
                                        .font(.caption)
                                    
                                    Spacer()
                                        .frame(height:5)
                                    
                                    HStack(spacing:0) {
                                        Text(LocalizedStringKey("Brightness"))
                                        Text(String(format: ": %.0f%%  ", appModel.brightness))
                                        Text(LocalizedStringKey("Saturation"))
                                        Text(String(format: ": %.0f%%  ", appModel.saturation))
                                        Text(LocalizedStringKey(appModel.selectedWheelHue == .dark ? "Shade" : "Tint"))
                                        Text(String(format: ": %.0f%%", appModel.shadeOrTint))
                                    }
                                    .font(.caption)
                                }
                                .padding()
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    withAnimation {
                                        appModel.isSliderVisible = true
                                    }
                                }
                                //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                .frame(width: m1.size.width, height: m.size.height * 0.1)
                            }
                            else {
                                VStack {
                                    Spacer()
                                        .frame(height:5)
                                    showWheelHuePicker()
                                    ChromaticCircleSliders()
                                    Text(LocalizedStringKey("Tap-Here-To-Hide-Sliders"))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .onTapGesture {
                                            withAnimation {
                                                appModel.isSliderVisible = false
                                            }
                                        }
                                    Spacer()
                                        .frame(height:5)
                                }
                                .frame(width: m1.size.width,
                                       height:  m1.size.height * 0.45)
                            }
                        }
                    }
                }
                .frame(height: m.size.height * 0.995)
            }
        }
    }
}

struct ColorDetailsBackButtonView:View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        Button(action: {
            appModel.colorDetailsLevel = .blocks
            appModel.isSliderVisible = false
        })
        {
            HStack {
                Image(systemName: "arrow.backward.circle")
                Text(LocalizedStringKey("Back"))
            }
        }
        .buttonStyle(CustomButtonStyle())
    }
}

struct ColorDetailsView: View {
    @EnvironmentObject var appModel: AppModel
    @State var foreColor:Color
    @State var showTitle: Bool
    @State var orientation : UIDeviceOrientation
    
    init(foreColor:Color = .black,showTitle:Bool = true, orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.foreColor = foreColor
        self.showTitle = showTitle
        self.orientation = orientation
    }
    
    var body: some View {
        GeometryReader { m in
            VStack(spacing:0) {
                Group {
                    switch orientation {
                    case    UIDeviceOrientation.unknown,
                            UIDeviceOrientation.landscapeLeft:
                        UnsupportedOrientationView()
                    case    UIDeviceOrientation.landscapeRight:
                        ListOfColorDetailsLandscapeView(foreColor:foreColor, showTitle: showTitle, orientation: orientation)
                        //Spacer()
                       // ColorDetailsBackButtonView()
                    default:
                        ListOfColorDetailsPortraitView(foreColor:foreColor, showTitle: showTitle, orientation: orientation)
                       // Spacer()
                       // ColorDetailsBackButtonView()
                    //.frame(height:10)
                    }
                }
                .onRotate { newOrientation in
                    orientation = newOrientation
                }
            }
            .frame(width:m.size.width,height:m.size.height)
        }
    }
}


struct ColorDetailsView_Previews: PreviewProvider {
    static var previews: some View {
       /* Landscape {
            ColorDetailsView(orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
                .previewLayout(.fixed(width: 2436 / 3.0, height: (1125 / 3.0)-80)) }
        
        Portrait {*/
         ColorDetailsView(orientation: .portrait)
         .environmentObject(AppModel())
       //  }
    }
}
