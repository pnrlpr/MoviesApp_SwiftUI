//
//  Movie.swift
//  MoviesApp_SwiftUI
//
//  Created by PINAR KALKAN on 26.09.2023.
//

import Foundation


//Codeabla, hem decodeable hem encodeable olarak çalışır. Yani gelen veriyi işleyip dğeişkenlere atamamıza olanak sağlar.

struct Movie : Codable {
    
    let title : String
    let year : String
    let imdbId : String
    let type : String
    let poster : String
    
    //Veritabanından gelen veriler bütük harfle başlıyor. (Title, Year vb.) Bunları değişkenlere atarken küçük harfle başlıyoruz. Bunların birbirine karşılık geldiğini belirtmek için aşağıdaki enum'ı oluşturmalısın.
    //Böylelikle CodingKey olarak bizim yazdığımız değişkenlerle, vt'den gelen stringleri eşleştiriyoruz.
    
    //Alternatif olarak, bunu yapan site : json4swift
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
}


struct MovieList : Codable {
    
    let movies : [Movie]
    
    private enum CodingKeys : String, CodingKey {
        //Arama yapıp filmleri çektiğimiz zaman "Search" isimli bir liste ile geliyor.
        case movies = "Search"
    }
}
