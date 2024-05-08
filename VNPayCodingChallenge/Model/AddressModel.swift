//
//  AddressModel.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

struct AddressModel: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: [String:String]
}

