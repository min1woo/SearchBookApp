//
//  BookNetWork.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/7/24.
//
import Foundation

class BookNetWork {
    static let shared = BookNetWork() // 싱글턴 인스턴스 생성
    
    private let baseURL = "https://dapi.kakao.com/v3/search/book"
    private let apiKey = "ba261ac7a3fbd1460b0b1e540e4f4031"
    
    private init() {}
    
    // 책 검색 함수
    func fetchBooks(query: String, completion: @escaping (Result<[BookModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            completion(.failure(NSError(domain: "URLCreationError", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(SearchResponse.self, from: data)
                completion(.success(responseData.documents))
            } catch {
                print("Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
