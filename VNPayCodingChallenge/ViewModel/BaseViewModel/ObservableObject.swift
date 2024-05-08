//
//  ObservableObject.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

final class ObservableObject<T> {
    
    private var needBinding = true;
    
    var value: T? {
        
        didSet {
            if(self.needBinding == true) {
                self.listener?(value);
            }
            self.needBinding = true;
        }
    }
    
    private var listener: ((T?) -> Void)?;
    
    init(_ value: T?) {
        self.value = value;
    }
    
    func bind(_ listener: @escaping(T?) -> Void){
        if(value != nil) {
            listener(value)
            self.listener = listener;
        }
    }
    
    func updateNoBind(_ value: T?) {
        needBinding = false;
        self.value = value;
    }
}
