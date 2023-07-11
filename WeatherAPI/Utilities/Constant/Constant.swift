//
//  Constant.swift
//  WeatherAPI
//
//  Created by Çağla Karakuş on 19.03.2023.
//

import Foundation

struct Constant {}

extension Constant {

    struct StringApp {

        static let appName: String = "Weather App"
        static let errorOccured: String = "Error Occured"
        static let okText: String = "OK"
        static let celciusSymbol: String = "°C"
        static let cityNotFound: String = "City not found"
        static let searchCity: String = "Search City"
    }

    struct ColorName {

        static let darkGray: String = "DarkGray"
    }

    struct DummyURL {

        static let dummyIconURLs: [String] = ["https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"]
    }

    struct ImageStrings {

        static let search: String = "search"
    }

}
