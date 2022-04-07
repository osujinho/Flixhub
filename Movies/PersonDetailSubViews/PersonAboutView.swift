//
//  PersonAboutView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/27/22.
//

import SwiftUI

struct PersonAboutView: View {
    let detail: PersonDetail
    let taggedImages: [String?]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // For Birth year
            DetailLabelAndInfoView(label: "born", info: getDate(date: detail.birthday ,forYear: false))
            
            // For place of birth
            DetailLabelAndInfoView(label: "from", info: detail.birthPlace ?? "N/A")
            
            // For Deathday if available
            let deathdate = getDeathdate(date: detail.deathday)
            if deathdate.lowercased() != "alive" {
                DetailLabelAndInfoView(label: "died", info: deathdate)
            }
            
            // Biography view
            BiographyAndPlotView(
                biography: detail.biography,
                label: "biography")
            
            // Image scrollView
            PersonPosterScrollView(images: detail.images.profiles.map{ $0.path })
            
            PersonBackdropScrollView(images: taggedImages)
            
        } /// End of Mother VStack
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
}
