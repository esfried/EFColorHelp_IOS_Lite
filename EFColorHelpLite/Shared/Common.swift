//
//  Common.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 29/05/21.
//

import SwiftUI

struct HelpHeader: View {
    let text: Text
    let header_background = Color(UIColor(named: "header_background") ?? UIColor.white)
    let header_foreground = Color(UIColor(named: "header_foreground") ?? UIColor.white)
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextBlock(
                text.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/),
                backColor: header_background, foreColor: header_foreground, height: 45)
            //Image(systemName: "questionmark.circle")
              //  .foregroundColor(.white)
                //.padding()
            
        }
    }
}

struct Header: View {
    let text: Text
    let header_background = Color(UIColor(named: "header_background") ?? UIColor.white)
    let header_foreground = Color(UIColor(named: "header_foreground") ?? UIColor.white)
    
    var body: some View {
        TextBlock(text.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/),
                  backColor: header_background, foreColor: header_foreground, height: 45)
    }
}

struct SubHeader: View {
    let text: Text
    let header_background = Color(UIColor(named: "header_background") ?? UIColor.white)
    let header_foreground = Color(UIColor(named: "header_foreground") ?? UIColor.white)
    
    var body: some View {
        TextBlock(text.font(.title2),
                  backColor: header_background, foreColor: header_foreground, height: .infinity)
    }
}

struct HelpMenuLandscapeButton : View {
    @EnvironmentObject var appModel: AppModel
    
    let text: Text
    let helpIndex: HelpPageIndexEnum
    let image: Image?
    
    init(text: Text, helpIndex:HelpPageIndexEnum, image: Image? = nil) {
        self.text = text
        self.helpIndex = helpIndex
        self.image = image
    }
    
    
    var body: some View {
        Button {
            appModel.helpPageIndex = helpIndex
        } label: {
            text
        }
      }
}


struct HelpMenuButton : View {
    @EnvironmentObject var appModel: AppModel
    
    let text: Text
    let helpIndex: HelpPageIndexEnum
    let image: Image?
    
    init(text: Text, helpIndex:HelpPageIndexEnum, image: Image? = nil) {
        self.text = text
        self.helpIndex = helpIndex
        self.image = image
    }
    
    var body: some View {
        Button(action: {
            appModel.helpPageIndex = helpIndex
        })
        {
            HStack {
                if image != nil {
                    image
                }
                text
                    .fontWeight(.light)
            }
        }
        .buttonStyle(CustomButtonStyle())
        
    }
}

struct NameColorsView: View {
    @EnvironmentObject var appModel: AppModel
    
    let activeColor = Color(UIColor(named: "circle_color_name_active") ?? UIColor.white)
    let deactiveColor = Color(UIColor(named: "circle_color_name_deactive") ?? UIColor.white)
    
    var body: some View {
        GeometryReader { m in
            ZStack {
                ZStack {
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .yellow), angle: -16, color: deactiveColor)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .blue), angle: 103, color: deactiveColor)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .red), angle: 223, color: deactiveColor)
                    
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .green), angle: 44, color: deactiveColor)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .violet), angle: 170, color: deactiveColor)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .orange), angle: 280, color: deactiveColor)
                }
                
                ZStack {
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .green), angle: 15, color: activeColor)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .blue), angle: 72, color: .black)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .violet), angle: 133, color: activeColor)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .red), angle: 195, color: .black)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .orange), angle: 252, color: activeColor)
                    CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .yellow), angle: 310, color: activeColor)
                }
            }.scaleEffect(0.8)
            //.frame( width: m.size.width, height: m.size.height)
            
            ZStack {
                CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .yellow), angle: 15, color: activeColor)
                CircleTextView(text:  Repository.shared.getLocalizedColorName(color: .green), angle: 75, color: activeColor)
                CircleTextView(text: Repository.shared.getLocalizedColorName(color: .blue), angle: 132, color: activeColor)
                CircleTextView(text: Repository.shared.getLocalizedColorName(color: .violet), angle: 196, color: activeColor)
                CircleTextView(text: Repository.shared.getLocalizedColorName(color: .red), angle: 250, color: activeColor)
                CircleTextView(text: Repository.shared.getLocalizedColorName(color: .orange), angle: 310, color: activeColor)
            }.scaleEffect(0.9)
            //
        }
    }
}


struct TextBlock: View {
    let backColor:Color
    let foreColor:Color
    let height:CGFloat
    let text:Text
    
    init(_ text:Text, backColor:Color, foreColor: Color,height: CGFloat) {
        self.text = text
        self.backColor = backColor
        self.foreColor = foreColor
        self.height = height
    }
    
    var body: some View {
        VStack {
            text
                .padding(4)
                .foregroundColor(foreColor)
                .frame(maxWidth: .infinity,maxHeight: height)
                .background(backColor)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/.opacity(0.25), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        }
    }
}

struct UnsupportedOrientationView: View {
    var body: some View {
        Spacer()
        VStack() {
            Text(Image(systemName: "exclamationmark.triangle"))
                .font(.system(size: 30))
                .frame(height:50)
            Text(LocalizedStringKey("Sorry"))
                .font(.footnote)
                .frame(height:20)
            Text(LocalizedStringKey("Unsupported-Orientation"))
                .font(.footnote)
                .frame(height:30)
        }
        Spacer()
    }
}

