//
//  UserModel.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let name, username, email: String
    let address: AddressModel
    let company: CompanyModel
}
