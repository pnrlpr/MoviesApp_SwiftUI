//
//  DetailView.swift
//  MoviesApp_SwiftUI
//
//  Created by PINAR KALKAN on 2.10.2023.
//

import SwiftUI

struct DetailView: View {
    
    let imdbId: String
    
    @ObservedObject var movieDetailViewModel = MovieDetailViewModel()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            
            HStack {
                Spacer()
                ImageItself(url: movieDetailViewModel.movieDetails?.poster ?? "")
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
                Spacer()
            }
            
            
            Text(movieDetailViewModel.movieDetails?.title ?? "Movie Name Will Show")
                .font(.title)
                .foregroundColor(.blue)
                .bold()
                .padding()
            Text("Year: \(movieDetailViewModel.movieDetails?.year ?? "")")
                .foregroundColor(.gray)
               
            Text("Director: \(movieDetailViewModel.movieDetails?.director ?? "")")
                .foregroundColor(.gray)
               
            Text("Writer/s: \(movieDetailViewModel.movieDetails?.writer ?? "")")
                .foregroundColor(.gray)
                
            Text("Awards: \(movieDetailViewModel.movieDetails?.awards ?? "")")
                .foregroundColor(.gray)
                
            
            
            Text(movieDetailViewModel.movieDetails?.plot ?? "Movie Plot Will Show")
                .foregroundColor(.gray)
                .padding()
            Spacer()
        }.onAppear(perform: {
            self.movieDetailViewModel.getMovieDetails(imdbId: imdbId)
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(imdbId: "test")
    }
}
