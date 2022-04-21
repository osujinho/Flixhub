//
//  ShowAboutView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/1/22.
//

import SwiftUI

struct ShowAboutView: View {
    @State private var isExpanded: Bool = false
    let detail: ShowDetail
    let runtime: String
    let spokenLanguage: String
    let inProduction: String
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            BiographyAndPlotView(biography: detail.synopsis, label: "Synopsis")
            
            // top parts
            VStack(alignment: .leading, spacing: 20) {
                DetailLabelAndInfoView(label: "original name", info: detail.originalName)
                
                DetailLabelAndInfoView(label: "type", info: detail.type ?? "N/A")
                
                let genres = detail.genres.compactMap { $0.name.capitalized }.joined(separator: ", ")
                DetailLabelAndInfoView(label: "genres", info: genres)
                
                DetailLabelAndInfoView(label: "runtime", info: runtime)
                
                DetailLabelAndInfoView(label: "original language", info: getLanguage(code: detail.originalLanguage))
                
                DetailLabelAndInfoView(label: "spoken languages", info: spokenLanguage)
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 20) {
                DetailLabelAndInfoView(label: "first air date", info: getDate(date: detail.firstAirDate, forYear: false))
                
                DetailLabelAndInfoView(label: "number of seasons", info: String(detail.totalSeasons ?? 0))
                
                DetailLabelAndInfoView(label: "number of episodes", info: String(detail.totalEpisodes ?? 0))
                
                if let lastEpisode = detail.lastEpisode {
                    AirEpisode(episode: lastEpisode, label: "Last Episode")
                }
                
                DetailLabelAndInfoView(label: "last air date", info: getDate(date: detail.lastAirDate, forYear: false))
                
                if let nextEpisode = detail.nextEpisode {
                    AirEpisode(episode: nextEpisode, label: "Next Episode")
                }
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 20) {
                DetailLabelAndInfoView(label: "in production", info: inProduction)
                
                CompanyAndCountry(label: "production companies", items: detail.companies)
                
                CompanyAndCountry(label: "production countries", items: detail.countries)
                
                CompanyAndCountry(label: "networks", items: detail.networks)
            }
            .padding(.bottom, 20)
        }
    }
}
