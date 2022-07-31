//
//  SplashView.swift
//  EFColorHelp
//
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    @State var rotation: Double = 0.1
    @State var scale: CGFloat = 0.1
    
    @StateObject var appModel = AppModel()
    var tabSelection: Binding = .constant(0)

    var body: some View {
            VStack {
                if self.isActive {
                    ContentView(tabSelection: 0, orientation: .portrait)
                        .environmentObject(appModel)
                } else {
                    ChromaticCircle(isSplashScreen: true,wheelType: .none,showSelection: false,selectAll: true, width: .infinity, height: .infinity)
                        .padding()
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                        .animation(
                            Animation.easeInOut(duration:1.5)
                        )
                        .onAppear {
                            self.scale = 1.0
                            self.rotation = 360
                        }
                    Spacer()
                    Divider()
                    Text("EFColorHelp - Lite")
                        .font(Font.headline)
                        .fontWeight(.thin)
                    Text("V1.0.0 - Edson F.")
                        .font(Font.headline)
                        .fontWeight(.thin)
                        .padding(.vertical, 1.0)
                }
            }
            .padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { // 2.5
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(AppModel())
    }
}
