//
//  TabButtonView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import SwiftUI

struct TabButtonView : View {
    
    var tab : Tab
    @Binding var selectedTab : Tab
    var animation : Namespace.ID
    
    var body: some View{
        
        Button(action: {
            withAnimation{selectedTab = tab}
        }) {
            
            VStack(spacing: 6){
                
                ZStack{
                    
                    CustomShape()
                        .fill(Color.clear)
                        .frame(width: 45, height: 6)
                    
                    if selectedTab == tab{
                        
                        CustomShape()
                            .fill(.blue)
                            .frame(width: 45, height: 6)
                            .matchedGeometryEffect(id: "Tab_Change", in: animation)
                    }
                }
                .padding(.bottom,10)
                
                Image(systemName: tab.image)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == tab ? .blue : Color.black.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Text(tab.description)
                    .font(.caption)
                    .fontWeight(.bold)
                    //.foregroundColor(Color.black.opacity(selectedTab == tab ? 0.6 : 0.2))
                    .foregroundColor(selectedTab == tab ? .primary : .secondary)
            }
        }
    }
}
