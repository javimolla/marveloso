//
//  Date+Timemillis.swift
//  marveloso
//
//  Created by javimolla on 24/02/2021.
//

import Foundation

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000000)
    }
}
