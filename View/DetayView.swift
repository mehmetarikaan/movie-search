//
//  DetayView.swift
//  MovieSearchSwiftUI
//
//  Created by Mehmet Arıkan on 29.06.2022.
//

import SwiftUI

struct DetayView: View {
    
    let imdbId : String
    
    @ObservedObject var filmDetayViewModel = FilmDetayViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            
            HStack{
                
                Spacer()
            OzelImage(url: filmDetayViewModel.filmDetayi?.poster ?? "")
                .frame(width: 90, height: 130, alignment: .topLeading)
                Spacer()
            }
            
            Text(filmDetayViewModel.filmDetayi?.title ?? "title göster")
                .font(.title)
                .padding()
                .foregroundColor(.blue)
            
            Text(filmDetayViewModel.filmDetayi?.plot ?? "Plot göster")
                .padding()
            
            Text(filmDetayViewModel.filmDetayi?.director ?? "yönetmen")
                .font(.title3)
                .padding()
            
            Text(filmDetayViewModel.filmDetayi?.awards ??  "Ödüller")
                .font(.title2)
                .padding()
            
            Text(filmDetayViewModel.filmDetayi?.year ?? "Yıllar")
                .padding()
                .font(.title2)
            
            
            
        }.onAppear {
            self.filmDetayViewModel.filmDetayiAl(imdbId: imdbId)
        }
    }
}

struct DetayView_Previews: PreviewProvider {
    static var previews: some View {
        DetayView(imdbId: "test")
    }
}
