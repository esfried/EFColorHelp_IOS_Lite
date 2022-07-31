//
//  RotinasAuxiliares.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 31/05/21.
//

import SwiftUI

#if DEBUG

struct Landscape<Content>: View where Content: View {
    let content: () -> Content
    let height = UIScreen.main.bounds.width //toggle width height
    let width = UIScreen.main.bounds.height
    var body: some View {
        content().previewLayout(PreviewLayout.fixed(width: width, height: height))
    }
}

struct Portrait<Content>: View where Content: View {
    let content: () -> Content
    let height = UIScreen.main.bounds.width //toggle width height
    let width = UIScreen.main.bounds.height
    var body: some View {
        content()
        
    }
}

struct LightAndDark<Content>: View where Content: View {
    let content: () -> Content
    var body: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            content().environment(\.colorScheme, colorScheme).previewDisplayName("\(colorScheme)")
        }
    }
}

#endif
// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}


struct ShareRotationated: Shape {
    let angle: Double
    
    func rotate(origin: CGPoint,point: CGPoint,degrees: Double) -> CGPoint {
        // translate point back to origin
        
        var x: CGFloat = point.x
        var y: CGFloat = point.y
        
        let cx: CGFloat = origin.x
        let cy: CGFloat = origin.y
        
        let ang = Angle(degrees: degrees)
        let angle = CGFloat(ang.radians)
        
        let s:CGFloat = sin(angle)
        let c:CGFloat = cos(angle)
        
        // translate point back to origin:
        x -= cx;
        y -= cy;
        
        // rotate point counter clockwise
        let xnew:CGFloat = x * c + -y * s
        let ynew:CGFloat = x * s + y * c
        
        // translate point back:
        x = xnew + cx
        y = ynew + cy
        
        let result = CGPoint(x: x, y: y)
        
        return result
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter:CGFloat = rect.width>rect.height ? rect.height : rect.width
        let radius = diameter / 2.0
        
        let size:CGFloat = 10.0
        
        let innerCx:CGFloat = rect.midX
        let innerCy:CGFloat = rect.midY
        
        let outterCx:CGFloat = rect.midX
        let outterCy:CGFloat = rect.midY-radius
        let center = CGPoint(x: innerCx, y: innerCy)
        
        let xp = CGPoint(x:outterCx,y:outterCy)
        
        let rotated :CGPoint = rotate(origin:center, point: xp, degrees:angle)
        let outterCx2:CGFloat = rotated.x
        let outterCy2:CGFloat = rotated.y
        
        return Path() {
            $0.addEllipse(in: CGRect(x: innerCx-5, y: innerCy-5, width: size, height: size))
            
            $0.addEllipse(in: CGRect(x: outterCx, y: outterCy, width: size, height: size))
            
            $0.addEllipse(in: CGRect(x: outterCx2, y: outterCy2, width: size, height: size))
            
            $0.move(to: center)
            $0.addLine(to: rotated)
            
            $0.move(to: CGPoint(x: 0, y: 0))
            $0.addLine(to: CGPoint(x: rect.maxX, y: 0))
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            $0.addLine(to: CGPoint(x: 0, y: rect.maxY))
            $0.addLine(to: CGPoint(x: 0, y: 0))
        }
    }
}



struct RotinasAuxiliares: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RotinasAuxiliares_Previews: PreviewProvider {
    static var previews: some View {
        RotinasAuxiliares()
    }
}
