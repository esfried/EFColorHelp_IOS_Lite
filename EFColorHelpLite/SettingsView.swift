//
//  SettingsView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 04/05/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appModel: AppModel

    var body: some View {
         NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("Settings-Ton"))) {
                    Text(appModel.selectedWheelHue == WheelHueEnum.bright ? "Bright" : "DARK")

                    Picker(selection: $appModel.selectedWheelHue, label: Text(LocalizedStringKey("Settings-Ton")), content: {
                        Text(LocalizedStringKey("Bright")).tag(WheelHueEnum.bright)
                        Text(LocalizedStringKey("Dark")).tag(WheelHueEnum.dark)
                    })
                    
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        }
        .navigationBarTitle("Settings")
     }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppModel())
    }
}
