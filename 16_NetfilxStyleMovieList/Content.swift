//
//  Content.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/06/14.
//

import UIKit

struct Content : Decodable{
    let sectionType : SectionType
    let sectionName : String
    let contentItem : [Item]
    
    enum SectionType : String, Decodable{
        case basic
        case main
        case large
        case rank
    }
}

struct Item : Decodable{
    let description : String
    let imageName : String
    
    var image : UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}