//
//  ColorDetailedView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 14/05/21.
//

import SwiftUI

struct ColorDetailedGeneralView: View {
    @EnvironmentObject var appModel: AppModel
    @State var index: Int
    @State var showTitle: Bool
    @State var orientation : UIDeviceOrientation
  
    var foreColor = Color.black.opacity(0.75);
    let activeColor = Color(UIColor(named: "circle_color_name_active") ?? UIColor.white)
    
    init(index:Int,showTitle:Bool = true, orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.index = index
        self.showTitle = showTitle
        self.orientation = orientation
    }
    
    var body: some View {
        //let hex = UIColor(appModel.selectedColorDetailRawColor).toHexString()
        //  let hex = UIColor(Color(hex:"#FF10FF01")).toHex(alpha: true)
        
        GeometryReader { m in
            VStack() {
                if showTitle {
                    TextBlock(appModel.getSelectedWheelTypeNumText(),
                              backColor: Color.gray.opacity(0.5), foreColor: foreColor, height: 50)
                }
                
                GradientBlocksView(color: .yellow,
                                   title: Text(LocalizedStringKey("Selected-Color")))
                    .frame(height: m.size.height * 0.08)
     
                ZStack {
                    DetailBlockView(color: .yellow,index: self.index)
                    //DetailBlockView(color: Color(hex:"#7FFF0000"),index: self.index)
                    
                    ZStack {
                        Circle()
                            .fill(Color.white)
                        Circle()
                            .stroke(Color.gray.opacity(0.7), lineWidth: 1)
                        
                        Text(String(self.index))
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    .zIndex(1.0)
                    .frame(width: 50, height: 50, alignment: .center)
                    
                    /*   RoundedRectangle(cornerRadius: 25, style: .continuous)
                     .fill(Color.white)
                     .frame(width: 50, height: 50)
                     
                     Text(String(self.index))
                     .foregroundColor(activeColor)*/
                }
                //TextBlock(Text("Hex code: \(hex)"), backColor: //Color.gray.opacity(0.5), foreColor: foreColor, height: 40)
                /*Spacer()
                Button(action: {
                    appModel.colorDetailsLevel = .list
                })
                {
                    HStack {
                        Image(systemName: "arrow.backward.circle")
                        Text(LocalizedStringKey("Back"))
                    }
                }
                .buttonStyle(CustomButtonStyle())*/
            }
        }
    }
}

struct ColorDetailedView: View {
    @State var index: Int
    @State var showTitle: Bool
    @State var orientation : UIDeviceOrientation
     
    init(index:Int,showTitle:Bool = true, orientation:UIDeviceOrientation = UIDeviceOrientation.portrait) {
        self.index = index
        self.showTitle = showTitle
        self.orientation = orientation
    }
    
    var body: some View {
         GeometryReader { m in
            VStack(spacing:0) {
                Group {
                    switch orientation {
                    case    UIDeviceOrientation.unknown,
                            UIDeviceOrientation.landscapeLeft:
                            UnsupportedOrientationView()
                          default:
                        ColorDetailedGeneralView(index: index, showTitle: showTitle, orientation: orientation)
                      }
                }
                .onRotate { newOrientation in
                    orientation = newOrientation
                }
            }
            .frame(width:m.size.width,height:m.size.height)
        }
    }
}

struct ColorDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        /*Landscape {
            ColorDetailedView(index: 2,orientation: .landscapeRight)
                .environmentObject(AppModel())
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
        }
        
        Portrait {*/
            ColorDetailedView(index: 2,orientation: .portrait)
                .environmentObject(AppModel())
       // }
   }
}
