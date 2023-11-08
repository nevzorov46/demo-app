//
//  ViewModel.swift
//  Demo
//
//  Created by Admin on 06.11.2023.
//

import UIKit
import Combine

class ViewModel {
    
    private var networkService = NetworkManager()
    private var anyCancellable = Set<AnyCancellable>()
    
    @Published var results: [ItemResultModel] = []
    
    func getResults() {
        networkService.getResults()
            .receive(on: DispatchQueue.main)
            .map {$0}
            .sink { complition in
                switch complition {
                case .finished:
                    print("Done")
                case .failure(let error):
                    print(error)
                }
                
            } receiveValue: { [weak self] results in
                guard let this = self else { return }
                this.results = results
                
            }
            .store(in: &anyCancellable)
    }
}

