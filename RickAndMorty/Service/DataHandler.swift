//
//  DataHandler.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 11.10.2024.
//

import Foundation

final class DataHandler {
    static func handle<T: Decodable>(result: Result<Data, Error>, for type: T.Type) -> T? {
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let response = try decoder.decode(T.self, from: data)
                return response
            } catch {
                print("Ошибка при декодировании JSON: \(error)")
                return nil
            }
        case .failure(let error):
            print("Ошибка сети: \(error)")
            return nil
        }
    }
    
    static func format(dateString: String) -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = dateFormatter.date(from: dateString) {
            let output = DateFormatter()
            output.dateFormat = "dd.MM.yyyy"
            return output.string(from: date)
        }
        return nil
    }
}
