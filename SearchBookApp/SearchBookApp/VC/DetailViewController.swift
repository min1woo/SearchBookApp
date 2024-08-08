//
//  DetailViewController.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/2/24.


import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    // 책 정보 모델
    var book: BookModel?
    
    // 스크롤 뷰
    let scrollView = UIScrollView()
    let scrollContentView = UIView()
    
    // 타이틀
    let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "게임속 바바리안으로 살아남기"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // 글쓴이
    let 글쓴이: UILabel = {
        let label = UILabel()
        label.text = "정윤강"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
 
    // 책 표지 미리보기 이미지
    let bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "베헬라")
        return imageView
    }()
    
    // 가격
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "78,000"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 책 줄거리? 정보?
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.text = "지금껏 아무도 클리어하지 못한 게임 [던전 앤 스톤]을 9년간 플레이한 끝에 최종 보스 스테이지에 도달한 이한수. 그러나 보스 방에 입장함과 동시에, 튜토리얼 완료라는 멘트와 함께 [던전 앤 스톤] 속 바바리안 '비요른 얀델'에 빙의하게 된다. 도시에서 부과하는 막대한 세금을 내지 못하면 '하층민'으로 사형당한다. 빙의한 사실을 들키면 '악령'이라고 판단되어 살해당한다. 살아남을 수 있는 유일한 길은 미궁에 들어가 목숨을 걸고 싸우는 것뿐. 9년간 쌓아온 공략법과 무식하게 강한 바바리안의 육체로, 반드시 이 게임에서 살아남겠다!"
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    // 닫기 버튼
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 20
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 담기 버튼
    lazy var putinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("담기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(putinButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [scrollView, closeButton, putinButton].forEach { view.addSubview($0) }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(70)
        }
        
        scrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(800)
        }
        
        closeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(70)
            $0.height.equalTo(50)
        }
        
        putinButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(260)
            $0.height.equalTo(50)
            
        }
        
        [titlelabel, 글쓴이, bookImage, priceLabel, contentsLabel].forEach {scrollContentView.addSubview($0)}
        
        titlelabel.snp.makeConstraints {
            $0.top.equalTo(scrollContentView).inset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        글쓴이.snp.makeConstraints {
            $0.top.equalTo(titlelabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        bookImage.snp.makeConstraints {
            $0.top.equalTo(글쓴이.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(380)
            $0.width.equalTo(280)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(bookImage.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)

        }
    }
    
    private func loadData() {
        guard let book = book else {return}
        titlelabel.text = book.title
        if 글쓴이.text == book.authors[0] {
            글쓴이.text = book.authors[0]
        } else {
            글쓴이.text = "저자 정보 없음"
        }
        priceLabel.text = "\(book.price)원"
        contentsLabel.text = book.contents
        
        if let url = URL(string: book.thumbnail) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.bookImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        
    }
    
    // 닫기 버튼 액션 메서드
    @objc private func closeButtonTapped() {
        
    }
    
    // 담기 버튼 액션 메서드
    @objc private func putinButtonTapped() {
        
    }
}



