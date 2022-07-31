//
//  ChromaticCircleView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 28/05/21.
//

import SwiftUI

struct ChromaticCircleView: View {
    @State var orientation : UIDeviceOrientation
    
    init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
        Group {
            switch orientation {
            case    UIDeviceOrientation.landscapeRight:
                ChromaticCircleLandscapeView()
            default:
                ChromaticCirclePortraitView()
                
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

struct  ChromaticCirclePortraitView: View {
    @EnvironmentObject var appModel: AppModel
    
    let activeColor = Color(UIColor(named: "circle_color_name_active") ?? UIColor.white).opacity(0.50)
    
    var body: some View {
        VStack (spacing:0) {
            Text(LocalizedStringKey("Chromatic-Circle"))
                .font(Font.title)
            
            Spacer(minLength: 20)
            
            GeometryReader { m1 in
                VStack(spacing:0) {
                    ChromaticCircle(isSplashScreen: false,wheelType: .none,showSelection: false,selectAll: true)
                    
                    /*if !appModel.isSliderVisible {
                        VStack {
                            Text(LocalizedStringKey("Tap-Here-To-Show-Sliders"))
                                .font(.caption)
                                .foregroundColor(activeColor)
                                .onTapGesture {
                                    withAnimation {
                                        appModel.isSliderVisible = true
                                    }
                                }
                            
                            Spacer()
                                .frame(height:20)
                            
                            HStack(spacing:0) {
                                Text(LocalizedStringKey("Brightness"))
                                Text(String(format: ": %.0f%%  ", appModel.brightness))
                                Text(LocalizedStringKey("Saturation"))
                                Text(String(format: ": %.0f%%  ", appModel.saturation))
                                Text(LocalizedStringKey(appModel.selectedWheelHue == .dark ? "Shade" : "Tint"))
                                Text(String(format: ": %.0f%%", appModel.shadeOrTint))
                            }
                            .font(.caption)
                            
                            Spacer()
                                .frame(height:20)
                        }
                        .padding()
                        .foregroundColor(activeColor)
                    }
                    else {
                        ChromaticCircleSliders()
                        
                        Text(LocalizedStringKey("Tap-Here-To-Hide-Sliders"))
                            .font(.caption)
                            .foregroundColor(activeColor)
                            .onTapGesture {
                                withAnimation {
                                    appModel.isSliderVisible = false
                                }
                            }
                        
                        Spacer()
                            .frame(height:20)
                    }*/
                }
            }
        }
    }
}

struct  ChromaticCircleLandscapeView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        GeometryReader { m in
            VStack (spacing:0) {
                GeometryReader { m1 in
                    HStack(spacing:0) {
                        ChromaticCircle(isSplashScreen: false,wheelType: .chromatic,showSelection: true,selectAll: true, showPicker: false)
                            .frame(width: m1.size.width * 0.50)
                        
                        Divider()
                        
                        GeometryReader { m2 in
                            VStack() {
                                Text(LocalizedStringKey("Chromatic-Circle"))
                                    .font(Font.title)
                                
                                showWheelHuePicker()
                                    .padding(.horizontal,5)
                                
                                /*if !appModel.isSliderVisible {
                                    VStack {
                                        Text(LocalizedStringKey("Tap-Here-To-Show-Sliders"))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .onTapGesture {
                                                withAnimation {
                                                    appModel.isSliderVisible = true
                                                }
                                            }
                                        
                                        Spacer()
                                            .frame(height:10)
                                        
                                        VStack {
                                            HStack(spacing:0) {
                                                Text(LocalizedStringKey("Brightness"))
                                                Text(String(format: ": %.0f%%  ", appModel.brightness))
                                            }
                                        }
                                        .font(.caption)
                                        
                                        VStack {
                                            HStack(spacing:0) {
                                                Text(LocalizedStringKey("Saturation"))
                                                Text(String(format: ": %.0f%%  ", appModel.saturation))
                                            }
                                        }
                                        .font(.caption)
                                        
                                        VStack {
                                            HStack(spacing:0) {
                                              Text(LocalizedStringKey(appModel.selectedWheelHue == .dark ? "Shade" : "Tint"))
                                                Text(String(format: ": %.0f%%", appModel.shadeOrTint))
                                            }
                                        }
                                        .font(.caption)
                                        
                                        Spacer()
                                            .frame(height:40)
                                    }
                                    .frame(height: m.size.height*0.5)
                                    .padding()
                                    .foregroundColor(.black.opacity(0.50))
                                }
                                else {
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
                                        .frame(height:20)
                                }*/
                            }
                            .frame(height: m.size.height)
                        }
                        .frame(height: m1.size.height)
                    }
                }
            }
        }
    }
}

struct  ChromaticCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ChromaticCircleView(orientation: .portrait)
            .environmentObject(AppModel())
        
        /*Landscape {
            ChromaticCircleView(orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
        }*/
    }
}
