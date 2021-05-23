//
//  AnimeDetailView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-22.
//

import SwiftUI

struct AnimeDetailView: View {
    @EnvironmentObject var model: AnimeModel
    
    @State private var following = false
    
    var body: some View {
        if let anime = model.detailAnime {
            ZStack {
                BackgroundColour()
                    .ignoresSafeArea()
                
                let uiImage = UIImage(data: anime.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.maxX, height: UIScreen.main.bounds.maxY)
                    .opacity(0.3)
                    .blur(radius: 2)
                
                ScrollView {
                    VStack {
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text("This anime is rated #\(anime.rank) on MyAnimeList with \(anime.score, specifier: "%.2f") stars")
                            Text("It has \(anime.episodes) episodes starting")
                            Text("description: \(anime.synopsis)")
                        }
                        .padding(.top)
                        .font(.system(size: 20, weight: .medium))
                    }
                }
                .frame(width: UIScreen.main.bounds.maxX-40, height: UIScreen.main.bounds.maxY-200)
                .navigationTitle(anime.title)
                .navigationBarItems(trailing:
                    Button(action: {
                        following.toggle()
                    }) {
                        Image(systemName: following ? "heart.fill" : "heart")
                    }
                )
                
            }
        }
        else {
            ZStack {
                BackgroundColour()
                ProgressView()
            }
            .ignoresSafeArea()
        }
    }
}
//
//struct AnimeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeDetailView(anime: )
//    }
//}
