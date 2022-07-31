//
//  GradientBlocksView.swift
//  EFColorHelp
//
//  Created by Edson José Friedmann on 04/05/21.
//

import SwiftUI

struct GradientBlockView: View {
    @EnvironmentObject var appModel: AppModel
    
    var color:Color;
    var text:Text;
    var colorEnum:CircleColorEnum;
    
    var body: some View {
        GeometryReader { m in
            ZStack {
                color
                    .frame(width:m.size.width,height: m.size.height)
                text
                    .font(.caption)
                    .fontWeight(.none)
                    .foregroundColor(Repository.shared.getTextColor(color: colorEnum))
                    .frame(width:m.size.width,height: m.size.height)
                    .border(Color.black, width: 0.2)
            }
        }
    }
}

struct GradientBlocksView: View {
    var color:CircleColorEnum;
    var title:Text;
    let titlePosition:TitlePositionEnum
    
    init(color:CircleColorEnum, title: Text,titlePosition:TitlePositionEnum = .left) {
        self.color = color
        self.title = title
        self.titlePosition = titlePosition
    }
    
    var body: some View {
        if titlePosition == .top {
            GradientBlocksTitleTopView(color: color, title: title)
        } else {
            GradientBlocksTitleLeftView(color: color, title: title)
        }
    }
}

struct GradientBlocksTitleTopView: View {
    @EnvironmentObject var appModel: AppModel
    
    var color:CircleColorEnum;
    var title:Text;
    
    init(color:CircleColorEnum, title: Text) {
        self.color = color
        self.title = title
    }
    
    var body: some View {
        let theColor =  Repository.shared.getColorFromCircleColorEnum(color: color)
        
        let ringColors = Repository.shared.getRingColors(wheelHue:appModel.selectedWheelHue, from: theColor)
        
        let subTitle:Text = Text(LocalizedStringKey(Repository.shared.getColorName(color:color)))
        
        GeometryReader { m in
            VStack {
                VStack(spacing:0) {
                    if (appModel.selectedColor==color) {
                        /* title
                         .font(.headline)
                         .italic()
                         .fontWeight(.medium)*/
                        
                        subTitle
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .italic()
                    }
                    else {
                        /* title
                         .font(.headline)
                         .fontWeight(.thin)*/
                        
                        
                        subTitle
                            .font(.subheadline)
                            .fontWeight(.thin)
                        
                    }
                }
                
                GeometryReader { m1 in
                    let fraction:CGFloat = 1.0 / 8.0;
                    
                    HStack(spacing:0) {
                        ForEach(0..<8) {
                            let ringColor = Repository.shared.getRingShadowOrTintColor(appModel: appModel, ringColor: ringColors[$0])
                            
                            GradientBlockView(color: ringColor, text: Text(String($0+1)),colorEnum: color).frame(width: m1.size.width * fraction)
                             }
                    }
                }
                .brightness(appModel.brightness * 0.01)
                .saturation(appModel.saturation * 0.01)
                .frame(width: m.size.width, height: m.size.height)
                .onTapGesture {
                    appModel.isSliderVisible = false
                    appModel.selectedColorDetail = color
                    appModel.colorDetailsLevel = .list
                }
            }
        }
    }
}

struct GradientBlocksTitleLeftView: View {
    @EnvironmentObject var appModel: AppModel
    
    var color:CircleColorEnum;
    var title:Text;
    
    init(color:CircleColorEnum, title: Text) {
        self.color = color
        self.title = title
    }
    
    var body: some View {
         let theColor =  Repository.shared.getColorFromCircleColorEnum(color: color)
        
        let ringColors = Repository.shared.getRingColors(wheelHue:appModel.selectedWheelHue, from: theColor)
        
        let subTitle:Text = Text(LocalizedStringKey(Repository.shared.getColorName(color:color)))
        
        GeometryReader { m in
            HStack(spacing:0) {
                VStack(spacing:0) {
                    if (appModel.selectedColor==color) {
                        /* title
                         .font(.headline)
                         .italic()
                         .fontWeight(.medium)*/
                        
                        subTitle
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .italic()
                    }
                    else {
                        /* title
                         .font(.headline)
                         .fontWeight(.thin)*/
                        
                        
                        subTitle
                            .font(.subheadline)
                            .fontWeight(.thin)
                        
                    }
                }
                .frame(width: m.size.width * 0.50)
                
                GeometryReader { m1 in
                    let fraction:CGFloat = 1.0 / 8.0;
                    
                    HStack(spacing:0) {
                        ForEach(0..<8) {
                            let ringColor = Repository.shared.getRingShadowOrTintColor(appModel: appModel, ringColor: ringColors[$0])
  
                            GradientBlockView(color: ringColor, text: Text(String($0+1)),colorEnum: color).frame(width: m1.size.width * fraction)
                        }
                    }
                    .brightness(appModel.brightness * 0.01)
                    .saturation(appModel.saturation * 0.01)
                }
                .frame(width: m.size.width * 0.50, height: m.size.height*0.9)
                .onTapGesture {
                    appModel.isSliderVisible = false
                    appModel.selectedColorDetail = color
                    appModel.colorDetailsLevel = .list
                }
            }
        }
    }
}

struct GradientBlocksView_Previews: PreviewProvider {
    static var previews: some View {
        GradientBlocksView(color: .red,title:Text("Titulo"),titlePosition: .left)
            .environmentObject(AppModel())
            .frame(height:100)
        
        GradientBlocksView(color: .red,title:Text("Titulo"), titlePosition: .top)
            .environmentObject(AppModel())
            .frame(height:100)
    }
}
