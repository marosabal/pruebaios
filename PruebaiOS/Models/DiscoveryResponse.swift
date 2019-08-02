//
//  Models.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright © 2019 everis. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let discoveryResponse = try? newJSONDecoder().decode(DiscoveryResponse.self, from: jsonData)

import Foundation

// MARK: - DiscoveryResponse
struct DiscoveryResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let originalTitle: String
    let backdropPath: String?
    let overview, releaseDate: String

    // Not needed for now
    //    let video: Bool
    //    let voteCount: Int
    //    let popularity: Double
    //    let voteAverage: Double
    //    let adult: Bool
    //    let genreIDS: [Int]
    //    let originalLanguage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"

        // Not needed for now
        //        case video
        //        case voteAverage = "vote_average"
        //        case voteCount = "vote_count"
        //        case popularity
        //        case originalLanguage = "original_language"
        //        case genreIDS = "genre_ids"
        //        case adult
    }
}
