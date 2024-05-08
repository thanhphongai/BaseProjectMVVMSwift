//
//  UserPostModels.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

struct UserPostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct PostResponse {
    let title: String
    let username: String
    let companyName: String
    let content: String
    let postID: Int
    let user: UserModel
    
    static func create(from post: UserPostModel, by user: UserModel) -> PostResponse  {
        PostResponse (title: post.title, username: user.username, companyName: user.company.name, content: post.body, postID: post.id, user: user)
    }
}


