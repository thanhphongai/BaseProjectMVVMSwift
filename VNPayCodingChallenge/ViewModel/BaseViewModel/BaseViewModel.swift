//
//  BaseViewModel.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation


protocol ViewModelProtocol {
    var manager: NetworkManager! { get set }
}

class BaseViewModel: ViewModelProtocol {
    var manager: NetworkManager!
    init() {
        self.manager = NetworkManager();
    }
}

