//
//  Item.swift
//  Camera Demo
//
//  Created by Florian Gromes on 27.01.24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Item: Identifiable, Hashable {
    var id = UUID()
    var ean: Int
    var name: String
    var category: Category
    var desc: String
    private var imageName: String
    var image: Image { Image(imageName) }
    
    init(id: UUID = UUID(), ean: Int, name: String, category: Category, desc: String, imageName: String) {
        self.id = id
        self.ean = ean
        self.name = name
        self.category = category
        self.desc = desc
        self.imageName = imageName
    }
}

struct Article: Hashable, Codable{
    let ean: Int
    let name: String
    let category: Category
    let desc: String
    let imageName: String
}

enum Category: String, Codable{
    case Other = "Other"
    case Meat = "Meat"
    case Fruit = "Fruit"
    case Bread = "Bread"
    case Dairy = "Dairy"
}


var dictionary: [Int:Article] = load("Dictionary.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
