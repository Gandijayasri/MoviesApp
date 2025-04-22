//
//  MenuModel.swift
//  MoviesApp
//
//  Created by Jayasri Gandi on 22/04/25.
//

import Foundation

struct MenuModel: Codable {
    let statusCode: Int?
    let body: MenuBody?
}
struct MenuBody: Codable {
    let total: Int?
    let data: [Menu]?
}
struct Menu: Codable {
    let id: Int?
    let friendlyURL, seoDescription, title, type: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case friendlyURL = "friendly_url"
        case seoDescription = "seo _description"
        case title, type
    }
}
