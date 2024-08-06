//
//  DetailViewController.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/2/24.
//

import UIKit

class DetailViewController: UIViewController {
    // 전체삭제 버튼
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 타이틀
    let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 추가 버튼
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 책 표지 미리보기 이미지
    let bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "베헬라")
        return imageView
    }()
    
    // 가격
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "14,000원"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 책 줄거리가 들어갈 뷰
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()
    
    // 책 줄거리? 정보?
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.text = "줄거리"
        label.font = .systemFont(ofSize: 5)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    // 닫기 버튼
    lazy var colseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("x", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 담기 버튼
    lazy var putinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("담기", for: .normal)
        button.addTarget(self, action: #selector(putinButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    // 전체 삭제 버튼 액션메서드
    @objc private func deleteButtonTapped() {
        
    }
    
    // 추가 버튼 액션 메서드
    @objc private func addButtonTapped() {
        
    }
    
    // 닫기 버튼 액션 메서드
    @objc private func closeButtonTapped() {
        
    }
    
    // 담기 버튼 액션 메서드
    @objc private func putinButtonTapped() {
        
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
}

