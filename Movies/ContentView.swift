//
//  ContentView.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
