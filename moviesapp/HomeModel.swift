//
//  Homedata.swift
//  moviesapp
//
//  Created by Jayasri Gandi on 24/04/25.
//

import Foundation

struct HomeModel: Codable {
        let statusCode: Int?
        let response: HomeResponse?
}

struct HomeResponse: Codable {
    let data: HomeData?
} 


struct HomeData: Codable {
    let id: Int?
    let friendlyURL, seoDescription, title, type: String?
    let playlists: [Playlist]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case friendlyURL = "friendly_url"
        case seoDescription = "seo_description"
        case title, type, playlists
    }
}
struct Playlist: Codable {
    let id: Int?
    let title: String?
    let content: [Content]?
}

struct Content: Codable {let id: Int?
    let ageRating: AgeRating?
    let videoID: String?
    let contentType: ContentType?
    let title: String?
    let imagery: Imagery?
    
    
    enum  CodingKeys: String, CodingKey {
        case id
        case ageRating = "age_rating"
        case videoID = "video_id"
        case contentType = "content_type"
        case title, imagery
    }
}

enum AgeRating: String, Codable {
    case gÑGeneralAudiences = "Gñ General Audiences"
    case nrNotRatedByMPAA = "NR - Not Rated by MPAA"
    case pg13ÑParentsStronglyCautioned = "PG 13ñ Parents Strongly Cautioned"
    case pg15ParentsStronglyCautioned = "PG 15 - Parents Strongly Cautioned"
    case pgNParentalGuidanceSuggested = "PG ñ Parental Guidance Suggested"
    case the15 = "15+"
    case the18 = "18+"
}

enum ContentType: String, Codable {
    case liveTV = "LiveTV"
    case movie = "movie"
    case series = "series"
}

// MARK: - Imagery
struct Imagery: Codable {
    let thumbnail, backdrop, mobileImg, featuredImg: String?
    let banner: String?
    
    enum CodingKeys: String, CodingKey {
        case thumbnail, backdrop
        case mobileImg = "mobile_img"
        case featuredImg = "featured_img"
        case banner
    }
}
