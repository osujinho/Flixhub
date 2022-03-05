//
//  CustomViews.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

// Container label Texts
struct HeadlineLabel: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.headline)
            .fontWeight(.semibold)
    }
}

// TextField used in search view
struct TextFieldInput: View {
    @Binding var target: String
    let label: String
    let placeHolder: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            HeadlineLabel(label: label)
            ZStack(alignment: .trailing) {
                TextField(placeHolder, text: $target)
                    .foregroundColor(.black)
                    .font(.footnote)
                    .frame(height: 25)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.horizontal, 8)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    .background(Color.white.cornerRadius(10))
                    .padding(.horizontal, 5)
                if !target.isEmpty {
                    Button(action: {
                        target = ""
                    }, label: {
                        Image(systemName: "clear")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }).padding(.horizontal, 8)
                }
            }
        }
        
    }
}

// Submit button
struct LabelButton: View {
    let label: String
    let bgColor: Color
    let action: () -> Void
    let isDisabled: Bool
    
    init(label: String, bgColor: Color, action: @escaping () -> Void, isDisabled: Bool = false) {
        self.label = label
        self.bgColor = bgColor
        self.action = action
        self.isDisabled = isDisabled
    }
    
    var body: some View {
        Button(label, action: action)
            .foregroundColor(.white)
            .padding(10)
            .padding(.horizontal, 20)
            .background(bgColor)
            .clipShape(Capsule())
            .opacity(isDisabled ? 0.6 : 1.0)
            .disabled(isDisabled)
    }
}

/// To round only certain corners
struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
