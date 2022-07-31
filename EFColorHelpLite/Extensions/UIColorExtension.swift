//
//  color_extesion.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 04/05/21.
//

import SwiftUI

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    func toRGBAString(uppercased: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgba = [r, g, b, a].map { $0 * 255 }.reduce("", { $0 + String(format: "%02x", Int($1)) })
        return uppercased ? rgba.uppercased() : rgba
    }
    
    func toHex(alpha: Bool = false) -> String {
         guard let components = cgColor.components, components.count >= 3 else {
             return "?"
         }
      
        let r = Float(components[0])
         let g = Float(components[1])
         let b = Float(components[2])
         var a = Float(1.0)

         if components.count >= 4 {
             a = Float(components[3])
         }

         if alpha {
             return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
         } else {
             return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
         }
     }

    static func lighter(color:UIColor,by percentage: CGFloat = 30.0) -> UIColor {
        return UIColor.adjust(color: color, by: abs(percentage) )
    }
    
    static func darker(color:UIColor,by percentage: CGFloat = 30.0) -> UIColor {
        return UIColor.adjust(color: color, by: -1 * abs(percentage) )
    }
  
    static func adjust(color:UIColor,by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        }
        else {
            return UIColor.white
        }
    }
}

extension String {
    static func getLocalizedString(name:String) -> String {
        return NSLocalizedString(name, comment: "")
    }
}

extension Color {
    static func custom_alpha(color:Color,by percentage: CGFloat = 30.0) -> Color {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        
        UIColor(color).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            
        return Color(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: percentage))
     }
   
    static func lighter(color:Color,by percentage: CGFloat) -> Color {
        return Color(UIColor.adjust(color: UIColor(color), by: abs(percentage) ))
    }
    
    static func darker(color:Color,by percentage: CGFloat) -> Color {
        return Color(UIColor.adjust(color: UIColor(color), by: -1 * abs(percentage) ))
    }
  
    
    
    init(hex: UInt, alpha: Double = 1) {
           self.init(
               .sRGB,
               red: Double((hex >> 16) & 0xff) / 255,
               green: Double((hex >> 08) & 0xff) / 255,
               blue: Double((hex >> 00) & 0xff) / 255,
               opacity: alpha
           )
       }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
