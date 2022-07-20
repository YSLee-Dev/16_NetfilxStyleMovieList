//
//  ContentView.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/07/20.
//

import SwiftUI

struct ContentView: View {
    let titles = ["16_NetfilxStyleMovieList"]
    var body: some View {
        NavigationView{
            List(titles, id: \.self){
              let mainVC = HomeVCRepresentable()
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                NavigationLink($0, destination: mainVC)
            }
            .navigationTitle("SwiftUI to UIKit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
