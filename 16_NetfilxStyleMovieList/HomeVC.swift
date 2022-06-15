//
//  HomeVC.swift
//  16_NetfilxStyleMovieList
//
//  Created by 이윤수 on 2022/06/14.
//

import UIKit
import SwiftUI

class HomeVC : UICollectionViewController{
    
    var contents : [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 설정
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.hidesBarsOnSwipe = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "netflix_icon"), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        // 데이터 가져오기
        self.contents = self.getContents()
        print(contents)
        
        // CollectionView Item(Cell) 설정
        self.collectionView.register(ContentViewCell.self, forCellWithReuseIdentifier: "ContentViewCell")
        self.collectionView.register(ContentViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentViewHeader")
    }
    
    func getContents() -> [Content]{
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
                let data = FileManager.default.contents(atPath: path),
                let list = try? PropertyListDecoder().decode([Content].self, from: data) else {return []}
        return list
    }
}

// UICollectionViewController Delegate, DataSource
extension HomeVC{
    // 섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default :
            return contents[section].contentItem.count
        }
    }
    
    // 콜렉션 뷰 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentViewCell", for: indexPath) as? ContentViewCell else { return UICollectionViewCell() }
            cell.imageView.image = self.contents[indexPath.section].contentItem[indexPath.row].image
            return cell
            
        default : return UICollectionViewCell()
        }
    }
    
    // 헤더 뷰 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentViewHeader", for: indexPath) as? ContentViewHeader else { return UICollectionReusableView() }
            headerView.sectionLabel.text = self.contents[indexPath.section].sectionName
            return headerView
        }else{
            return UICollectionReusableView()
        }
    }
    
    // 섹션 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.contents.count
    }
    
    // 셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("\(sectionName) 섹션 선택됨 \(indexPath.row+1)번 째 콘텐츠")
    }
}

// SwiftUI를 활용한 미리보기
struct HomeVC_Previews : PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewFlowLayout()
            let homeVC = HomeVC(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeVC)
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        typealias UIViewControllerType = UIViewController
    }
}
