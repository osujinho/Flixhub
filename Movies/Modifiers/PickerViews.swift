//
//  PickerViews.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

typealias Pickable = CaseIterable & Identifiable & Hashable & CustomStringConvertible

struct EnumPickerView<Enum: Pickable, Label : View>: View {
    private let label: Label
    @Binding private var selection: Enum
    
    init(selection: Binding<Enum>, label: Label) {
        self._selection = selection
        self.label = label
    }
    
    var body: some View {
        HStack {
            Picker(selection: $selection, label: label) {
                ForEach(Array(Enum.allCases)) { value in
                    HStack {
                        Text(value.description).tag(value)
                    }
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
        .padding(.horizontal, 10)
    }
}

extension EnumPickerView where Label == Text {
    init(_ titleKey: LocalizedStringKey, selection: Binding<Enum>) {
        label = Text(titleKey)
        _selection = selection
    }

    init<S: StringProtocol>(_ title: S, selection: Binding<Enum>) {
        label = Text(title)
        _selection = selection
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemGreen
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue, .font: UIFont(name: "Sony Sketch EF", size: 13) as Any], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont(name: "Sony Sketch EF Bold", size: 15) as Any], for: .selected)
    }
}

struct CustomPickerView<Enum: Pickable>: View {
    @Binding private var selection: Enum
    
    init(selection: Binding<Enum>) {
        self._selection = selection
    }
    
    var body: some View {
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
                    .onTapGesture { self.selection = value }
            }
        }
        .background(Color("background"))
        .padding(.leading, 10)
    }
}
