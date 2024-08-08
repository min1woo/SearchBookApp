//
//  BookInfo+CoreDataProperties.swift
//  SearchBookApp
//
//  Created by 유민우 on 8/8/24.
//
//

import Foundation
import CoreData


extension BookInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookInfo> {
        return NSFetchRequest<BookInfo>(entityName: "BookInfo")
    }

    @NSManaged public var bookTitle: String?
    @NSManaged public var bookPrice: String?
    @NSManaged public var authors: String?

}

extension BookInfo : Identifiable {

}
