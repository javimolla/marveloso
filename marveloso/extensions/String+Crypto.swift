//
//  String+Crypto.swift
//  marveloso
//
//  Created by javimolla on 24/02/2021.
//

import Foundation
import CryptoKit

extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
