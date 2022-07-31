//
//  ColorHelper.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 06/05/21.
//

import SwiftUI

enum PrimaryColorEnum {
    case yellow, blue, red
}

enum SecondaryColorEnum {
    case green, violet, orange
}

enum TertiaryColorEnum {
    case yellowGreen, greenBlue, blueViolet, violetRed, redOrange, orangeYellow
}

enum CircleColorEnum {
    case yellow, yellowGreen, green, greenBlue, blue, blueViolet, violet,violetRed, red,redOrange,orange, orangeYellow
    
}

class CanvasHelper {
    var circleColors = [CircleColorEnum: Color]()
   
    init() {
            circleColors[CircleColorEnum.yellow] = getPrimaryColor(color: PrimaryColorEnum.yellow)
           circleColors[CircleColorEnum.yellowGreen] = getTertiaryColor(color: .yellowGreen)
           circleColors[CircleColorEnum.green] = getSecondaryColor(color: SecondaryColorEnum.green)
           circleColors[CircleColorEnum.greenBlue] = getTertiaryColor(color: .greenBlue)
           circleColors[CircleColorEnum.blue] = getPrimaryColor(color: PrimaryColorEnum.blue)
           circleColors[CircleColorEnum.blueViolet] = getTertiaryColor(color: .blueViolet)
           circleColors[CircleColorEnum.violet] = getSecondaryColor(color: SecondaryColorEnum.violet)
           circleColors[CircleColorEnum.violetRed] = getTertiaryColor(color: .violetRed)
           circleColors[CircleColorEnum.red] = getPrimaryColor(color: PrimaryColorEnum.red)
           circleColors[CircleColorEnum.redOrange] = getTertiaryColor(color: .redOrange)
           circleColors[CircleColorEnum.orange] = getSecondaryColor(color: SecondaryColorEnum.orange)
           circleColors[CircleColorEnum.orangeYellow] = getTertiaryColor(color: .orangeYellow)
    }
    
    func getAnalogColors(color:CircleColorEnum) -> [CircleColorEnum] {
        switch color {
        case .yellow:
            return [.orangeYellow,.yellowGreen]
        case .yellowGreen:
            return [.yellow,.green]
        case .green:
            return [.yellowGreen,.greenBlue]
        case .greenBlue:
            return [.green,.blue]
        case .blue:
            return [.greenBlue,.blueViolet]
        case .blueViolet:
            return [.blue,.violet]
        case .violet:
            return [.blueViolet,.violetRed]
        case .violetRed:
            return [.violet,.red]
        case .red:
            return [.violetRed,.redOrange]
        case .redOrange:
            return [.red,.orange]
        case .orange:
            return [.redOrange,.orangeYellow]
        case .orangeYellow:
            return [.orange,.yellow]
        }
    }
    
    func getColorFromCircleColorEnum(color:CircleColorEnum) -> Color {
        return circleColors[color, default: Color.white]
    }
    
    func getComplementaryColor(color:CircleColorEnum) -> CircleColorEnum {
        switch color {
        case .yellow:
            return .violet
        case .yellowGreen:
            return .violetRed
        case .green:
            return .red
        case .greenBlue:
            return .redOrange
        case .blue:
            return .orange
        case .blueViolet:
            return .orangeYellow
        case .violet:
            return .yellow
        case .violetRed:
            return .yellowGreen
        case .red:
            return .green
        case .redOrange:
            return .greenBlue
        case .orange:
            return .blue
        case .orangeYellow:
            return .blueViolet
        }
    }
    
    func getDoubleComplementaryColors(color:CircleColorEnum) -> [CircleColorEnum] {
        switch color {
        case .yellow:
            return [.green,.violet,.red]
        case .yellowGreen:
            return [.greenBlue,.violetRed,.redOrange]
        case .green:
            return [.blue,.red,.orange]
        case .greenBlue:
            return [.blueViolet,.redOrange,.orangeYellow]
        case .blue:
            return [.violet,.orange,.yellow]
        case .blueViolet:
            return [.violetRed,.orangeYellow,.yellowGreen]
        case .violet:
            return [.red,.yellow,.green]
        case .violetRed:
            return [.redOrange,.yellowGreen,.greenBlue]
        case .red:
            return [.orange,.green,.blue]
        case .redOrange:
            return [.orangeYellow,.greenBlue,.blueViolet]
        case .orange:
            return [.yellow,.blue,.violet]
        case .orangeYellow:
            return [.yellowGreen,.blueViolet,.violetRed]
        }
    }
    
    func getPrimaryColor(color: PrimaryColorEnum) -> Color {
        switch color {
        case  PrimaryColorEnum.red:
            return Color(.sRGB, red:255/255, green:0, blue: 0)
        case  PrimaryColorEnum.yellow:
            return Color(.sRGB, red:255/255, green:255/255, blue: 0)
        case  PrimaryColorEnum.blue:
            return Color(.sRGB, red:0, green:0, blue: 255/255)
        }
    }
    
    func getSecondaryColor(color: SecondaryColorEnum) -> Color {
        switch color {
        case  SecondaryColorEnum.green:
            return Color(.sRGB, red:0, green:255/255, blue: 0)
        case  SecondaryColorEnum.violet:
            return Color(.sRGB, red:128/255, green:0, blue: 128/255)
        case  SecondaryColorEnum.orange:
            return Color(.sRGB, red:255/255, green:127/255, blue: 0)
        }
    }
   
    func getTertiaryColor(color: TertiaryColorEnum) -> Color {
        switch (color) {
        case TertiaryColorEnum.yellowGreen:
            return Color(.sRGB, red:128/255, green:255/255, blue: 0)
        case TertiaryColorEnum.greenBlue:
            return Color(.sRGB, red:0, green:127/255, blue: 127/255)
        case TertiaryColorEnum.blueViolet:
            return Color(.sRGB, red:63/255, green:0/255, blue: 192/255)
        case TertiaryColorEnum.violetRed:
            return Color(.sRGB, red:192/255, green:0/255, blue: 64/255)
        case TertiaryColorEnum.redOrange:
            return Color(.sRGB, red:255/255, green:64/255, blue: 0/255)
        case TertiaryColorEnum.orangeYellow:
            return Color(.sRGB, red:255/255, green:190/255, blue: 0/255)
        }
    }
  

    func getPrimaryColorOriginal(color: PrimaryColorEnum) -> Color {
        switch color {
        case  PrimaryColorEnum.red:
            return Color(red: 1, green: 0, blue: 0)
        //return Color(UIColor(red:255, green:0, blue: 0, alpha: 1))
        case  PrimaryColorEnum.yellow:
            return Color(red: 1, green: 1, blue: 0)
        // return Color(UIColor(red:255, green:255, blue: 0, alpha: 1))
        case  PrimaryColorEnum.blue:
            return Color(red: 0, green: 0, blue: 1)
        //  return Color(UIColor(red:0, green:0, blue: 255, alpha: 1))
        }
    }
    
    
    func getSecondaryColorOriginal(color: SecondaryColorEnum) -> Color {
        switch color {
        case  SecondaryColorEnum.green:
            return Color(red: 0, green: 1, blue: 0)
        //return Color(UIColor(red:0, green:255, blue: 0, alpha: 1))
        case  SecondaryColorEnum.violet:
            return mixColors(color1: getPrimaryColor(color: PrimaryColorEnum.blue),
                             color2: getPrimaryColor(color: PrimaryColorEnum.red));
        case  SecondaryColorEnum.orange:
            return mixColors(color1: getPrimaryColor(color: PrimaryColorEnum.yellow),
                             color2: getPrimaryColor(color: PrimaryColorEnum.red));
        }
    }
    
    func getSplitComplementaryColors(color:CircleColorEnum) -> [CircleColorEnum] {
        switch color {
        case .yellow:
            return [.blueViolet,.violetRed]
        case .yellowGreen:
            return [.violet,.red]
        case .green:
            return [.violetRed,.redOrange]
        case .greenBlue:
            return [.red,.orange]
        case .blue:
            return [.redOrange,.orangeYellow]
        case .blueViolet:
            return [.orange,.yellow]
        case .violet:
            return [.orangeYellow,.yellowGreen]
        case .violetRed:
            return [.yellow,.green]
        case .red:
            return [.yellowGreen,.greenBlue]
        case .redOrange:
            return [.green,.blue]
        case .orange:
            return [.greenBlue,.blueViolet]
        case .orangeYellow:
            return [.blue,.violet]
        }
    }
    
     func getTertiaryColorOriginal(color: TertiaryColorEnum) -> Color {
        switch (color) {
        case TertiaryColorEnum.yellowGreen:
            return mixColors(color1: getPrimaryColor(color: PrimaryColorEnum.yellow),
                             color2: getSecondaryColor(color: SecondaryColorEnum.green));
        case TertiaryColorEnum.greenBlue:
            return mixColors(color1: getSecondaryColor(color: SecondaryColorEnum.green),
                             color2: getPrimaryColor(color: PrimaryColorEnum.blue));
        case TertiaryColorEnum.blueViolet:
            return mixColors(color1: getPrimaryColor(color: PrimaryColorEnum.blue),
                             color2: getSecondaryColor(color: SecondaryColorEnum.violet));
        case TertiaryColorEnum.violetRed:
            return mixColors(color1: getSecondaryColor(color: SecondaryColorEnum.violet),
                             color2: getPrimaryColor(color: PrimaryColorEnum.red));
        case TertiaryColorEnum.redOrange:
            return mixColors(color1: getPrimaryColor(color: PrimaryColorEnum.red),
                             color2: getSecondaryColor(color: SecondaryColorEnum.orange));
        case TertiaryColorEnum.orangeYellow:
            return mixColors(color1: getSecondaryColor(color: SecondaryColorEnum.orange),
                             color2: getPrimaryColor(color: PrimaryColorEnum.yellow));
        }
    }
 
    func getTriadicColors(color:CircleColorEnum) -> [CircleColorEnum] {
        switch color {
        case .yellow:
            return [.blue,.red]
        case .yellowGreen:
            return [.blueViolet,.redOrange]
        case .green:
            return [.violet,.orange]
        case .greenBlue:
            return [.violetRed,.orangeYellow]
        case .blue:
            return [.red,.yellow]
        case .blueViolet:
            return [.redOrange,.yellowGreen]
        case .violet:
            return [.orange,.green]
        case .violetRed:
            return [.orangeYellow,.greenBlue]
        case .red:
            return [.yellow,.blue]
        case .redOrange:
            return [.yellowGreen,.blueViolet]
        case .orange:
            return [.green,.violet]
        case .orangeYellow:
            return [.greenBlue,.violetRed]
        }
    }
    
    func mixColorsOriginal(color1:Color,color2:Color) -> Color {
        let c1 = CIColor(color: UIColor(color1))
        let c2 = CIColor(color: UIColor(color2))
        
        let r = (c1.red * 0.5) + (c2.red * 0.5)
        let g = (c1.green * 0.5) + (c2.green * 0.5)
        let b = (c1.blue * 0.5) + (c2.blue * 0.5)
        let a = (c1.alpha * 0.5) + (c2.alpha * 0.5);
        
        let ui = UIColor(red:r, green:g, blue: b, alpha: a)
        let result = Color(ui)
        
        return result
    }
    
    func mixColors(color1:Color,color2:Color) -> Color {
        let c1 = CIColor(color: UIColor(color1))
        let c2 = CIColor(color: UIColor(color2))
        
        let r = (c1.red * 0.5) + (c2.red * 0.5)
        let g = (c1.green * 0.5) + (c2.green * 0.5)
        let b = (c1.blue * 0.5) + (c2.blue * 0.5)
        // let a = (c1.alpha * 0.5) + (c2.alpha * 0.5);
        
        let ui = UIColor(red:r, green:g, blue: b, alpha: 1)
        //  let ui = UIColor(red:r, green:g, blue: b, alpha: a)
        let result = Color(ui)
        
        return result
    }
    
    func convertRGAToColor(color: Color) -> Color {
        let c = CIColor(color: UIColor(color))
        let ui = UIColor(red:c.red/255, green:c.green/255, blue: c.blue/255, alpha: 1)
        let result = Color(ui)
        return result
    }
}
