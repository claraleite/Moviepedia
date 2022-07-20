//
//  Movie+API.swift
//  FilmADA
//
//  Created by Francisco Soares Neto on 13/07/22.
//

import Foundation

extension Movie {
    
    
    // MARK: - Donwload de filmes
    static let urlComponents = URLComponents(string: "https://api.themoviedb.org/")!
    
    static func moviesAPI(section: String) async -> [Movie] {
        
        var components = Movie.urlComponents
        components.path = "/3/movie/\(section)"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey),
            URLQueryItem(name: "language", value: "pt-BR")
        ]
        
        let session = URLSession.shared
        
        
        do {
            let (data, _) = try await session.data(from: components.url!)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase             
            
            let movieResult = try decoder.decode(MovieResponse.self, from: data)
            
            return movieResult.results
            
            
        } catch {
            print(error)
        }
        
        return []
    }
    
    static func trendingAPI(section: String) async -> [Movie] {
        
        var components = Movie.urlComponents
        components.path = "/3/trending/\(section)"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey),
            URLQueryItem(name: "language", value: "pt-BR")
        ]
        
        let session = URLSession.shared
        
        
        do {
            let (data, _) = try await session.data(from: components.url!)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(MovieResponse.self, from: data)
            
            return movieResult.results
            
            
        } catch {
            print(error)
        }
        
        return []
    }
    
    static func searchAPI(section: String) async -> [Movie] {
        var components = Movie.urlComponents
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey),
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "query", value: section)
        ]
        
        let session = URLSession.shared
        
        
        do {
            let (data, _) = try await session.data(from: components.url!)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(MovieResponse.self, from: data)
            
            return movieResult.results
            
            
        } catch {
            print(error)
        }
        
        return []
    }
    
    static func genresAPI() async -> [GenreId] {
        var components = Movie.urlComponents
        components.path = "/3/genre/movie/list"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey),
            URLQueryItem(name: "language", value: "pt-BR"),
        ]
        
        let session = URLSession.shared
        
        
        do {
            let (data, _) = try await session.data(from: components.url!)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(GenreResponse.self, from: data)
            
            return movieResult.genres
            
            
        } catch {
            print(error)
        }
        
        return []
    }
    
    // MARK: - Download de imagens
    
    
    static func downloadImageData(withPath: String) async -> Data {
        let urlString = "https://image.tmdb.org/t/p/w780\(withPath)"
        let url: URL = URL(string: urlString)!
        
        let session = URLSession.shared
        session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        do {
            let (imageData, _) = try await session.data(from: url)
            
            return imageData
        } catch {
            print(error)
        }
        
        return Data()
    }
    

    // MARK: - Recuperando a chave da API de um arquivo
    static var apiKey: String {
        guard let url = Bundle.main.url(forResource: "TMDB-Info", withExtension: "plist") else {
            fatalError("Couldn't find api key configuration file.")
        }
        guard let plist = try? NSDictionary(contentsOf: url, error: ()) else {
            fatalError("Couldn't interpret api key configuration file as plist.")
        }
        guard let key = plist["API_KEY"] as? String else {
            fatalError("Couldn't find an api key in its configuration file.")
        }
        return key
    }
}

