//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import Foundation

enum EndPoint {
    case page(Int)
    case episode(String)
    var description: String {
        switch self {
        case .page(let pageNumber):
            return "https://rickandmortyapi.com/api/character/?page=\(pageNumber)"
        case .episode(let urlString):
            return urlString
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

final class NetworkManager {
    func fetchData(from endPoint: EndPoint, completion: @escaping (Result<Data, Error>) -> Void) {
        getData(from: endPoint.description, completion: completion)
    }
    
    func fetchImage(from string: String, completion: @escaping (Result<Data, Error>) -> Void) {
        getData(from: string, completion: completion)
    }
    
    private func getData(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
                
            completion(.success(data))
            
        }.resume()
    }
}
