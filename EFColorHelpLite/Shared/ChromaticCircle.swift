//
//  ChromaticCircle.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 07/05/21.
//

import SwiftUI

struct SliceCircleColor: Shape {
    let startAngle: Double
    let endAngle: Double
    var lineWidth: CGFloat = 1
    let radius:CGFloat
    var lineCap: CGLineCap = .butt
    
    func path(in rect: CGRect) -> Path {
        return Path() {
            $0.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: radius,
                startAngle: Angle(degrees:startAngle),
                endAngle: Angle(degrees:endAngle),
                clockwise: false)
        }
        .strokedPath(
            StrokeStyle(lineWidth: lineWidth, lineCap: lineCap)
        )
    }
}

struct ChromaticWheelSlice: View {
    @EnvironmentObject var appModel: AppModel
    
    private let selectAll:Bool
    private let showSelection:Bool
    private let start:Double
    private let end:Double
    private let color:CircleColorEnum
    private let wheelType: WheelTypeEnum
    
    init(index: Int, color: CircleColorEnum, wheelType: WheelTypeEnum, showSelection:Bool, selectAll:Bool) {
        self.start = (30.0 * Double(index)) + 0.0
        self.end = (start + 30) - 0.0
        self.color = color
        self.wheelType = wheelType
        self.showSelection = showSelection
        self.selectAll = selectAll
    }
    
    var body: some View {
        GeometryReader { m in
            let isColorFromSelectedWheelType = (appModel.isColorFromWheelType(wheelType: wheelType, color: color) || selectAll)
            
            let theColor =  Repository.shared.getColorFromCircleColorEnum(color: color)
            
            
            let ringColors = Repository.shared.getRingColors(wheelHue:appModel.selectedWheelHue, from: theColor)
            
            let unselected = Repository.shared.getRingColors(wheelHue: .bright, from: Color(.sRGB, red:0.754, green:0.754, blue:0.754, opacity: 1))
            
            let maxLevel:Int = 8
            let diameter:CGFloat = m.size.width>m.size.height ? m.size.height : m.size.width
            let radius:CGFloat = diameter / 2.0
            let slice_radius:CGFloat = radius / CGFloat(maxLevel)
            // O Vazio no meio do circulo é devido ao stroke da linha ser
            // centralizado
            
            ZStack {
                ForEach(0...maxLevel-1, id: \.self) { index in
                    let ringColor = Repository.shared.getRingShadowOrTintColor(appModel: appModel, ringColor: ringColors[index])
                    
                    SliceCircleColor(startAngle: start, endAngle: end,
                                     lineWidth: slice_radius,
                                     radius: slice_radius * (CGFloat(index)+1.0))
                        .foregroundColor(isColorFromSelectedWheelType ? ringColor : unselected[index])
                  }
            }
        }
    }
}

struct RotatedText:View {
    let text: Text
    let degrees: Double
    
    var body: some View {
        text
            .frame(maxHeight: .infinity, alignment: .top)
            .rotationEffect(.degrees(degrees))
    }
}

struct ChromaticCircleSliders: View {
    @EnvironmentObject var appModel: AppModel
    let activeColor = Color(UIColor(named: "circle_color_name_active") ?? UIColor.white).opacity(0.50)
   
    var body: some View {
        VStack(spacing:0)  {
            Group {
                HStack {
                    Text(LocalizedStringKey("Brightness"))
                    Slider(value: $appModel.brightness, in: 0...100)
                    Text(String(format: "%.0f%%", appModel.brightness))
                }.frame(height: 40)
                
                HStack {
                    Text(LocalizedStringKey("Saturation"))
                        Slider(value: $appModel.saturation, in: 0...100)
                    Text(String(format: "%.0f%%", appModel.saturation))
                }.frame(height: 40)
                
                HStack {
                    Text(LocalizedStringKey(appModel.selectedWheelHue == .dark ? "Shade" : "Tint"))
                    Slider(value: $appModel.shadeOrTint, in: 0...100)
                    Text(String(format: "%.0f%%", appModel.shadeOrTint))
                }.frame(height: 40)
                
                HStack {
                    
                }.frame(height: 15)
            }
           // .padding()
            .font(.caption)
            .foregroundColor(activeColor)
        }
    }
}

struct ChromaticCircle: View {
    @EnvironmentObject var appModel: AppModel
     
    let colors: [CircleColorEnum]
    private let isSplashScreen: Bool
    private let ignoreTap: Bool
    private let selectAll: Bool
    private let showEFColorLite: Bool
    private let showSelection: Bool
    private let wheelType: WheelTypeEnum
    private let showColorNames: Bool
    private let showPicker: Bool
    private let width: CGFloat
    private let height: CGFloat
    
    init(ignoreTap:Bool=false, isSplashScreen:Bool, wheelType: WheelTypeEnum, showSelection: Bool, selectAll:Bool = false, width:CGFloat = 300,height: CGFloat = 300, showColorNames: Bool = true,showPicker: Bool = true,showEFColorLite: Bool = true) {
        self.wheelType = wheelType
        self.showEFColorLite = showEFColorLite
        self.showSelection = showSelection
        self.selectAll = selectAll
        self.isSplashScreen = isSplashScreen
        self.width = width
        self.height = height
        self.ignoreTap = ignoreTap
        self.showColorNames = showColorNames
        self.showPicker = showPicker
        
        self.colors = [
            CircleColorEnum.yellow,
            CircleColorEnum.yellowGreen,
            CircleColorEnum.green,
            CircleColorEnum.greenBlue,
            CircleColorEnum.blue,
            CircleColorEnum.blueViolet,
            CircleColorEnum.violet,
            CircleColorEnum.violetRed,
            CircleColorEnum.red,
            CircleColorEnum.redOrange,
            CircleColorEnum.orange,
            CircleColorEnum.orangeYellow
        ]
    }
    
     var body: some View {
        
        VStack {
             if (!isSplashScreen && showPicker) {
                showWheelHuePicker()
             }
            
            GeometryReader { m in
                let side:CGFloat = min(m.size.width,m.size.height)
                
                ZStack {
                    ZStack {
                        let circle = ZStack {
                            ForEach(0 ..< colors.endIndex) { index in
                                let chromaticSlice = ChromaticWheelSlice(index: index, color: colors[index], wheelType: wheelType,showSelection: showSelection,selectAll: selectAll)
                                
                                chromaticSlice
                                
                                if !ignoreTap {
                                    chromaticSlice
                                        .onTapGesture {
                                            appModel.selectedColor = colors[index]
                                        }
                                 }
                            }
                        }
                        .scaleEffect(0.88)
                        .rotationEffect(.degrees(-105))
                        
                        if isSplashScreen {
                            circle
                        }
                        else {
                            circle
                            .brightness(appModel.brightness * 0.01)
                            .saturation(appModel.saturation * 0.01)
                        }
                        
                        if (showColorNames && !appModel.isSliderVisible && !isSplashScreen) {
                            Text(showEFColorLite ? "EFColorHelp Lite" : "EFColorHelp" ) 
                                .font(Font.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.gray.opacity(0.5))
                                .zIndex(1)
                        }
                    }
                    .frame(width:side, height:side)
                    .scaleEffect(showColorNames ? 0.83 : 1.0)
                    
                    if (!isSplashScreen && showColorNames) {
                        ZStack {
                            Group {
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .yellow)), degrees: 0)
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .green)), degrees: 30)
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .green)), degrees: 60)
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .blue)), degrees: 90)
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .blue)), degrees: 120)
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .violet)), degrees: 150)
                            }
                            
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .violet)), degrees: 180)
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .red)), degrees: 210)
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .red)), degrees: 240)
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .orange)), degrees: 270)
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .orange)), degrees: 300)
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .yellow)), degrees: 330)
                        }
                        .frame(width:side, height:side)
                        .scaleEffect(0.90)
                        
                        ZStack {
                            Group {
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .yellow)), degrees: 30)
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .green)), degrees: 90)
                                RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .blue)), degrees: 150)
                            }
                            
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .violet)), degrees: 210)
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .red)), degrees: 270)
                            RotatedText(text : Text(Repository.shared.getLocalizedColorName(color: .orange)), degrees: 330)
                        }
                        .frame(width:side, height:side)
                        .scaleEffect(1)
                    }
                }
                .font( UIDevice.current.model=="iPad" ? .title3 : .footnote.weight(.thin))
                .frame(width: m.size.width, height: m.size.height)
            }
        }
    }
}

struct showWheelHuePicker: View {
    @EnvironmentObject var appModel: AppModel
   
    var body: some View {
        Picker(selection: $appModel.selectedWheelHue, label: Text(LocalizedStringKey("Settings-Ton")), content: {
            Text(LocalizedStringKey("Bright")).tag(WheelHueEnum.bright)
            Text(LocalizedStringKey("Dark")).tag(WheelHueEnum.dark)
        })
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .padding(.vertical, 0)
    }
}

struct ChromaticCircle_Previews: PreviewProvider {
    static var previews: some View {
        ChromaticCircle(isSplashScreen: false, wheelType: .analog,showSelection: false, selectAll: false)
            // .frame( width: 400, height: 400)
            .environmentObject(AppModel())
        //  .previewLayout(.fixed(width: 1024, height: 450)) // 768
    }
}
