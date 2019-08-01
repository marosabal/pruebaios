//
//  ListModels.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

typealias MovieInfo = List.MovieData

enum List {

    // MARK: - Use cases

    struct MovieData {
        let id: Int
        let title: String
        let imageURL: String
    }

    enum Movies {
        struct Response {
            let results: [Result]
        }
        struct ViewModel {
            let results: [MovieInfo]
        }
    }

    enum MoreMovies {
        struct Response {
            let results: [Result]
        }
        struct ViewModel {
            let results: [MovieInfo]
        }
    }

    struct Error {
        struct Response {
            let message: String
        }
        struct ViewModel {
            let message: String
        }
    }

    enum SelectedMovie {
        struct Request {
            let id: Int
        }
    }
}
