//
//  PickerViews.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

typealias Pickable = CaseIterable & Identifiable & Hashable & CustomStringConvertible

struct CustomPickerView<Enum: Pickable>: View {
    @Binding private var selection: Enum
    let backgroundColor: String
    
    init(selection: Binding<Enum>, backgroundColor: String) {
        self._selection = selection
        self.backgroundColor = backgroundColor
        
        UITableViewCell.appearance().backgroundColor = UIColor(named: backgroundColor)
        UITableView.appearance().backgroundColor = UIColor(named: backgroundColor)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 20) {
                ForEach(Array(Enum.allCases)) { value in
                    let width = value.description.widthOfString(usingFont: UIFont.systemFont(ofSize: 12))
                    Text(value.description).tag(value)
                        .font(.system(size: 12))
                    
                        .padding(.bottom, 10)
                        .foregroundColor(self.selection == value ? .blue.opacity(0.7) : .gray)
                        .overlay(
                            Rectangle()
                                .frame(width: 0.9 * width, height: 3)
                                .foregroundColor(self.selection == value ? .blue.opacity(0.7) : .clear),
                            alignment: .bottom
                        )
                        .onTapGesture {
                            self.selection = value
                        }
                        .animation(Animation.easeInOut(duration: 0.3), value: selection)
                }
            }
            .padding(.horizontal)
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color(backgroundColor))
    }
}

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
                    .foregroundColor(.primary) /// Fix after implementing Both dark and light mode
            })
        }
    }
}
