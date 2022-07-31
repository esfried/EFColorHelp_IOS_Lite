//
//  DrawHelper.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 15/05/21.
//

import Foundation
import SwiftUI

extension CGPoint {
    func rotate(around center: CGPoint, with degrees: CGFloat) -> CGPoint {
        let dx = self.x - center.x
        let dy = self.y - center.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + degrees * CGFloat(Double.pi / 180.0) // convert it to radians
        let x = center.x + radius * cos(newAzimuth)
        let y = center.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
}

extension CGRect {
    func center() -> CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    func topCenter() -> CGPoint {
        return CGPoint(x: self.midX, y: self.minY)
    }
}


class DrawHelper {
    private var hexagonPointA : CGPoint
    private var hexagonPointB : CGPoint
    private var hexagonPointC : CGPoint
    private var hexagonPointD : CGPoint
    private var hexagonPointE : CGPoint
    private var hexagonPointF : CGPoint
    private var pointG : CGPoint
    private var pointGD : CGPoint
    private var pointGB : CGPoint
    private var pointGF : CGPoint
    
    init() {
        self.hexagonPointA = CGPoint(x:0,y:0)
        self.hexagonPointB = CGPoint(x:0,y:0)
        self.hexagonPointC = CGPoint(x:0,y:0)
        self.hexagonPointD = CGPoint(x:0,y:0)
        self.hexagonPointE = CGPoint(x:0,y:0)
        self.hexagonPointF = CGPoint(x:0,y:0)
        self.pointG = CGPoint(x:0,y:0)
        self.pointGD = CGPoint(x:0,y:0)
        self.pointGB = CGPoint(x:0,y:0)
        self.pointGF = CGPoint(x:0,y:0)
    }
    
    func calculateMiddlePoint(p1:CGPoint, p2:CGPoint) -> CGPoint {
        let result = CGPoint(x:(p1.x + p2.x) / 2, y:(p1.y + p2.y) / 2);
        return result;
    }
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    func rotatePoint(cx: CGFloat,cy: CGFloat, degrees: CGFloat, p: CGPoint) -> CGPoint {
        var x = p.x;
        var y = p.y;
        
        let angle = deg2rad(degrees);
        
        let s = sin(angle);
        let c = cos(angle);
        
        // translate point back to origin:
        x -= cx;
        y -= cy;
        
        // rotate point counter clockwise
        let xnew = x * c + -y * s;
        let ynew = x * s + y * c;
        
        // translate point back:
        x = xnew + cx;
        y = ynew + cy;
        
        return CGPoint(x: x, y:y);
    }
    
    func rotateOffset(cx:CGFloat, cy:CGFloat, degrees: CGFloat, p: CGPoint) -> CGPoint{
        let p2 = rotatePoint(cx:cx, cy:cy, degrees:degrees,  p:p)
        return CGPoint(x:p2.x,y: p2.y);
    }
    
    
    func topCenter(from: CGRect) -> CGPoint {
        return CGPoint(x: from.midX, y: from.minY)
    }
    
    func mountPointsForHexagon(rect: CGRect) {
        hexagonPointA =  topCenter(from: rect);
        hexagonPointB =  CGPoint(x: rect.midX, y: rect.minY);
        hexagonPointB = rotateOffset(cx: rect.center().x, cy: rect.center().y, degrees: 60, p: rect.topCenter());
        hexagonPointC = rotateOffset(cx: rect.center().x, cy: rect.center().y, degrees: 120, p: rect.topCenter());
        hexagonPointD = rotateOffset(cx: rect.center().x, cy: rect.center().y, degrees: 180, p: rect.topCenter());
        hexagonPointE = rotateOffset(cx: rect.center().x, cy: rect.center().y, degrees: 240, p: rect.topCenter());
        hexagonPointF = rotateOffset(cx: rect.center().x, cy: rect.center().y, degrees: 300, p: rect.topCenter());
        pointG = calculateMiddlePoint(p1:hexagonPointA, p2:hexagonPointD);
        pointGD = calculateMiddlePoint(p1:pointG, p2:hexagonPointD);
        pointGB = calculateMiddlePoint(p1:pointG, p2:hexagonPointB);
        pointGF = calculateMiddlePoint(p1:pointG, p2:hexagonPointF);
    }
    
    func primaryColorYellowPath(rect: CGRect) -> Path {
        var path = Path()
        
        mountPointsForHexagon(rect: rect)
        
        path.move(to: pointG);
        path.addLine(to: pointGF)
        path.addLine(to: hexagonPointA)
        path.addLine(to: pointGB)
        
        return path;
    }
    
    func primaryColorBluePath(rect: CGRect) -> Path {
        var path = Path()
        
        mountPointsForHexagon(rect: rect)
     
        path.move(to: pointG);
        path.addLine(to: pointGD)
        path.addLine(to: hexagonPointC)
        path.addLine(to: pointGB)
        
        return path;
    }
    
    func primaryColorRedPath(rect: CGRect) -> Path {
        var path = Path()
        
        mountPointsForHexagon(rect: rect)

        path.move(to: pointG);
        path.addLine(to: pointGD)
        path.addLine(to: hexagonPointE)
        path.addLine(to: pointGF)
        
        return path;
    }
    
    func secondaryColorGreenPath(rect: CGRect) -> Path {
        var path = Path()
        
        mountPointsForHexagon(rect: rect)

        path.move(to: hexagonPointA);
        path.addLine(to: hexagonPointB)
        path.addLine(to: hexagonPointC)
   
        return path;
    }
   
    func secondaryColorVioletPath(rect: CGRect) -> Path {
        var path = Path()
        
        mountPointsForHexagon(rect: rect)

        path.move(to: hexagonPointC);
        path.addLine(to: hexagonPointD)
        path.addLine(to: hexagonPointE)
   
        return path;
    }
    
    func secondaryColorOrangePath(rect: CGRect) -> Path {
        var path = Path()
        
        mountPointsForHexagon(rect: rect)

        path.move(to: hexagonPointA);
        path.addLine(to: hexagonPointE)
        path.addLine(to: hexagonPointF)
   
        return path;
    }
    
    func tertiaryColorYellowGreenPath(rect: CGRect) -> Path {
        var path = Path()
        
        mountPointsForHexagon(rect: rect)

        path.move(to: hexagonPointA);
        path.addLine(to: hexagonPointE)
        path.addLine(to: hexagonPointF)
   
        return path;
    }

}
