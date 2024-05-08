//
//  EndPoint.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

enum Path: String {
    case post = "posts"
    case user = "users"
    case comment = "comments"
}

enum APIError: Error {
    case faileedToGetData
}

enum HTTPMethod: String {
    case GET
    case POST
}
