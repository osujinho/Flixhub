//
//  Result.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .searchSuccessful(let data):
                List {
                    ForEach(data.results, id: \.self) { result in
                        NavigationLink(destination: DetailView().task {
                            await viewModel.searchMovie(forSearch: false, imdbID: result.imdbid)
                            viewModel.movieImdbID = result.imdbid
                        }) {
                            HStack {
                                // Potentially getting the image once in viewModel then passing it in.
                                AsyncImage(url: URL(string: result.poster)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding(5)
                                } placeholder: {
                                    placeholderImage()
                                }
                                Spacer()
                                
                                VStack {
                                    Text(result.title)
                                    Text(result.year)
                                    Text(result.type)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Search Result")
            case .loadingSearchResult:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .alert("Movie Search Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in
            Button("Retry") {
                Task {
                    await viewModel.searchMovie(forSearch: true)
                }
            }
        } message: { detail in
            if case let .failure(error) = detail {
                Text(error.localizedDescription)
            }
        }
    }
}
