//
//  DownloaderClient.swift
//  MoviesApp_SwiftUI
//
//  Created by PINAR KALKAN on 26.09.2023.
//

//NOT: Bazı API'larda https desteklenmeyebilir. Böyle bir durumda info.plist'te yeni satır aç -> app transport security setting -> +'ya tıkla -> allow arbitrary loads -> YES

import Foundation


class DownloaderClient {
    
    
    //Downloader client oluşturma:
    
    //Kullanıcının neyi arayacağını gösteren func
    //escaping closure: async çalışan ama işlem yapmak için closure'ın işinin bitmesini bekler. Çünkü arama sonrası veriler alınınca bir işlem yapılacak.
    //bunun içerisinde bir result bekliyoruz. Ya success ya da failure veriyor. Ve <> içinde gelecek verinin tipini gösteriyoruz.
    //Eğer failure olursa ne yapacağını "DownloaderError" ile veriyoruz.
    func downloadMovies (search : String, completion : @escaping (Result<[Movie]?, DownloaderError>) -> Void) {
        
        //Kullanıcıdan aldığımız search girdisiyle url'yi oluşturuyoruz. Eğer ki url'de hata varsa bunu ele alabilelim diye gurad let ile yapıyoruz (Api değişebilir, linkte hata olabilir, api key değişebilir bv gibi)
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=1f1a0a52")
        else {
            return completion(.failure(.wrongUrl))
        }
        
        //url oluşturduktan sonra, URLSession ile verileri çekiyoruz.
        //hep completion döndüreceğimiz için guard let ile yapıyoruz. direk return kullanmak yetiyor.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.dataNotGet))
            }
            
            //Gelen JSON verisini decode ediyoruz.
            guard let movieResponse = try? JSONDecoder().decode(MovieList.self, from: data) else {
                return completion(.failure(.dataNotProcessed))
            }
            
            //Yukarıdaki senaryoların hepsi ok ise, completion success dönecek. (Film dizisi dönüyor)
            completion(.success(movieResponse.movies))
            
            //.resume() demezsen bu işlemler hiç yapılmaz.
        }.resume()
    }
    
    //Film dizisi indiren olarak var ama tek bir filmi indiren yok. Bunu da yine burada func olarak yazabiliriz.
    
    func movieDetailDownload (imdbId : String, completion: @escaping (Result<MovieDetail, DownloaderError>) -> Void) {
        
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=1f1a0a52")
        else {
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.dataNotGet))
            }
            
            
            //Gelen JSON verisini decode ediyoruz.
            guard let movieDetailResponse = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
                return completion(.failure(.dataNotProcessed))
            }
            
            completion(.success(movieDetailResponse))
        }.resume()
        
    }
    
    
    enum DownloaderError : Error {
        case wrongUrl
        case dataNotGet
        case dataNotProcessed
    }
}
