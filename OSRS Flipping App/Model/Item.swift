//
//  Item.swift
//  OSRS Flipping App
//
//  Created by Bronson Mullens on 2/26/21.
//

import Foundation

// MARK: - Welcome

struct Welcome: Codable {
    let item: Item
}

// MARK: - Item

struct Item: Codable {
    let icon, iconLarge: String
    let id: Int
    let type: String
    let typeIcon: String
    let name, itemDescription: String
    let current, today: Current
    let members: String
    let day30, day90, day180: Day
    
    enum CodingKeys: String, CodingKey {
        case icon
        case iconLarge = "icon_large"
        case id, type, typeIcon, name
        case itemDescription = "description"
        case current, today, members, day30, day90, day180
    }
}

// MARK: - Current

struct Current: Codable {
    let trend, price: String
}

// MARK: - Day

struct Day: Codable {
    let trend, change: String
}
