//
//  ChromaticCircleHelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct ChromaticCircleHelpView: View {
    @EnvironmentObject var appModel: AppModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HelpHeader(text: Text(LocalizedStringKey("Chromatic-Circle")))
            
            ScrollView {
                ChromaticCircle(isSplashScreen: false,wheelType: .none,showSelection: true)
                    .padding()
                    .frame(height: 420)
                
                Text(LocalizedStringKey("Chromatic-Circle-Help-1"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.none)
        }
    }
}

struct ChromaticCircleHelpView_Previews: PreviewProvider {
    static var previews: some View {
        ChromaticCircleHelpView()
            .preferredColorScheme(.dark)
            .environmentObject(AppModel())
    }
}
