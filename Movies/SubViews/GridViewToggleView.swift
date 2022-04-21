//
//  GridViewToggleView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/19/22.
//

import SwiftUI

struct GridViewToggle: View {
    @Binding var showGridView: Bool
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(action: {
                withAnimation {
                    showGridView.toggle()
                }
            }, label: {
                Image(systemName: showGridView ? "list.bullet.circle.fill" : "circle.grid.3x3.circle.fill")
                    .renderingMode(.template)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
            })
            .padding(.horizontal)
        }
        .background(Color("background"))
    }
}
