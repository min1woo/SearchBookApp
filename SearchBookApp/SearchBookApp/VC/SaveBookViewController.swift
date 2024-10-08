//
//  SaveBookViewController.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/2/24.
//

import UIKit
import SnapKit

class SaveBookViewController: UIViewController {
    
    var bookInfos: [BookInfo] = []
    
    lazy var allDeleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체삭제", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(allDeleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    lazy var tableVeiw: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SaveBookCell.self, forCellReuseIdentifier: SaveBookCell.id)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bookInfos = SaveBookCoreData.shared.fetchBookInfo()
        tableVeiw.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookInfos = SaveBookCoreData.shared.fetchBookInfo()
        tableVeiw.reloadData()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [allDeleteButton, titleLabel, addButton, tableVeiw].forEach { view.addSubview($0) }
        
        allDeleteButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        tableVeiw.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    @objc private func allDeleteButtonTapped() {
        SaveBookCoreData.shared.deleteAllBookInfo()
        bookInfos = []
        tableVeiw.reloadData()
    }
    
    @objc private func addButtonTapped() {
        
    }
    
}

extension SaveBookViewController: UITableViewDelegate, UITableViewDataSource {
    // 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaveBookCell.id, for: indexPath) as? SaveBookCell else {
            return UITableViewCell()
        }
        let bookInfo = bookInfos[indexPath.row]
        cell.configureCell(bookTitle: bookInfo.bookTitle ?? "", authors: bookInfo.authors ?? "", bookPrice: bookInfo.bookPrice ?? "")
        return cell
    }
    
    // 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // 셀을 스와이프 하여 데이터를 삭제하는 기능 구현
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 데이터 소스에서 해당 항목 삭제
            let bookInfoToDelete = bookInfos[indexPath.row]
            SaveBookCoreData.shared.deleteBookInfo(bookInfo: bookInfoToDelete )
            bookInfos.remove(at: indexPath.row)
            
            // 테이블 뷰 에서 셀 삭제
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
