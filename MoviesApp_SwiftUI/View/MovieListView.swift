//
//  ContentView.swift
//  MoviesApp_SwiftUI
//
//  Created by PINAR KALKAN on 26.09.2023.
//

import SwiftUI

struct MovieListView: View {
    
    //Burada, oluşturduğumuz MovieList View Model'ında tuttuğumuz verileri alacağız.
    
    //@Published yaptığımız değişkeni buradan @ObservedObject ile alabiliriz.
   @ObservedObject var movieListeViewModel: MovieListViewModel
    
    @State var searchingMovie = ""
    
    init() {
        self.movieListeViewModel = MovieListViewModel()
       
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
//Tek kelime bir film arattığımızda sonuç geliyor ama birden çok kelimeli olduğunda aralarda boşluk olduğundan sonuç çıkmıyor. Çünkü Bir url'ye istek attığımızda aradaki boşluklar sorun oluyor. Bunu url formatına çevirmek gerekir. Bunu trimmingCharacters(in: ) ile yapıyoruz.
                TextField("Search Movie", text: $searchingMovie, onCommit: {
                    self.movieListeViewModel.searchMovies(movieName: searchingMovie.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? searchingMovie)
                    //Boşlukları ve yeni satırları kaldır, yerine url formatında karakter ekle!!!
                    
                }).padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                List(movieListeViewModel.movies, id: \.imdbId){ movie in
                    
                    NavigationLink(destination: DetailView(imdbId: movie.imdbId), label: {
                        HStack {
                            ImageItself(url: movie.poster)
                                .frame(width: 90, height: 130)
                            
                            VStack (alignment: .leading){
                                Text(movie.title)
                                    .font(.title3)
                                    .foregroundColor(.blue)
                                Text(movie.year)
                                    .foregroundColor(.gray)
                            }
                        }
                    })
                }.navigationTitle(Text("Movie Book"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
