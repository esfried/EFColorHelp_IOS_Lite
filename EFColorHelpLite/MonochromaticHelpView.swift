//
//  MonochromaticHelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct MonochromaticHelpView: View {
    @EnvironmentObject var appModel: AppModel
      var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HelpHeader(text: Text(LocalizedStringKey("Monochromatic")))
            
            ScrollView {
                ChromaticCircle(isSplashScreen: false,wheelType: .monochromatic,showSelection: true)
                    .padding()
                    .frame(height: 400)
         
                Text(LocalizedStringKey("Monochromatic-Help"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
               }
            .font(.callout)
        }
        .padding(0)
    }
}

struct MonochromaticHelpView_Previews: PreviewProvider {
    static var previews: some View {
        MonochromaticHelpView()
            .environmentObject(AppModel())
    }
}
