//
//  Repository.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 06/05/21.
//

import SwiftUI

class Repository {
    static let shared = Repository()
    
    let maxDark = 90.0 // 30.0
    let maxDarkForGray = 30.0 // 30.0
    let unselectedColorDegrees:[Color]
    
    let allColors =  [
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
    
    var canvasHelper = CanvasHelper()
    
    init() {
        let factor = self.maxDarkForGray / 8.0
        
        let baseColor = UIColor.white
        
        self.unselectedColorDegrees = [
            Color(UIColor.darker(color:baseColor, by: CGFloat(8 * factor))),
            Color(UIColor.darker(color:baseColor, by: CGFloat(7 * factor))),
            Color(UIColor.darker(color:baseColor, by: CGFloat(6 * factor))),
            Color(UIColor.darker(color:baseColor, by: CGFloat(5 * factor))),
            Color(UIColor.darker(color:baseColor, by: CGFloat(4 * factor))),
            Color(UIColor.darker(color:baseColor, by: CGFloat(3 * factor))),
            Color(UIColor.darker(color:baseColor, by: CGFloat(2 * factor))),
            Color(UIColor.darker(color:baseColor, by: CGFloat(1 * factor))),
        ]
    }
    
    func circle_color_yellow() -> Color { return canvasHelper.circleColors[.yellow, default: Color.gray] }
    func circle_color_yellowGreen() -> Color { return canvasHelper.circleColors[.yellowGreen, default: Color.gray] }
    func circle_color_green() -> Color { return canvasHelper.circleColors[.green, default: Color.gray] }
    func circle_color_greenBlue() -> Color { return canvasHelper.circleColors[.greenBlue, default: Color.gray] }
    func circle_color_blue() -> Color { return canvasHelper.circleColors[.blue, default: Color.gray] }
    func circle_color_blueViolet() -> Color { return canvasHelper.circleColors[.blueViolet, default: Color.gray] }
    func circle_color_violet() -> Color { return canvasHelper.circleColors[.violet, default: Color.gray] }
    func circle_color_violetRed() -> Color { return canvasHelper.circleColors[.violetRed, default: Color.gray] }
    func circle_color_red() -> Color { return canvasHelper.circleColors[.red, default: Color.gray] }
    func circle_color_redOrange() -> Color { return canvasHelper.circleColors[.redOrange, default: Color.gray] }
    func circle_color_orange() -> Color { return canvasHelper.circleColors[.orange, default: Color.gray] }
    func circle_color_orangeYellow() -> Color { return canvasHelper.circleColors[.orangeYellow, default: Color.gray] }
    
    func getColors() -> [CircleColorEnum] {
        return allColors
    }
    
    func getLocalizedColorName(color:CircleColorEnum) -> String {
        switch color {
        case .yellow:
            return String.getLocalizedString(name:"Yellow")
        case .yellowGreen:
            return String.getLocalizedString(name:"Yellow-Green")
        case .green:
            return String.getLocalizedString(name:"Green")
        case .greenBlue:
            return String.getLocalizedString(name:"Green-Blue")
        case .blue:
            return String.getLocalizedString(name:"Blue")
        case .blueViolet:
            return String.getLocalizedString(name:"Blue-Violet")
        case .violet:
            return String.getLocalizedString(name:"Violet")
        case .violetRed:
            return String.getLocalizedString(name:"Violet-Red")
        case .red:
            return String.getLocalizedString(name:"Red")
        case .redOrange:
            return String.getLocalizedString(name:"Red-Orange")
        case .orange:
            return String.getLocalizedString(name:"Orange")
        case .orangeYellow:
            return String.getLocalizedString(name:"Orange-Yellow")
        }
    }
    
    func getColorName(color:CircleColorEnum) -> String {
        switch color {
        case .yellow:
            return "Yellow"
        case .yellowGreen:
            return "Yellow-Green"
        case .green:
            return "Green"
        case .greenBlue:
            return "Green-Blue"
        case .blue:
            return "Blue"
        case .blueViolet:
            return "Blue-Violet"
        case .violet:
            return "Violet"
        case .violetRed:
            return "Violet-Red"
        case .red:
            return "Red"
        case .redOrange:
            return "Red-Orange"
        case .orange:
            return "Orange"
        case .orangeYellow:
            return "Orange-Yellow"
        }
    }
    
    func getAnalogColors(color:CircleColorEnum) -> [CircleColorEnum] {
        return canvasHelper.getAnalogColors(color:color)
    }
    
    func getComplementaryColor(color: CircleColorEnum) -> CircleColorEnum {
        return canvasHelper.getComplementaryColor(color: color)
    }
    
    func getDoubleComplementaryColors(color: CircleColorEnum) -> [CircleColorEnum] {
        return canvasHelper.getDoubleComplementaryColors(color:color)
    }
    
    func getRingShadowOrTintColor(appModel: AppModel,ringColor:Color) -> Color {
        if appModel.selectedWheelHue == .dark {
            return  Color.darker(color: ringColor, by: CGFloat(appModel.shadeOrTint))
        }
        
        return  Color.lighter(color: ringColor, by: CGFloat(appModel.shadeOrTint))
    }
    

    func getRingColors(wheelHue:WheelHueEnum,from:Color) -> [Color] {
        let factor:Double = 1.0 / 8.0
        
         return [
            Color.custom_alpha(color: from, by: CGFloat(1.0 * factor)),
            Color.custom_alpha(color: from, by: CGFloat(2.0 * factor)),
            Color.custom_alpha(color: from, by: CGFloat(3.0 * factor)),
            Color.custom_alpha(color: from, by: CGFloat(4.0 * factor)),
            Color.custom_alpha(color: from, by: CGFloat(5.0 * factor)),
            Color.custom_alpha(color: from, by: CGFloat(6.0 * factor)),
            Color.custom_alpha(color: from, by: CGFloat(7.0 * factor)),
            Color.custom_alpha(color: from, by: CGFloat(8.0 * factor)),
        ]
    }
    
    /*let selectedColorBase = UIColor(from)
     let factor = self.maxDark / 8.0
     
     if wheelHue==WheelHueEnum.bright {
     return [
     from,
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(1 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(2 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(3 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(4 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(5 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(6 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(7 * factor))),
     ]
     } else {
     return [
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(7 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(6 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(5 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(4 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(3 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(2 * factor))),
     Color(UIColor.darker(color:selectedColorBase, by: CGFloat(1 * factor))),
     from
     ]
     }*/
    
    func getSplitComplementaryColors(color: CircleColorEnum) -> [CircleColorEnum] {
        return canvasHelper.getSplitComplementaryColors(color:color);
    }
    
    func getTextColor(color:CircleColorEnum) -> Color {
        switch color {
        case .yellow,.green, .yellowGreen, .orangeYellow:
            return Color.black
        case .greenBlue, .blue, .blueViolet, .violet,.violetRed, .red, .redOrange, .orange:
            return Color.white
        }
    }
    
    func getTriadicColors(color:CircleColorEnum) -> [CircleColorEnum] {
        return canvasHelper.getTriadicColors(color:color)
    }
    
    func getColorFromCircleColorEnum(color: CircleColorEnum) -> Color {
        return canvasHelper.getColorFromCircleColorEnum(color: color)
    }
}


struct SecondaryColorGreenShape: Shape {   // Paths
    func path(in rect: CGRect) -> Path {
        let helper = DrawHelper()
        return helper.secondaryColorGreenPath(rect:rect)
    }
}

struct SecondaryColorVioletShape: Shape {   // Paths
    func path(in rect: CGRect) -> Path {
        let helper = DrawHelper()
        return helper.secondaryColorVioletPath(rect:rect)
    }
}

struct SecondaryColorOrangeShape: Shape {   // Paths
    func path(in rect: CGRect) -> Path {
        let helper = DrawHelper()
        return helper.secondaryColorOrangePath(rect:rect)
    }
}

struct PrimaryColorBlueShape: Shape {   // Paths
    func path(in rect: CGRect) -> Path {
        let helper = DrawHelper()
        return helper.primaryColorBluePath(rect:rect)
    }
}

struct PrimaryColorRedShape: Shape {   // Paths
    func path(in rect: CGRect) -> Path {
        let helper = DrawHelper()
        return helper.primaryColorRedPath(rect:rect)
    }
}

struct PrimaryColorYellowShape: Shape {   // Paths
    func path(in rect: CGRect) -> Path {
        let helper = DrawHelper()
        return helper.primaryColorYellowPath(rect:rect)
    }
}
