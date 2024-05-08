//
//  Handler.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

enum PlistKey: String {
    case WebURL
}

struct Handler {
    fileprivate static var infoDict: [String: Any] {
        guard let dictionary = Bundle.main.infoDictionary else { fatalError("Plist file not found") }
        return dictionary
    }
    
    static func configuration(_ key: PlistKey) -> String {
        return Handler.infoDict[key.rawValue] as! String
    }
}
