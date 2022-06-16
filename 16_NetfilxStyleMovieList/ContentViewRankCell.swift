//
//  ContentViewRankCell.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/06/16.
//

import UIKit

class ContentViewRankCell : UICollectionViewCell {
    
    let imageView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    
    let rankLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = 5
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints{
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        self.rankLabel.sizeToFit()
        self.contentView.addSubview(self.rankLabel)
        self.rankLabel.snp.makeConstraints{
            $0.leading.bottom.equalToSuperview()
        }
    }
}
