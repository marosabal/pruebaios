//
//  ServicesProtocolSpy.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import UIKit

class ServicesProtocolSpy: MovieManagerProtocol {

    var isSuccess = false
    var handlerData: Data?

    private(set) var isSendRequestCalled = false
    private(set) var isGetMovieDetailsCalled = false
    private(set) var isGetMovieListCalled = false
    private(set) var isDownloadImageUrlCalled = false
    private(set) var isDownloadImageLinkCalled = false

    func sendRequest(_ url: URL, parameters: [String : String], handler: @escaping (Data?, Error?) -> Void) {
        isSendRequestCalled = true
        if isSuccess {
            handler(handlerData, nil)
        } else {
            let error = NSError(domain: "some test error", code: 500, userInfo: nil)
            handler(nil, error)
        }
    }

    func getMovieDetails(id: Int, handler: @escaping (Data?, Error?) -> Void) {
        isGetMovieDetailsCalled = true
        if isSuccess {
            handler(handlerData, nil)
        } else {
            let error = NSError(domain: "getMovieDetails test error", code: 500, userInfo: nil)
            handler(nil, error)
        }
    }

    func getMovieList(page: Int, handler: @escaping (Data?, Error?) -> Void) {
        isGetMovieListCalled = true
        if isSuccess {
            handler(handlerData, nil)
        } else {
            let error = NSError(domain: "getMovieList test error", code: 500, userInfo: nil)
            handler(nil, error)
        }
    }

    func downloadImage(from url: URL, handler: @escaping (Data?) -> Void) {
        isDownloadImageUrlCalled = true
        if isSuccess {
            handler(handlerData)
        } else {
            handler(nil)
        }
    }

    func downloadImage(from link: String, handler: @escaping (Data?) -> Void) {
        isDownloadImageLinkCalled = true
        if isSuccess {
            handler(handlerData)
        } else {
            handler(nil)
        }
    }

}
