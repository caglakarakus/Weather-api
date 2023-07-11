//
//  HomeViewModel.swift
//  WeatherAPI
//
//  Created by Çağla Karakuş on 10.03.2023.
//





import Foundation
import Alamofire

class HomeViewModel: ObservableObject {
    // MARK: INIT
    init(){
        fetchWeatherData(for: "Ankara", isSave: false) {_ in}
    }
    // MARK: PROPERTIES
    @Published var isAlertActive: Bool = false
    @Published var searchString: String = ""
    @Published var weatherState: WeatherState!
}
// MARK: Functions
extension HomeViewModel {

    func convertWeatherData(weatherDataModel:WeatherDataModel) -> WeatherState{
    var urls:[URL]=[]
        
        for string in weatherDataModel.current.weatherIcons{
            
            let url = URL(string: string)
            urls.append(url!)
            
        }
        
    
        return WeatherState(temperature: weatherDataModel.current.temperature, city: weatherDataModel.request.query, desriptions: weatherDataModel.current.weatherDescriptions, icons: urls)
    }
    
    func getSearchedCityList() -> [WeatherState]{
        let defaults = UserDefaults.standard
        var searchedCities: [WeatherState] = []
        
        if let dataArr = defaults.object(forKey: "SEARCHED_CITY_FOR_USER_DEFAULTS") as? [Data] {
            for data in dataArr {
                if let decoded = try? JSONDecoder().decode(WeatherState.self, from: data){
                    searchedCities.append(decoded)
                }
            }
        }
        
        searchedCities = searchedCities.reversed()
        
        return searchedCities
    }
    
    func saveToUserDefaults(weatherState: WeatherState) {
        let defaults = UserDefaults.standard
        var searchedCities: [Data] = []
        if let arrObj = defaults.object(forKey: "SEARCHED_CITY_FOR_USER_DEFAULTS") as? [Data] {
            searchedCities.append(contentsOf: arrObj)
        }
        
        if let encoded = try? JSONEncoder().encode(weatherState) {
            searchedCities.append(encoded)
        }
        
        defaults.set(searchedCities, forKey: "SEARCHED_CITY_FOR_USER_DEFAULTS")
        defaults.synchronize()
        
    }
    
    func fetchWeatherData(for city: String, isSave: Bool = true, completion: @escaping (Result<WeatherDataModel, APIError>) -> Void) {
        let urlString = String.concatenate(API.baseURL, API.apiKey, API.queryParameter, city)

        guard let safeURLString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let endpointURL = URL(string: safeURLString) else {
            return
        }

        
        

        
        /*
        
        AF.request(endpointURL).responseDecodable(of: WeatherDataModel.self) { response in
            switch response.result{
                
                //guard case or switch case
                
            case .success(let decodedWeatherData):
                self.weatherData = decodedWeatherData
            case .failure(let error): completion(.failure(.requestFailed(description: "unknown failure")))
                
            
        
            }
            
            
        }
         
         
         */
        
        
        AF.request(endpointURL).responseDecodable(of: WeatherDataModel.self) { response in
            switch response.result {
            case .success(let decodedWeatherData):
                self.weatherState = self.convertWeatherData(weatherDataModel: decodedWeatherData)
                if(isSave){
                    self.saveToUserDefaults(weatherState: self.weatherState)
                }
            case .failure(let error):
                var errorDescription = "unknown failure"
                
                switch error {
                case .invalidURL(let url):
                    errorDescription = "Invalid URL: \(url) - \(error.localizedDescription)"
                case .parameterEncodingFailed(let reason):
                    errorDescription = "Parameter encoding failed: \(error.localizedDescription) Failure Reason: \(reason)"
                case .multipartEncodingFailed(let reason):
                    errorDescription = "Multipart encoding failed: \(error.localizedDescription) Failure Reason: \(reason)"
                case .responseValidationFailed(let reason):
                    errorDescription = "Response validation failed: \(error.localizedDescription) Failure Reason: \(reason)"
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        errorDescription += " Downloaded file could not be read"
                    case .missingContentType(let acceptableContentTypes):
                        errorDescription += " Content Type Missing: \(acceptableContentTypes)"
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        errorDescription += " Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                    case .unacceptableStatusCode(let code):
                        errorDescription += " Response status code was unacceptable: \(code)"
                    case .customValidationFailed(error: let error):
                        // handle custom validation failure
                        errorDescription += " \(error.localizedDescription)"
                    }
                    
                case .responseSerializationFailed(let reason):
                    errorDescription = "Response serialization failed: \(error.localizedDescription) Failure Reason: \(reason)"
                default:
                    errorDescription = "unknown failure"
                }
                
                completion(.failure(.requestFailed(description: errorDescription)))
            }
        }

         
    }
}


