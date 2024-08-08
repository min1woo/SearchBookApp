//
//  SaveBookCell.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/8/24.
//

import UIKit
import SnapKit

class SaveBookCell: UITableViewCell {
    static let id = "SaveBookCell"
    var bookInfo: [BookInfo] = []
    
    // 셀 안에 들어갈 책 제목
    let bookTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    // 셀 안에 들어갈 저자
    let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 7)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    // 셀 안에 들어갈 책 가격
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = 8
        [bookTitle, authorsLabel, priceLabel].forEach { contentView.addSubview($0) }
        
        bookTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(55)
            $0.width.equalTo(130)
        }
        
        authorsLabel.snp.makeConstraints {
            $0.leading.equalTo(bookTitle.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        // 셀 테두리 색상설정
        self.layer.borderColor = UIColor.black.cgColor
        // 테두리 두께 설정
        self.layer.borderWidth = 2.0
        // 모서리 반경 설정
        self.layer.cornerRadius = 10
        // 모서리가 둥글어도 되는지 여부 설정
        self.clipsToBounds = true
        
        self.layer.masksToBounds = true
    }
    
    // 셀 구성 메서드
    func configureCell(bookTitle: String, authors: String, bookPrice: String) {
        self.bookTitle.text = bookTitle
        authorsLabel.text = authors
        priceLabel.text = bookPrice
    }
    
}

