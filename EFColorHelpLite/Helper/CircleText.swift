//
//  CircleText.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 28/05/21.
//
//


import SwiftUI


struct CircleTextView: View {
    @State var text: String
    @State var angle: Double
    @State var color:Color
    @State var offset: Double
    @State var padding: Int
    
    init(text:String, angle:Double,color: Color = Color.black.opacity(1.0), offset:Double = 0.0,padding:Int = 10) {
        self.angle = angle
        self.color = color
        self.offset = offset
        self.padding = padding
        
        let spaces = (padding - text.count) / 2
        if spaces>0 {
            let presux = "".padding(toLength: spaces, withPad: " ", startingAt: 0)
            self.text  = presux + text + presux
            
        }
        else {
            self.text = text
        }
    }
    
    func getArray() -> [Double] {
        var xangles:[Double] = []
        var incAngle:Double = self.angle
        
        for (_, char) in text.enumerated() {
            incAngle = incAngle + getPreIncreasingAngleFor(c: char)
            xangles.append(incAngle)
            incAngle = incAngle + getPostIncreasingAngleFor(c: char) + offset
        }
        return xangles
    }
    
    private var texts: [(offset: Int, element:Character)] {
        return Array(text.enumerated())
    }
    
    func getPreIncreasingAngleFor(c:Character) -> Double {
        return 3.0
        /* switch c {
         case "m": return 3.5
         case "d": return 2.5
         case "e": return 2.5
         case "f": return 3.5
         case "g": return 3.5
         case "i": return 3.5
         case "j": return 3
         case "J": return 3
         case "l": return 2.5
         case "N": return 5.2
         case "r": return 2.1
         default: return 3.2
         }*/
    }
    
    func getPostIncreasingAngleFor(c:Character) -> Double {
        switch c {
        case "A": return 1.0
        case "a": return -0.3
        case "e": return -0.5
        case "f": return 0.1
        case "I": return -0.3
        case "i": return -0.3
        case "j": return -0.2
        case "k": return -0.3
        case "l": return -0.5
        case "L": return 0
        case "m": return 1.0
        case "n": return -0.2
        case "o": return -0.2
        case "r": return 0
        case "s": return -0.3
        case "t": return 0
        case "N": return 1.5
        default: return 0.5
        }
    }
    
    var body: some View {
        let angles = self.getArray()
        
        GeometryReader { m in
            ZStack {
             ForEach(self.texts, id: \.self.offset) {
             (offset,element) in
             VStack {
             Text(String(element))
             .font(.system(size: 14))
             .foregroundColor(self.color)
             Spacer()
             }
             .rotationEffect(.degrees(angles[offset]))
             }
             .frame(width:m.size.width,height: m.size.height
             )
             }
        }
    }
}

struct CircleTextView_Previews: PreviewProvider {
    static var previews: some View {
        let str = "ABCDEFGHIJKLMNOPQRSTUVXYZabcdefggijklmnopqrstuvwxyz Amarelo Laranja"
        CircleTextView(text: str, angle: 20, color: Color.red)
            .frame(width: .infinity, height: 400)
    }
}

