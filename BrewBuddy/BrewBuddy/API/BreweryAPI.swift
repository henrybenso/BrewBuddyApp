//
//  BreweryAPI.swift
//  BrewBuddy
//
//  Created by henry benso on 4/25/22.
//

import Foundation


let OPENBREWERY_API_ROOT = "https://api.openbrewerydb.org"
let BREWERY_ENDPOINT = "\(OPENBREWERY_API_ROOT)/breweries"

enum BREWERYAPIError: Error {
    case unsuccessfulDecode
}


func getListBreweries() async throws -> [Brewery] {
    guard let url = URL(string: "\(BREWERY_ENDPOINT)") else {
        fatalError("getListBreweries request error")
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Brewery].self, from: data)
    } catch {
        print(error)
        fatalError("listBreweriesDecodeError")
    }
}


func getListBreweriesByDistance(latitude: String, longitude: String) async throws -> [Brewery2] {
    guard let url = URL(string: "\(BREWERY_ENDPOINT)?by_dist=\(latitude),\(longitude)") else {
        fatalError("getListBreweriesByDistance request error")
    }
    
    do {
        let (data, _)  = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Brewery2].self, from: data)
    } catch {
        print(error)
        fatalError("listBreweriesByDistanceDecodeError")
    }
    
}
