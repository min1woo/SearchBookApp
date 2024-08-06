//
//  SearchBookCell.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/6/24.
//

import UIKit
import SnapKit

class SearchBookCell: UICollectionViewCell {
    static let id = "SearchBookCell"
    
    // 셀 안에 들어갈 책 포스터
    let bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "베헬라")
        return imageView
    }()
    
    // 셀 안에 들어갈 책 제목
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "게임속 바바리안으로 살아남기"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셀 안에 생성한 UI 넣기 및 레이아웃 설정
    private func setupCell() {
        contentView.backgroundColor = .orange
        [bookImage, titleLabel].forEach{ contentView.addSubview($0) }
        
        bookImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.width.equalTo(80)
            $0.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(bookImage.snp.trailing).offset(10)
        }
    
    }
    
}
