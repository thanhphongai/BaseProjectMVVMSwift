//
//  CommentModel.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

struct CommentModel: Codable {
    let postId: Int
    let id: Int
    let name:String
    let email: String
    let body: String
}

