//
//  NavigationBarModifier.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/5/22.
//

import SwiftUI

//struct NavigationBarModifier: ViewModifier {
//    var titleColor: UIColor?
//    var background: UIColor?
//
//    init(titleColor: UIColor?, background: UIColor?) {
//        self.background = background
//
//        let coloredAppearance = UINavigationBarAppearance()
//        coloredAppearance.configureWithDefaultBackground()
//        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
//        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
//
//        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().compactAppearance = coloredAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//    }
//
//    func body(content: Content) -> some View {
//        ZStack{
//            content
//            VStack {
//                GeometryReader { geometry in
//                    LinearGradient(gradient: Gradient(colors: [firstGradientColor, secondGradientColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                        .frame(height: geometry.safeAreaInsets.top)
//                        .edgesIgnoringSafeArea(.top)
//                    Spacer()
//                }
//            }
//        }
//    }
//}

//extension View {
//    func navigationBarModifier(titleColor: UIColor?, firstGradientColor: Color, secondGradientColor: Color) -> some View {
//        self.modifier(NavigationBarModifier(titleColor: titleColor, firstGradientColor: firstGradientColor, secondGradientColor: secondGradientColor))
//    }
//}
