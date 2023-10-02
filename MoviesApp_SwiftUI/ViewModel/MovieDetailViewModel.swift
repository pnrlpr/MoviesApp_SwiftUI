//
//  MovieDetailViewModel.swift
//  MoviesApp_SwiftUI
//
//  Created by PINAR KALKAN on 29.09.2023.
//

import Foundation
import SwiftUI


class MovieDetailViewModel: ObservableObject {
    @Published var movieDetails: DetailsViewModel?
    
    let downloaderClient = DownloaderClient()
    
    func getMovieDetails (imdbId: String) {
        downloaderClient.movieDetailDownload(imdbId: imdbId) { (sonuc) in
            switch sonuc {
            case .failure(let hata):
                print(hata)
            case .success(let detail):
                self.movieDetails = DetailsViewModel(detay: detail)
            }
        }
    }
    
}

struct DetailsViewModel {
    
    let detay: MovieDetail
    
    var title: String {
        detay.title
    }
    
    var poster: String {
        detay.poster
    }
    
    var year: String {
        detay.year
    }
    
    var imdbId: String {
        detay.imdbId
    }
    
    var director:String {
        detay.director
    }
    
    var writer: String {
        detay.writer
    }
    
    var awards: String {
        detay.awards
    }
    
    var plot: String {
        detay.plot
    }
    
    
}
