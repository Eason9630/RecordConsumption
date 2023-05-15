//
//  ItemList.swift
//  RecordConsumption
//
//  Created by 林祔利 on 2023/5/9.
//

import Foundation

struct List: Codable{
    var name: String
    var price: Double
    var date: Date
    var image: String?
    var check: Bool
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func loadItem() -> [List]? {
        let decoder = JSONDecoder()
        let url = documentsDirectory.appendingPathComponent("list")
        print(url)
        guard let data = try? Data(contentsOf: url) else { return nil}
        return try? decoder.decode([List].self, from: data)
    }
    
    
    
    //將資料轉成Data 寫檔，要 Codable or Encodable 才能轉成 Data
    static func saveItem(listes: [List]) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(listes)
        let url = documentsDirectory.appendingPathComponent("list")
        print(url)
        try? data?.write(to: url)
    }
    
    
}
