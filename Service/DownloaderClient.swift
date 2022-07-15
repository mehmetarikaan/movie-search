//
//  DownloaderClient.swift
//  MovieSearchSwiftUI
//
//  Created by Mehmet Arıkan on 27.06.2022.
//

import Foundation
import SwiftUI


class DownloaderClient {
    
    func filmleriIndir(search: String, completion: @escaping (Result<[Film]?, DownloadError>) -> Void) {
        
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=3915afbf") else {
            return completion(.failure(DownloadError.yanlisUrl)) // linki verdik ve linkle ilgili hata varsa yazdır dedik
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in // urleyi gönderdik ve 3 sonuç döndü bize
            guard let data = data, error == nil else { // error ve data boşsa napsın
                return completion(.failure(.verilGelmedi))
            }
            guard let filmCevabi = try? JSONDecoder().decode(gelenFilm.self, from: data) else { // değilse datayı gelenfilme atsın
                return completion(.failure(.veriIslenemedi)) // sıkıntı varsa yazdır
            }
            completion(.success(filmCevabi.filmler)) //blok başarılı dönerse filmlere filmcevabını at
        }.resume() // devam ettir, çalıştır
    }
    
    //Film detayını almak için oluşturduğumuz fonksiyon bu fonkisyon id'ye göre detay çekecek
    
    func filmDetaylariniIndir(imdbId : String, completion: @escaping(Result<FilmDetay, DownloadError>) -> Void){
    
    guard let url = URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=3915afbf") else {
        return completion(.failure(.yanlisUrl))
    }
    
    URLSession.shared.dataTask(with: url){ (data,response,error) in
        guard let data = data, error == nil else {
            return completion(.failure(.verilGelmedi))
        }
        guard let gelenFilmDetayi = try? JSONDecoder().decode(FilmDetay.self, from: data) else {
            return completion(.failure(.veriIslenemedi))
        }
        completion(.success(gelenFilmDetayi))
        }.resume()
    }
}



// Completion bizden 2 tane değer istediği için Result ekledik ve DownloadError adında bir enum oluşturup Error sınıfına bağımlı kıldık.

enum DownloadError: Error {
    case yanlisUrl
    case verilGelmedi
    case veriIslenemedi
}
