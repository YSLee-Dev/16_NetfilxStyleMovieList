//
//  DetailView.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/07/20.
//

import SwiftUI

struct DetailView: View {
    @State var item : Item?
    
    var body: some View {
        VStack{
            if let item = item{
                Image(uiImage: item.image)
                    .aspectRatio(contentMode: .fit)
                
                Text(item.description)
                    .font(.caption)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
            }else{
                Color.white
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
