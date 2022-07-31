//
//  HelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 16/05/21.
//

import SwiftUI

struct HelpView: View {
    @EnvironmentObject var appModel: AppModel
    var body: some View {
        VStack {
        
            switch appModel.helpPageIndex {
            case .menu:
                HelpMenuView()
            default:
                Spacer()
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
            .preferredColorScheme(.dark)
            .environmentObject(AppModel()) }
}
