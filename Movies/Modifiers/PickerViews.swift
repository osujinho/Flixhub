//
//  PickerViews.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct CustomPickerView<Enum: Pickable>: View {
    @Binding private var selection: Enum
    let backgroundColor: String
    @Namespace private var animation
    
    init(selection: Binding<Enum>, backgroundColor: String) {
        self._selection = selection
        self.backgroundColor = backgroundColor
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
                            ZStack {
                                CustomShape()
                                    .fill(Color.clear)
                                    .frame(width: 0.9 * width, height: 3)
                                
                                if selection == value{
                                    
                                    CustomShape()
                                        .fill(.blue.opacity(0.7))
                                        .frame(width: 0.9 * width, height: 3)
                                        .matchedGeometryEffect(id: "Tab_Change", in: animation)
                                }
                            }
                            
                            ,alignment: .bottom
                        )
                        .onTapGesture {
                            withAnimation {
                                self.selection = value
                            }
                        }
                }
            }
            .padding(.horizontal)
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color(backgroundColor))
    }
}


