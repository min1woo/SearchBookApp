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
        searchBar.delegate = self
        return searchBar
    }()
    
//    lazy var bookCollectionView: UICollectionView = {
//        let collectionView = UICollectionView()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
//        return collectionView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [searchBar].forEach{ view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
        }
        
    }
    
 
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        <#code#>
    }
}

//extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//}
