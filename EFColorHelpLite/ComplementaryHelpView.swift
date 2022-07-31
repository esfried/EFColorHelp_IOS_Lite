//
//  ComplementaryHelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct ComplementaryHelpView: View {
    @EnvironmentObject var appModel: AppModel
   
    var body: some View {
        let complementaryColor = Repository.shared.getComplementaryColor(color: appModel.selectedColor)
        
        VStack(alignment: .leading, spacing: 10) {
            HelpHeader(text: Text(LocalizedStringKey("Complementary")))
            
            ScrollView {
                ChromaticCircle(isSplashScreen: false,wheelType: .complementary,showSelection: true)
                    .padding()
                    .frame(height: 400)
       
                Text(LocalizedStringKey("Complementary-Help"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
               }
             .font(.callout)
          }
    }
}

struct ComplementaryHelpView_Previews: PreviewProvider {
    static var previews: some View {
        ComplementaryHelpView()
            .environmentObject(AppModel())
    }
}
