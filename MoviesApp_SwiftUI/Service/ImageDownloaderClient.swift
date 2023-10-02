//
//  ImageDownloaderClient.swift
//  MoviesApp_SwiftUI
//
//  Created by PINAR KALKAN on 29.09.2023.
//

import Foundation


//Poster görsellerini indir

class ImageDownloaderClient: ObservableObject {
    
    @Published var downloadedImage: Data?
    
    func downloadImage(url: String) {
        
        //Burası çalışıyorsa URLyi düzgün aldık demektir.
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        //Burası çalışıyorsa data geldi demektir. Buraya kadar zaten DOwnloaderClient ile aynı şeyi yaptık.
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            //bu aşamada gelen datayı bir değişkene ata. Ki sonrasında bu sınıfı çağırdığın yerde kullanabilmek için.
            DispatchQueue.main.async {
                self.downloadedImage = data
            }
     
        }.resume()
    }
}
