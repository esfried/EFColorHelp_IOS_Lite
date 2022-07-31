//
//  ColorCombinationGradientView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 13/05/21.
//

import SwiftUI

struct BlockView: View {
    let color:Color
    
    init(color:Color) {
        self.color = color
    }
    
    var body: some View {
        Rectangle()
            .fill(color)
            .padding(0)
    }
}
struct ColorCombinationGradientView: View {
    @EnvironmentObject var appModel: AppModel
     let  color:Color
    
    init(color:Color) {
        self.color = color
    }
     
    var body: some View {
        let ringColors = Repository.shared.getRingColors(wheelHue:appModel.selectedWheelHue, from: color)
       
        HStack(spacing:0) {
            BlockView(color: ringColors[7])
            BlockView(color: ringColors[6])
            BlockView(color: ringColors[5])
            BlockView(color: ringColors[4])
            BlockView(color: ringColors[3])
            BlockView(color: ringColors[2])
            BlockView(color: ringColors[1])
            BlockView(color: ringColors[0])
        }
        .border(Color.gray.opacity(0.25), width: 1)
        .padding(2)
    }
}

struct ColorCombinationGradientView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCombinationGradientView(color: .red)
            .environmentObject(AppModel())
}
}
