//
//  MainViewController.swift
//  NetflixCloneCoding
//
//  Created by 유민우 on 8/5/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // 책 모델
    var books: [BookModel] = []
    
    // 검색창
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "찾고싶은 책을 입력해 주세요."
        return searchBar
    }()
    
    lazy var bookCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchBookCell.self, forCellWithReuseIdentifier: SearchBookCell.id)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.id)
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
        section.interGroupSpacing = 5
        
        // 헤더 뷰 사이즈 설정
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // 모달 메서드 (디테일 뷰를 띄울 것이다)
    private func showModal(viewController: UIViewController) {
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        self.present(viewController, animated: true)
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        BookNetWork.shared.fetchBooks(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedBooks):
                    self?.books = fetchedBooks
                    self?.bookCollectionView.reloadData()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBookCell.id, for: indexPath) as? SearchBookCell else {
            return UICollectionViewCell()
        }
        let book = books[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    // 컬렉션 뷰의 섹션 헤더뷰를 넣는 메서드
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("실패")
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as! SectionHeaderView
        headerView.configure(with: "검색 결과")
        return headerView
    }
    
    // 컬렉션 뷰의 셀 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    // 컬렉션 뷰의 섹션 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailViewController()
        detailView.book = books[indexPath.row] // 디테일 뷰에 책 정보 전달

        showModal(viewController: detailView)
    }
    
}
