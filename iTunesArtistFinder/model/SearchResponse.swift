//
//  SearchResponse.swift
//  UnidadEditorialTest
//
//  Created by Jorge Cordero Sanchez on 5/10/18.
//  Copyright © 2018 Informagic. All rights reserved.
//

import Foundation

struct SearchResponse: Codable{
    var resultCount: Int
    var results: [SearchElement]?
}
