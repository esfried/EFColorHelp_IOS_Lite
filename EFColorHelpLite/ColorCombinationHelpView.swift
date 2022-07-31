//
//  ColorCombinationHelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct ColorCombinationHelpView: View {
    @EnvironmentObject var appModel: AppModel
    @State var tabSelection:Int
      
    init(tabSelection:Int = 1) {
        self.tabSelection = tabSelection
      }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HelpHeader(text: Text(LocalizedStringKey("Color-Combination")))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    Text(LocalizedStringKey("Color-Combination-Help-1"))
                    ColorCombinationView(showTitle: false, tabSelection: $tabSelection, orientation: .portrait)
                        .frame(minHeight: 980)
                    Spacer()
                    Text(LocalizedStringKey("Color-Combination-Help-2"))
                    Spacer(minLength: 30)
                }
            }
            .padding(2)
            .font(.callout)
        }
        .padding(0)
    }
}

struct ColorCombinationHelpView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCombinationHelpView()
            .environmentObject(AppModel())
    }
}
