//
//  Global.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 04/05/21.
//

import SwiftUI

enum LanguageEnum {
    case pt,en,es
}

enum TitlePositionEnum {
    case top,left
}

enum ColorDetailLevelEnum {
    case blocks,list
}

enum WheelHueEnum: Int {
    case bright,dark
}

enum WheelTypeEnum {
    case none,chromatic,monochromatic,analog,complementary,splitComplementary,doubleComplementary,triadic
}

enum HelpPageIndexEnum {
    case menu,primaryColors,secondaryColors,tertiaryColors,chromaticCircle,colorSelection,colorCombination,monochromatic,analog,complementary,triadic
}

class AppModel: ObservableObject {
    @Published var brightness: Double {
        didSet {
            UserDefaults.standard.set(brightness, forKey: "brightness")
        }
    }
   
    @Published var colorDetailsLevel: ColorDetailLevelEnum = .blocks
    @Published var debug: String = "Debug"
    @Published var helpPageIndex: HelpPageIndexEnum = .menu
    @Published var isSliderVisible: Bool = false
  
    @Published var saturation: Double {
        didSet {
            UserDefaults.standard.set(saturation, forKey: "saturation")
        }
    }
    
    @Published var savedSelectedColor: CircleColorEnum = .yellow
    @Published var selectedColor: CircleColorEnum = .yellow
    @Published var selectedColors: [CircleColorEnum] = []
    @Published var selectedColorDetail: CircleColorEnum = .red //.yellow
    @Published var selectedColorDetailIndex: Int = 0
    @Published var selectedColorDetailRawColor: Color = .yellow
    @Published var selectedMenu: Int = 1
    
    @Published var orientation: UIDeviceOrientation = .portrait
    @Published var tabSelection: Int = 0
   
    @Published var selectedWheelHue: WheelHueEnum {
        didSet {
            UserDefaults.standard.set(selectedWheelHue.rawValue, forKey: "wheelHue")
        }
    }
 
    @Published var selectedWheelType: WheelTypeEnum = .monochromatic
   
    @Published var shadeOrTint: Double {
        didSet {
            UserDefaults.standard.set(shadeOrTint, forKey: "shadeOrTint")
        }
    }
    
    
    init() {
        self.brightness = (UserDefaults.standard.object(forKey: "brightness") == nil ? 0.0 : UserDefaults.standard.object(forKey: "brightness") as! Double)
        
        self.saturation = (UserDefaults.standard.object(forKey: "saturation") == nil ? 100.0 : UserDefaults.standard.object(forKey: "saturation") as! Double)
        
        self.selectedWheelHue = (UserDefaults.standard.object(forKey: "wheelHue") == nil ? WheelHueEnum.bright : WheelHueEnum(rawValue: UserDefaults.standard.object(forKey: "wheelHue") as! Int)) ?? WheelHueEnum.bright
        
        self.shadeOrTint = (UserDefaults.standard.object(forKey: "shadeOrTint") == nil ? 25.0 : UserDefaults.standard.object(forKey: "shadeOrTint") as! Double)
    }
    
    func getSelectedColor() -> Color {
        return Repository.shared.getColorFromCircleColorEnum(color: selectedColor)
    }
    
    func getSelectedWheelTypeNumText() -> Text {
        switch selectedWheelType {
        case .none:
            return Text("Selected color wheel")
        case .chromatic:
            return Text(LocalizedStringKey("Chromatic-Circle"))
        case .monochromatic:
            return Text(LocalizedStringKey("Monochromatic"))
        case .analog:
            return Text(LocalizedStringKey("Analog"))
        case .complementary:
            return Text(LocalizedStringKey("Complementary"))
        case .triadic:
            return Text(LocalizedStringKey("Triadic"))
        case .splitComplementary:
            return Text(LocalizedStringKey("Split-Complementary"))
        case .doubleComplementary:
            return Text(LocalizedStringKey("Double-Complementary"))
        }
    }
  
    func getTranslatedSelectedWheelString() -> String {
        switch selectedWheelType {
        case .none:
            return String.getLocalizedString(name: "Selected color wheel")
        case .chromatic:
            return String.getLocalizedString(name: "Chromatic-Circle")
        case .monochromatic:
            return String.getLocalizedString(name: "Monochromatic")
        case .analog:
            return String.getLocalizedString(name: "Analog")
        case .complementary:
            return String.getLocalizedString(name: "Complementary")
        case .triadic:
            return String.getLocalizedString(name: "Triadic")
        case .splitComplementary:
            return String.getLocalizedString(name: "Split-Complementary")
       case .doubleComplementary:
            return String.getLocalizedString(name: "Double-Complementary")
        }
    }
    
    func colorIsSelected(color: CircleColorEnum) -> Bool {
        return selectedColors.contains(color);
    }
    
    func getColorsFromWheelType(wheelType: WheelTypeEnum) -> [CircleColorEnum] {
        switch wheelType {
        case .none, .chromatic:
            return []
        case .monochromatic:
            return [selectedColor]
        case .analog:
            return  Repository.shared.getAnalogColors(color: selectedColor)
        case .complementary:
            return  [Repository.shared.getComplementaryColor(color: selectedColor)]
        case .triadic:
            return Repository.shared.getTriadicColors(color: selectedColor)
        case .splitComplementary:
            return Repository.shared.getSplitComplementaryColors(color:selectedColor)
        case .doubleComplementary:
            return Repository.shared.getDoubleComplementaryColors(color: selectedColor)
        }
    }
    
    func isColorFromWheelType(wheelType: WheelTypeEnum, color: CircleColorEnum) -> Bool {
        if selectedColor==color {
            return true
        }
        let colorsFromSelectedWheelType = getColorsFromWheelType(wheelType: wheelType)
        return colorsFromSelectedWheelType.contains(color)
    }
    
    public func setSelectedWheelType(wheelType:WheelTypeEnum)  {
        selectedWheelType = wheelType
    }
}
