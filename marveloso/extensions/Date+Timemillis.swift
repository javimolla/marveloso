//
//  Date+Timemillis.swift
//  marveloso
//
//  Created by liver6 on 24/02/2021.
//

import Foundation

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000000)
    }
}
