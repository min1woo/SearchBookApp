//
//  SaveBookCoreData.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/8/24.
//

import UIKit
import CoreData

class SaveBookCoreData {
    static let shared = SaveBookCoreData()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // 책정보 저장 함수
    func saveBookInfo(bookTitle: String, authors: String, bookPrice: String) {
        let newBookInfo = BookInfo(context: context) // 새로운 BookInfo 객체 생성
        newBookInfo.bookTitle = bookTitle
        newBookInfo.authors = authors
        newBookInfo.bookPrice = bookPrice
        
        do {
            try context.save() // 컨텍스트 저장
        } catch {
            print("책 저장 실패")
        }
    }
    
//    책 정보를 불러오는 함수
    func fetchBookInfo() -> [BookInfo] {
        let fetchRequest: NSFetchRequest<BookInfo> = BookInfo.fetchRequest() // fetchRequest 생성
        
        do {
            let bookInfos = try context.fetch(fetchRequest) // 불러오기 실행
            return bookInfos
        } catch {
            print("책 정보 불러오기 실패")
            return []
        }
    }
    
    // 모든 책 정보를 삭제하는 함수
    func deleteAllBookInfo() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = BookInfo.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("모든 책 정보 삭제 실패: \(error)")
        }
    }
    
    // 책 정보를 삭제하는 메서드
    func deleteBookInfo(bookInfo: BookInfo) {
        context.delete(bookInfo)
        
        do {
            try context.save()
        } catch {
            print("삭제실패: \(error)")
        }
    }
    
}
