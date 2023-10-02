//
//  MovieViewModel.swift
//  MoviesApp_SwiftUI
//
//  Created by PINAR KALKAN on 29.09.2023.
//

import Foundation
import SwiftUI

//Öncelikle http isteği yaptığımız ve gelen cevabı işlediğimiz DownloaderClient'ı burada uygulayalım.

class MovieListViewModel: ObservableObject {
    
    // ÖNEMLİ NOT: Burada yaptığımız işlemler görünüm(View) tarafından nasıl bilinecek? Ve bir değişiklik olduğunda görünümde nasıl bildirilecek??
    // Bunun için MovieListViewModel sınıfını ObservableObject yapmak. Bununla beraber buradan yayın yapabilir hale geliyoruz. Ve sonra da movies'i @Published diyerek yayına sokuyoruz. Hangi değişken gözlemlenebilir olsun istiyorsak ona @Published ekliyoruz.
    
   @Published var movies = [MovieViewModel]()
    
    let downloaderClent = DownloaderClient()
    
    func searchMovies (movieName : String) {
        downloaderClent.downloadMovies(search: movieName) { (sonuc) in
            switch sonuc {
            case.failure(let hata):
                print(hata)
            case.success(let movieArray):
                //optionaldan çıkarmak için if let
                if let movieArray = movieArray {
                    
                    DispatchQueue.main.async {
                        self.movies = movieArray.map(MovieViewModel.init)
                    }
                   
                    
//İlk önce @Published var movies = [Movie]() şeklinde yazılıydı. Ama aşağıda yaptığımız gibi sadece kullanıcıya göstermek istediğimiz verileri alacağımız başka bir viewmodel oluşturduk. Bu nedenle @Published var movies = [MovieViewModel]() olarak değiştirdik. Ama böyle olunca hata veriyor. Bunun için bu satıra .map ekledik. Yani artık internetten indirdiğim filmleri, MovieViewModel'a dönüştürüyoruz. Bunu da DispatchQueue içinde yapmalısın.
                }
            }
        }
    }
}

//Model içerisinde aratılan filmlere ait isim, tip vb tüm veriyori yazdık (parse edilmesini sağlamak için). Ama uygulamada mesela tip'i kullanmayacağız. Onun için burada ayrı bir model oluşturup, sadece kullanıcıya göstermek istediğimiz değişkenleri kullanacağız.

struct MovieViewModel {
    
    let movie : Movie
    
    var title: String {
        movie.title
    }
    
    var poster: String {
        movie.poster
    }
    
    var year: String {
        movie.year
    }
    
    var imdbId:String {
        movie.imdbId
    }
}
