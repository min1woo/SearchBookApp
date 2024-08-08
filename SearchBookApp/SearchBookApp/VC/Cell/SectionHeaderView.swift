//
//  SectionHeaderView.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/7/24.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with text: String) {
        titleLabel.text = text
    }

}
