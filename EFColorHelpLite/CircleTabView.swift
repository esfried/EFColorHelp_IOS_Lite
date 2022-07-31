//
//  CircleTabView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 09/05/21.
//

import SwiftUI

struct CircleTabView: View {
    @State var selectedView:WheelTypeEnum;
    
    var w: CGFloat = 36
    var h: CGFloat = 36
    
    var body: some View {
        VStack {
            //  Text("Selection: \(selection)")
            TabView(selection: $selectedView) {
                MonoChromaticView()
                    .tabItem {
                        Text(LocalizedStringKey("Monochromatic"))
                    }.tag(WheelTypeEnum.monochromatic)
                AnalogView().tabItem {
                    Text(LocalizedStringKey("Analog"))
                }.tag(WheelTypeEnum.analog)
                ComplementaryView().tabItem {
                    Text(LocalizedStringKey("Complementary"))
                }.tag(WheelTypeEnum.complementary)
                TriadicView().tabItem {
                    Text(LocalizedStringKey("Triadic"))
                }.tag(WheelTypeEnum.triadic)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never
            ))
            
            HStack() {
                Image(selectedView == .monochromatic ? "mono-icon" : "mono-icon-bw")
                    .resizable()
                    .frame(width: self.w, height: self.h)
                    .onTapGesture {
                        selectedView = .monochromatic
                    }
                Image(selectedView == .analog ? "analog-icon" : "analog-icon-bw")
                    .resizable()
                    .frame(width: self.w, height: self.h)
                    .onTapGesture {
                        selectedView = .analog;
                    }
                Image(selectedView == .complementary ? "complement-icon" : "complement-icon-bw")
                    .resizable()
                    .frame(width: self.w, height: self.h)
                    .onTapGesture {
                        selectedView = .complementary
                    }
                 Image(selectedView == .triadic ? "triad-icon" : "triad-icon-bw")
                    .resizable()
                    .frame(width: self.w, height: self.h)
                    .onTapGesture {
                        selectedView = .triadic
                    }
            }
            .padding(.bottom)
        }
        .padding(0)
   }
}

struct CircleTabView_Previews: PreviewProvider {
    static var previews: some View {
        CircleTabView(selectedView: .monochromatic)
            .environmentObject(AppModel())
    }
}
