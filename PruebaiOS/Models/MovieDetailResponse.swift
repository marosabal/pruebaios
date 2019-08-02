//
//  MovieDetailResponse.swift
//  PruebaiOS
//
//  Created by nisum on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

import Foundation

// MARK: - MovieDetailResponse
struct MovieDetailResponse: Codable {
    let id: Int
    let originalTitle: String
    let genres: [Genre]?
    let backdropPath: String?
    let originalLanguage, overview, title: String?
    let releaseDate: String?
    let posterPath: String?

    // Not needed for now
    //    let adult: Bool?
    //    let budget: Int?
    //    let homepage: String?
    //    let imdbID: String?
    //    let popularity: Double?
    //    let productionCompanies: [ProductionCompany]?
    //    let productionCountries: [ProductionCountry]?
    //    let revenue, runtime: Int?
    //    let spokenLanguages: [SpokenLanguage]?
    //    let status, tagline: String?
    //    let video: Bool?
    //    let voteAverage: Double?
    //    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case genres
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"

        // Not needed for now
        //        case adult
        //        case budget, homepage
        //        case imdbID = "imdb_id"
        //        case popularity
        //        case productionCompanies = "production_companies"
        //        case productionCountries = "production_countries"
        //        case revenue, runtime
        //        case spokenLanguages = "spoken_languages"
        //        case status, tagline, video
        //        case voteAverage = "vote_average"
        //        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// Not needed for now
// MARK: - ProductionCompany
//struct ProductionCompany: Codable {
//    let id: Int
//    let logoPath, name, originCountry: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case logoPath = "logo_path"
//        case name
//        case originCountry = "origin_country"
//    }
//}

// MARK: - ProductionCountry
//struct ProductionCountry: Codable {
//    let name: String
//}

// MARK: - SpokenLanguage
//struct SpokenLanguage: Codable {
//    let name: String
//}
