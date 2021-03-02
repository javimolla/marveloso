//
//  ServiceResolver.swift
//  marveloso
//
//  Created by javimolla on 01/03/2021.
//

import Foundation

class ServiceResolver {
    static var marvelService: MarvelService?
    
    static func getMarvelService() -> MarvelService {
        return ServiceResolver.marvelService ?? MarvelServiceImpl()
    }
}
