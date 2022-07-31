//
//  ChromaticCircle.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 07/05/21.
//

import SwiftUI

struct OutsideRingSlice: View {
    @EnvironmentObject var appModel: AppModel
    
    private let start:CGFloat
    private let end:CGFloat
    private let strokeWidth: CGFloat
    private let color:CircleColorEnum;
    
    init(index: Int, color: CircleColorEnum,strokeWidth: CGFloat) {
        self.start = CGFloat(index) / 12.0
        self.end = CGFloat(index+1) / 12.0
        self.strokeWidth = strokeWidth
        self.color = color
    }
    
    var body: some View {
        let rawColor:Color = Repository.shared.getColorFromCircleColorEnum(color: self.color)
        
        ZStack(alignment: .center) {
             Circle()
                .trim(from: start, to: end)
                .stroke(style: StrokeStyle(lineWidth: self.strokeWidth, lineCap: .butt, lineJoin: .miter))
                .foregroundColor(rawColor)
         }
        .padding()
    }
}

struct OutsideRingView: View {
    @EnvironmentObject var appModel: AppModel
    
    let colors: [CircleColorEnum]
    
    init() {
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
        ZStack {
            Group {
                OutsideRingSlice(index: 0, color: colors[0], strokeWidth: 20.0)
                OutsideRingSlice(index: 1, color: colors[1], strokeWidth: 20.0)
                OutsideRingSlice(index: 2, color: colors[2], strokeWidth: 20.0)
                OutsideRingSlice(index: 3, color: colors[3], strokeWidth: 20.0)
                OutsideRingSlice(index: 4, color: colors[4], strokeWidth: 20.0)
                OutsideRingSlice(index: 5, color: colors[5], strokeWidth: 20.0)
                OutsideRingSlice(index: 6, color: colors[6], strokeWidth: 20.0)
            }
            Group {
                OutsideRingSlice(index: 7, color: colors[7], strokeWidth: 20.0)
                OutsideRingSlice(index: 8, color: colors[8], strokeWidth: 20.0)
                OutsideRingSlice(index: 9, color: colors[9], strokeWidth: 20.0)
                OutsideRingSlice(index: 10, color: colors[10], strokeWidth: 20.0)
                OutsideRingSlice(index: 11, color: colors[11], strokeWidth: 20.0)
            }
        }
        
    }
}

struct OutsideRingView_Previews: PreviewProvider {
    static var previews: some View {
        OutsideRingView()
            .frame( width: .infinity, height: .infinity)
            //  .border(Color.red, width: 3)
            .environmentObject(AppModel())
    }
}
