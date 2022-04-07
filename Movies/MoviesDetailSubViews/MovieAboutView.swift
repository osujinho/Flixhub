//
//  MovieAboutView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/29/22.
//

import SwiftUI

struct MovieAboutView: View {
    @State private var isExpanded: Bool = false
    let tmdbDetail: TMDBDetail
    let ombdDetail: OMDBDetail
    let spokenLanguages: String
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            
            BiographyAndPlotView(biography: tmdbDetail.plot, label: "synopsis")
            
            VStack(alignment: .leading, spacing: 20) {
                DetailLabelAndInfoView(label: "original title", info: tmdbDetail.originalTitle ?? "N/A")
                
                let genres = tmdbDetail.genres.compactMap { $0.name.capitalized }.joined(separator: ", ")
                DetailLabelAndInfoView(label: "genres", info: genres)
                
                DetailLabelAndInfoView(label: "original language", info: getLanguage(code: tmdbDetail.originalLanguage))
                
                DetailLabelAndInfoView(label: "spoken languages", info: spokenLanguages)
                
                CriticsRatingView(ratings: ombdDetail.ratings)
            }
            
            // Awards
            DetailLabelAndInfoView(label: "awards", info: ombdDetail.awards ?? "N/A")
            
            // For status and DVD
            VStack(alignment: .leading, spacing: 20) {
                DetailLabelAndInfoView(label: "status", info: tmdbDetail.status ?? "N/A")
                
                DetailLabelAndInfoView(label: "DVD Release", info: ombdDetail.dvd ?? "N/A")
            }
            
            // For the money
            VStack(alignment: .leading, spacing: 20) {
                DetailLabelAndInfoView(label: "budget", info: getMoney(amount: tmdbDetail.budget))
                
                DetailLabelAndInfoView(label: "box office", info: ombdDetail.boxOffice ?? "N/A")
                
                DetailLabelAndInfoView(label: "revenue", info: getMoney(amount: tmdbDetail.revenue))
            }
            
            // Production company and country
            VStack(alignment: .leading, spacing: 20) {
                CompanyAndCountry(label: "production companies", items: tmdbDetail.companies)
                CompanyAndCountry(label: "production countries", items: tmdbDetail.countries)
            }
            .padding(.bottom, 20)
        }
    }
}

