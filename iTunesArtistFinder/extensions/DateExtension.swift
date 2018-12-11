//
//  DateExtension.swift
//  UnidadEditorialTest
//
//  Created by Jorge Cordero Sanchez on 6/10/18.
//  Copyright © 2018 Informagic. All rights reserved.
//

import UIKit

extension Date {
    func getYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let strYear = dateFormatter.string(from: self)
        return strYear
    }
}

