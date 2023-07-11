//
//  APIError.swift
//  WeatherAPI
//
//  Created by Çağla Karakuş on 15.03.2023.
//

import Foundation


enum APIError: Error {
    case invalidURL
    case requestFailed(description: String)
    case invalidResponse
    case blockedUser
    case resourceDoesNotExits
    case unauthorized
    case invalidData
    case decodingError
    case unknownError(statusCode: Int)
}

/*
// Error Types provided from Weatherstack.com

 404    404_not_found    User requested a resource which does not exist.
 101    missing_access_key    User did not supply an access key.
 101    invalid_access_key    User supplied an invalid access key.
 102    inactive_user    User account is inactive or blocked.
 103    invalid_api_function    User requested a non-existent API function.
 104    usage_limit_reached    User has reached his subscription's monthly request allowance.
 105    function_access_restricted    The user's current subscription does not support this API function.
 105    https_access_restricted    The user's current subscription plan does not support HTTPS.
 601    missing_query    An invalid (or missing) query value was specified.
 602    no_results    The API request did not return any results.
 603    historical_queries_not_supported_on_plan    Historical data is not supported on the current subscription plan.
 604    bulk_queries_not_supported_on_plan    Bulk queries is not supported on the current subscription plan.
 605    invalid_language    An invalid language code was specified.
 606    invalid_unit    An invalid unit value was specified.
 607    invalid_interval    An invalid interval value was specified.
 608    invalid_forecast_days    An invalid forecast days value was specified.
 609    forecast_days_not_supported_on_plan    Weather forecast data is not supported on the current subscription plan.
 611    invalid_historical_date    An invalid historical date was specified.
 612    invalid_historical_time_frame    An invalid historical time frame was specified.
 613    historical_time_frame_too_long    The specified historical time frame is too long. (Maximum: 60 days)
 614    missing_historical_date    An invalid historical date was specified.
 615    request_failed    API request has failed.
 */
