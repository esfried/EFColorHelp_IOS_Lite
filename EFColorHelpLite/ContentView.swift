//
//  ContentView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 03/05/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appModel: AppModel
    @State var tabSelection:Int
    @State var orientation: UIDeviceOrientation
    
    init(tabSelection:Int,orientation:UIDeviceOrientation = UIDeviceOrientation.portrait){
        self.tabSelection = tabSelection
        self.orientation = orientation
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        HStack {
            TabView(selection: $tabSelection) {
                ColorWheelsView(orientation: self.orientation)
                    .padding(.vertical,8)
                /*ColorCombinationView(showTitle: true, tabSelection: $tabSelection, orientation: orientation)
                    .tabItem {
                        Image(systemName: "chart.bar.doc.horizontal")
                        Text(LocalizedStringKey("Color-Combination"))
                    }
                    .tag(1)*/
                
                HelpMenuView()
                    .tabItem {
                        Image(systemName: "questionmark.circle")
                        Text(LocalizedStringKey("Help"))
                    }
                    .tag(2)
                    .font(.headline)
            }
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}

/*
 .onTapGesture {
 appModel.helpPageIndex = .menu
 }
 
 */
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tabSelection: 0,orientation: .portrait)
            .preferredColorScheme(.light)
           .environmentObject(AppModel())
       /* Landscape {
            ContentView(tabSelection: 0,orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
        }
        
        Portrait {
            ContentView(tabSelection: 0,orientation: .portrait)
                .environmentObject(AppModel())
        }*/
    }
}
