//
//  DetailView.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .detailSuccessful(let movie):
                VStack {
                    // top part
                    VStack {
                        Text(movie.title.uppercased())
                        
                        HStack {
                            // Potentially getting the image once in viewModel then passing it in.
                            AsyncImage(url: URL(string: movie.poster)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(5)
                            } placeholder: {
                                placeholderImage()
                            }
                            
                            VStack {
                                HStack {
                                    Text("Directed by:")
                                    Text(movie.director)
                                }
                                
                                HStack {
                                    Text("Release Date:")
                                    Text(movie.released)
                                }
                                
                                HStack {
                                    Text("Rated:")
                                    Text(movie.rated)
                                }
                                HStack {
                                    Text("Run Time:")
                                    Text(movie.runtime)
                                }
                                
                                HStack {
                                    Text("Genre:")
                                    ForEach(movie.genre.components(separatedBy: ", "), id: \.self) { genre in
                                        Text(genre)
                                    }
                                }
                                
                                HStack {
                                    Text("Starring:")
                                    ForEach(movie.actors.components(separatedBy: ", "), id: \.self) { star in
                                        Text(star)
                                    }
                                }
                                
                                HStack {
                                    Text("IMDB Rating:")
                                    Text(movie.rating)
                                }
                            }
                        }
                    }
                    
                    // Bottom for plots
                    VStack {
                        Text("Plot")
                        
                        ScrollView {
                            VStack {
                                Text(movie.plot)
                                    .font(.body)
                                    .lineLimit(nil)
                                    .padding(.horizontal, 5)
                            }.frame(maxWidth: .infinity)
                        }
                    }
                }
            case .loadingMovieDetail:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .alert("Movie Detail Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in
            Button("Retry") {
                Task {
                    await viewModel.searchMovie(forSearch: false, imdbID: viewModel.movieImdbID)
                }
            }
        } message: { detail in
            if case let .failure(error) = detail {
                Text(error.localizedDescription)
            }
        }
    }
}
