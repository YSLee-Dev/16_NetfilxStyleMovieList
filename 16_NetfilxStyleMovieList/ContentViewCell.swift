//
//  ContentViewCell.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/06/15.
//

import UIKit
import SnapKit

class ContentViewCell : UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 5
        self.contentView.clipsToBounds = true
     
        self.imageView.contentMode = .scaleToFill
        
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
