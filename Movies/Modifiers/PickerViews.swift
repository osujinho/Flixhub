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
