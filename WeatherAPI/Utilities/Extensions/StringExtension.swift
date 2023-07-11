//
//  String+Extension.swift
//  WeatherAPI
//
//  Created by Çağla Karakuş on 18.03.2023.
//

import Foundation


extension String {
    static func concatenate(_ strings: String...) -> String {
        return strings.joined(separator: "")
    }
}
