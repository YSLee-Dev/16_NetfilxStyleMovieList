//
//  DetailView.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/07/20.
//

import SwiftUI

struct DetailView: View {
    var item : Item?
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack(alignment: .bottom){
                if let item = item{
                    Image(uiImage: item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                    
                    Text(item.description)
                        .font(.caption)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color.primary
                                        .colorInvert()
                                        .opacity(0.75))
                }else{
                    Color.white
                }
            }
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
