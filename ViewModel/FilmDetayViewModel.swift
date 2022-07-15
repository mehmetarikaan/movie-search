//
//  FilmDetayViewModel.swift
//  MovieSearchSwiftUI
//
//  Created by Mehmet Arıkan on 28.06.2022.
//

import Foundation
import SwiftUI

class FilmDetayViewModel : ObservableObject {
    @Published var filmDetayi : FilmDetaylariViewModel?
    
    let downloaderClient = DownloaderClient()
    
    
    func filmDetayiAl(imdbId : String){
        downloaderClient.filmDetaylariniIndir(imdbId: imdbId) { (sonuc) in
            switch sonuc {
            case .failure(let hata):
                print(hata)
            case .success(let filmDetay):
                
                DispatchQueue.main.async {
                    self.filmDetayi = FilmDetaylariViewModel(detay: filmDetay)
                }
            }
        }
    }
}



struct FilmDetaylariViewModel {
    
    let detay : FilmDetay
    
    var title : String{
        detay.title
    }
    var poster : String{
        detay.poster
    }
    var year : String {
        detay.year
    }
    var imdbId : String {
        detay.imdbId
    }
    var director : String {
        detay.director
    }
    var awards : String {
        detay.awards
    }
    var plot : String {
        detay.plot
    }
}
