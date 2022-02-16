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
            switch viewModel.viewState {
            case .searchSuccessful(let data):
                List {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    
                    ForEach(data.results, id: \.self) { result in
                        NavigationLink(destination: DetailView().task { await viewModel.searchMovie(forSearch: false, imdbID: result.imdbid) }) {
                            HStack(spacing: 20) {
                                // Potentially getting the image once in viewModel then passing it in.
                                AsyncImage(url: URL(string: result.poster)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 100, maxHeight: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding(5)
                                } placeholder: {
                                    placeholderImage()
                                }
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(result.title.capitalized)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text(result.type)
                                        .font(.headline)
                                    Text(result.year)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Search Result")
            case .loadingSearchResult:
                ProgressView()
            case .detailSuccessful(_):
                DetailView()
            default:
                EmptyView()
            }
        }
        .alert("Movie Search Error", isPresented: $viewModel.hasError, presenting: viewModel.viewState) { detail in
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


