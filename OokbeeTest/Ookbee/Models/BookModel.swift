//
//  BookModel.swift
//  OokbeeTest
//
//  Created by Teerapat on 10/5/19.
//  Copyright © 2019 OokbeeTest. All rights reserved.
//

import Foundation
/*
 “bookId” : 0,
 “bookName” : “String”,
 “bookAuthor”: “String”,
 “bookPrice” : 0.0
 */
struct BookModel: Codable {
    
    var bookId: Int = 0
    var bookName: String = ""
    var bookAuthor: String = ""
    var bookPrice: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case bookId
        case bookName
        case bookAuthor
        case bookPrice
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if values.contains(.bookId) {
            bookId = try values.decode(Int.self, forKey: .bookId)
        }
        if values.contains(.bookName) {
            bookName = try values.decode(String.self, forKey: .bookName)
        }
        if values.contains(.bookAuthor) {
            bookAuthor = try values.decode(String.self, forKey: .bookAuthor)
        }
        if values.contains(.bookPrice) {
            bookPrice = try values.decode(Double.self, forKey: .bookPrice)
        }
    }
    
    func encode(to encoder: Encoder) throws
    {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode (bookId, forKey: .bookId)
        try values.encode (bookName, forKey: .bookName)
        try values.encode (bookAuthor, forKey: .bookAuthor)
        try values.encode (bookPrice, forKey: .bookPrice)
    }
    
    init(bookId: Int,bookName: String,bookAuthor: String,bookPrice: Double) {
        self.bookId = bookId
        self.bookName = bookName
        self.bookAuthor = bookAuthor
        self.bookPrice = bookPrice
    }
}
