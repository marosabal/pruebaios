//
//  DetailsModels.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

enum Details {

    // MARK: - Use cases
    enum Movie {
        struct Response {
            let response: MovieDetailResponse
        }
        struct ViewModel {
            let title: String
            let overview: String
            let details: String
            let imageUrl: String
            let releaseDate: String
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
}
