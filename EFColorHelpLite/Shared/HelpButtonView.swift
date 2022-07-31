//
//  HelpButtonView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 04/05/21.
//

import SwiftUI

struct HelpButtonView: View {
    var body: some View {
        Button(action: { }) {
            Text("This is a custom button")
        }
        .buttonStyle(CustomButtonStyle())
    }
}

struct HelpButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HelpButtonView()
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        let background = Color(UIColor(named: "help_button_background") ?? UIColor.white)
        let foreground = Color(UIColor(named: "help_button_foregroumd") ?? UIColor.white)
  
        return configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .cornerRadius(5)
            .background(background)
            .foregroundColor(foreground)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
                .animation(.easeInOut(duration: 0.2))
    }
}
