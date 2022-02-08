//
//  ViewComposition.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

// placeholder
@ViewBuilder
func placeholderImage() -> some View {
    Image(systemName: "photo")
        .renderingMode(.template)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 150, height: 150)
        .foregroundColor(.gray)
}

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

struct NavigationLinkButton: View {
    let label: String
    let bgColor: Color
    let isDisabled: Bool
    let destination: AnyView
    
    init(label: String, bgColor: Color, isDisabled: Bool = false, destination: AnyView) {
        self.label = label
        self.bgColor = bgColor
        self.isDisabled = isDisabled
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .foregroundColor(.white)
                .padding(10)
                .padding(.horizontal, 20)
                .background(bgColor)
                .clipShape(Capsule())
                .opacity(isDisabled ? 0.6 : 1.0)
        }
        .disabled(isDisabled)
    }
}

// Modifier for containers
struct ContainerViewModifier: ViewModifier {
    let fontColor: Color
    let borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(fontColor)
            .font(.system(size: 14))
            .padding(10)
            .background(Color.black.opacity(0.5).cornerRadius(10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke((borderColor), lineWidth: 2)
            )
            .padding(.horizontal, 15)
    }
}

extension View {
    func containerViewModifier(fontColor: Color, borderColor: Color) -> some View {
        self.modifier(ContainerViewModifier(fontColor: fontColor, borderColor: borderColor))
    }
}
