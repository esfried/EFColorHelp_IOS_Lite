//
//  MockView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 31/05/21.
//

import SwiftUI

struct BlockColors: View {
    let color:Color
    
    var body: some View {
        
        let step:Double = 1.0 / 8.0;
        VStack {
            HStack {
                color
                color.opacity(step*7)
                color.opacity(step*6)
                color.opacity(step*5)
                color.opacity(step*4)
                color.opacity(step*3)
                color.opacity(step*2)
                color.opacity(step*1)
            }.frame(height:25)
        }
    }
}

struct MockView: View {
    func mixColors(color1:Color,color2:Color) -> Color {
        let c1 = CIColor(color: UIColor(color1))
        let c2 = CIColor(color: UIColor(color2))
        
        let r = (c1.red * 0.5) + (c2.red * 0.5)
        let g = (c1.green * 0.5) + (c2.green * 0.5)
        let b = (c1.blue * 0.5) + (c2.blue * 0.5)
        let a = (c1.alpha * 0.5) + (c2.alpha * 0.5);
        
        //let ui = UIColor(red:r, green:g, blue: b, alpha: 1)
        let ui = UIColor(red:r, green:g, blue: b, alpha: a)
        let result = Color(ui)
        
        return result
    }
    
    var body: some View {
        /*let m_yellow = Color(.sRGB, red:255/255, green:255/255, blue: 0)
        let m_red = Color(.sRGB, red:255, green:0, blue: 0)
        let m_blue = Color(.sRGB, red:0, green:0, blue: 255)
        
        let m_green = Color(.sRGB, red:0, green:255/255, blue: 0)
        let m_violet = Color(.sRGB, red:128/255, green:0, blue: 128/255)
        let m_orange = Color(.sRGB, red:255/255, green:127/255, blue: 0)
        
        //let m_yellow_green = Color(.sRGB, red:154/255, green:205/255, blue: 50/255)
        let m_yellow_green = Color(.sRGB, red:128/255, green:255/255, blue: 0)
        let m_green_blue = Color(.sRGB, red:0, green:127/255, blue: 127/255)
        let m_blue_violet = Color(.sRGB, red:63/255, green:0/255, blue: 192/255)
        let m_violet_red = Color(.sRGB, red:192/255, green:0/255, blue: 64/255)
        let m_red_orange = Color(.sRGB, red:255/255, green:64/255, blue: 0/255)
        let m_orange_yellow = Color(.sRGB, red:255/255, green:190/255, blue: 0/255)
       */
        VStack {
            /*VStack {
                Group {
                    Text("Primarias")
                    BlockColors(color:m_yellow)
                    BlockColors(color:m_red)
                    BlockColors(color:m_blue)
                }
                
                Group {
                    Text("Secundarias")
                    BlockColors(color:m_green)
                    BlockColors(color:m_violet)
                    BlockColors(color:m_orange)
                }
                
                Group {
                    Text("Terciarias")
                    BlockColors(color:m_yellow_green)
                    BlockColors(color:m_green_blue)
                    BlockColors(color:m_blue_violet)
                    BlockColors(color:m_violet_red)
                    BlockColors(color:m_red_orange)
                    BlockColors(color:m_orange_yellow)
                }
            }*/
            ChromaticCircleSliders()
            
            //ChromaticCircle(isSplashScreen: false,wheelType: .analog,showSelection: true)
            Spacer()
            
        }
        //.background(Color(x))
    }
}

struct MockView_Previews: PreviewProvider {
    static var previews: some View {
        MockView()
            .frame( width: 400, height: 400)
            .environmentObject(AppModel())
        
        // .previewLayout(.fixed(width: 1024, height: 450)) // 768
    }
}
