//
//  ContentViewHeader.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/06/15.
//

import UIKit
import SnapKit

class ContentViewHeader : UICollectionReusableView {
    let sectionLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sectionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.sectionLabel.textColor = .white
        self.sectionLabel.sizeToFit()
        
        self.addSubview(self.sectionLabel)
        self.sectionLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
        }
    }
}
