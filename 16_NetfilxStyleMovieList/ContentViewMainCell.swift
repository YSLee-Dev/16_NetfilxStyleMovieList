//
//  ContentViewMainCell.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/06/21.
//

import UIKit
import SnapKit

class ContentViewMainCell : UICollectionViewCell{
    
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    let tvBtn = UIButton()
    let movieBtn = UIButton()
    let categoryBtn = UIButton()
    
    let imageView = UIImageView()
    let label = UILabel()
    let contentStackView = UIStackView()
    
    let plusBtn = UIButton()
    let playBtn = UIButton()
    let infoBtn = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [self.baseStackView, self.menuStackView].forEach{
            self.contentView.addSubview($0)
        }
        
        [self.imageView, self.contentStackView].forEach{
            self.baseStackView.addArrangedSubview($0)
        }
        
        // imgView
        self.imageView.contentMode = .scaleToFill
        self.imageView.snp.makeConstraints{
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.imageView.snp.width)
        }
        
        // label
        self.contentView.addSubview(self.label)
        self.label.font = UIFont.systemFont(ofSize: 13)
        self.label.textColor = .white
        self.label.sizeToFit()
        self.label.textAlignment = .center
        self.label.snp.makeConstraints{
            $0.bottom.equalTo(self.contentStackView.snp.top).offset(-30)
            $0.leading.trailing.equalToSuperview()
        }
        
        // contentStackView
        self.contentStackView.axis = .horizontal
        self.contentStackView.alignment = .center
        self.contentStackView.distribution = .fillEqually
        self.contentStackView.spacing = 20
        self.contentStackView.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        [self.plusBtn, self.infoBtn].forEach{
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpOutside)
        }
        
        self.plusBtn.setTitle("내가 찜한 콘텐츠", for: .normal)
        self.plusBtn.setImage(UIImage(named: "plue"), for: .normal)
        
        self.infoBtn.setTitle("정보", for: .normal)
        self.infoBtn.setImage(UIImage(named: "info.circle"), for: .normal)
        
        self.playBtn.setTitle("▶️ 재생", for: .normal)
        self.playBtn.setTitleColor(.black, for: .normal)
        self.playBtn.backgroundColor = .white
        self.playBtn.layer.cornerRadius = 4
        self.playBtn.snp.makeConstraints{
            $0.height.equalTo(30)
        }
        self.playBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpOutside)
        
        [self.infoBtn, self.playBtn, self.plusBtn].forEach{
            self.contentStackView.addArrangedSubview($0)
        }
        
        // baseStackView
        self.baseStackView.axis = .vertical
        self.baseStackView.alignment = .center
        self.baseStackView.distribution = .fillProportionally
        self.baseStackView.spacing = 5
        
        self.baseStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        // menuStackView
        self.menuStackView.axis = .horizontal
        self.menuStackView.alignment = .center
        self.menuStackView.distribution = .equalSpacing
        self.menuStackView.spacing = 20
        
        [self.tvBtn, self.movieBtn, self.categoryBtn].forEach{
            self.menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
            $0.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        }
        
        self.tvBtn.setTitle("TV 프로그램", for: .normal)
        self.movieBtn.setTitle("영화", for: .normal)
        self.categoryBtn.setTitle("카테고리 ⬇️", for: .normal)
        
        self.menuStackView.snp.makeConstraints{
            $0.top.equalTo(self.baseStackView)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
    @objc func btnClick(_ sender:UIButton){
        print(sender.title(for: .normal))
    }
}
