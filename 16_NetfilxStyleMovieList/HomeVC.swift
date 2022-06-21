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
        
        self.collectionView.backgroundColor = .black
        self.view.backgroundColor = .black
        
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
        self.collectionView.register(ContentViewRankCell.self, forCellWithReuseIdentifier: "ContentViewRankCell")
        self.collectionView.register(ContentViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentViewHeader")
        self.collectionView.register(ContentViewMainCell.self, forCellWithReuseIdentifier: "ContentViewMainCell")
        
        self.collectionView.collectionViewLayout = self.layout()
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
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentViewRankCell", for: indexPath) as? ContentViewRankCell else {return UICollectionViewCell()}
            cell.imageView.image = self.contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = "\((indexPath.row) + 1)"
            return cell
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentViewMainCell", for: indexPath) as? ContentViewMainCell else {return UICollectionViewCell()}
            cell.label.text = self.contents[indexPath.section].contentItem[indexPath.row].description
            cell.imageView.image = self.contents[indexPath.section].contentItem[indexPath.row].image
            return cell
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
    
    // 각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout{
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, Environment -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            
            switch self.contents[sectionNumber].sectionType{
            case .basic:
                return self.createBasicSection()
            case .large:
                return self.createLargeSection()
            case .rank:
                return self.createRankSection()
            case .main:
                return self.createMainSection()
                
            }
        }
    }
    
    // 기본 화면 layout
    private func createBasicSection() -> NSCollectionLayoutSection{
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let header = self.createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // 큰 화면 layout
    private func createLargeSection() ->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        section.boundarySupplementaryItems = [self.createSectionHeader()]
        
        return section
    }
    
    // 순위 화면 layout
    private func createRankSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        section.boundarySupplementaryItems = [self.createSectionHeader()]
        
        return section
    }
    
    // 메인 화면 layout
    private func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    // SectionHeader layout설정
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        // 사이즈
        let layoutSectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        // layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
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
