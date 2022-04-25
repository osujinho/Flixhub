//
//  ContentView.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
