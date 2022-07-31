//
//  TriadicHelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct TriadicHelpView: View {
    @EnvironmentObject var appModel: AppModel
      
    var body: some View {
        let colors = Repository.shared.getTriadicColors(color: appModel.selectedColor)
        VStack(alignment: .leading, spacing: 10) {
            HelpHeader(text: Text(LocalizedStringKey("Triadic")))
            
            ScrollView {
                ChromaticCircle(isSplashScreen: false,wheelType: .triadic,showSelection: true)
                    .padding()
                    .frame(height: 400)
                   
                Text(LocalizedStringKey("Triadic-Help"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
              .font(.callout)
         }
    }
}

struct TriadicHelpView_Previews: PreviewProvider {
    static var previews: some View {
        TriadicHelpView()
            .environmentObject(AppModel())
    }
}
