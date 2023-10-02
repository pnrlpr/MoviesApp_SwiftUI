//
//  ImageItself.swift
//  MoviesApp_SwiftUI
//
//  Created by PINAR KALKAN on 29.09.2023.
//


//Image üzerinde bir sürü işlem yapıldığı için ayrı bir viewda oluşturmak daha mantıklı.
import SwiftUI

struct ImageItself: View {
    
    let url: String
    @ObservedObject var imageDownloaderClient = ImageDownloaderClient()
    
    
    init(url: String) {
        self.url = url
        self.imageDownloaderClient.downloadImage(url: self.url)
    }
    
    var body: some View {
        if let data = self.imageDownloaderClient.downloadedImage {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        } else {
            return Image("progressBarPlaceholder")
                .resizable()
        }
    }
}

struct ImageItself_Previews: PreviewProvider {
    static var previews: some View {
        ImageItself(url: "https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg")
    }
}
