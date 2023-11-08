//
//  NetworkManager.swift
//  Demo
//
//  Created by Admin on 07.11.2023.
//

import Foundation
import Combine

fileprivate let urlString = "https://myjsons.com/v/56f91893"

class NetworkManager {
    
    var anyCancellable = Set<AnyCancellable>()
    func getResults() -> AnyPublisher<[ItemResultModel], Error> {
        
        let url = URL(string: urlString)!
        let decoder = JSONDecoder()
        
        return Future {[weak self] response in
            guard let self = self else { return }
            URLSession.shared.dataTaskPublisher(for: url)
                .retry(1)
                .mapError {$0}
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: ResultModel.self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    
                    
                } receiveValue: { result in
                    response(.success(result.items))
                    
                }
                .store(in: &self.anyCancellable)
            
        }
        .eraseToAnyPublisher()
    }
}
