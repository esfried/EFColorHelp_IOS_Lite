//
//  TriadicHelpView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct FullVersionHelpView: View {
    @EnvironmentObject var appModel: AppModel
    @State var orientation : UIDeviceOrientation
    init(orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.orientation = orientation
    }
    
    var body: some View {
        let complementaryColor = Repository.shared.getComplementaryColor(color: appModel.selectedColor)
        VStack(alignment: .leading, spacing: 10) {
            HelpHeader(text: Text(LocalizedStringKey("FullVersion")))
            
            ScrollView {
                Group {
                    Text(LocalizedStringKey("FullVersion_01"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    Text(LocalizedStringKey("FullVersion_02"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    ChromaticCircle(isSplashScreen: false,wheelType: .splitComplementary,showSelection: true, showPicker: false, showEFColorLite: false)
                        .padding()
                        .frame(height:400)
                    Divider()
                    Text(LocalizedStringKey("FullVersion_03"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    ChromaticCircle(isSplashScreen: false,wheelType: .doubleComplementary,showSelection: true, showPicker: false, showEFColorLite: false)
                        .padding()
                        .frame(height:400)
                    Divider()
                    Text(LocalizedStringKey("FullVersion_04"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    VStack(spacing:5) {
                        GradientBlocksView(color: appModel.selectedColor,
                                           title: Text(LocalizedStringKey("Selected-Color")))
                        .frame(height:50)
                        
                        GradientBlocksView(color: complementaryColor,
                                           title: Text(LocalizedStringKey("Complementary")))
                        
                        .frame(height:50)
                    }
                    .padding()
                    Divider()
                }
                
                Group {
                    Text(LocalizedStringKey("FullVersion_05"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    ColorDetailsView(orientation: self.orientation)
                        .frame(height:550)
                        .padding()
                    Divider()
                    Text(LocalizedStringKey("FullVersion_06"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    ColorDetailedView(index:5, showTitle:true, orientation: self.orientation)
                        .frame(height:550)
                        .padding()
                    Divider()
                    Text(LocalizedStringKey("FullVersion_07"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Divider()
                    Text(LocalizedStringKey("FullVersion_08"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Spacer(minLength: 40)
                }
            }
            .padding(2)
            .font(.callout)
        }
    }
}

struct FullVersionHelpView_Previews: PreviewProvider {
    static var previews: some View {
        FullVersionHelpView()
            .environmentObject(AppModel())
    }
}
