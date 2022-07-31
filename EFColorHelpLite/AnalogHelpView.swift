//
//  AnalogHelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct AnalogHelpView: View {
    @EnvironmentObject var appModel: AppModel
   
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            let colors = Repository.shared.getAnalogColors(color: appModel.selectedColor)
            
            HelpHeader(text: Text(LocalizedStringKey("Analog")))
            
            ScrollView {
                ChromaticCircle(isSplashScreen: false,wheelType: .analog,showSelection: true)
                    .padding()
                    .frame(height: 400)
                   
                Text(LocalizedStringKey("Analog-Help"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
              }
            .font(.callout)
           }
    }
}

struct AnalogHelpView_Previews: PreviewProvider {
    static var previews: some View {
        AnalogHelpView()
            .environmentObject(AppModel())
    }
}
