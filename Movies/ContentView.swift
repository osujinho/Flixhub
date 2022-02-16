//
//  ContentView.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextFieldInput(target: $viewModel.title, label: "Title", placeHolder: "Enter movie title")
                    
                    HStack {
                        Spacer()
                        
                        NavigationLinkButton(
                            label: "Search",
                            bgColor: .green,
                            isDisabled: viewModel.title.isEmpty,
                            destination: AnyView(ResultView().task {
                                await viewModel.searchMovie(forSearch: true)
                            }))
                    }
                }
                .containerViewModifier(fontColor: .black, borderColor: .black)
                
                Spacer()
            }
            .navigationTitle("Movie Search")
            .environmentObject(viewModel)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
