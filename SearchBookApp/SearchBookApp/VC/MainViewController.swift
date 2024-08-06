//
//  MainViewController.swift
//  NetflixCloneCoding
//
//  Created by 유민우 on 8/5/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // 검색창
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
//        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var bookCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchBookCell.self, forCellWithReuseIdentifier: SearchBookCell.id)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [searchBar, bookCollectionView].forEach{ view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
        }
        
        bookCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(70)
        }
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        // 아이템 사이즈 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 그룹 사이즈 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
 
    
}

//extension MainViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }
//}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBookCell.id, for: indexPath) as? SearchBookCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
}
