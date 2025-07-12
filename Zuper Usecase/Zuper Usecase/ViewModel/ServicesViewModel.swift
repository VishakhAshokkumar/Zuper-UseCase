//
//  ServicesViewModel.swift
//  Zuper Usecase
//
//  Created by Vishak on 12/07/25.
//

import SwiftUI
import Combine


class ServicesViewModel: ObservableObject {
    
    @Published var searchtext: String = ""
    @Published var services: [ServiceModel] = []
    
    
    private var allServices: [ServiceModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let networkManager: NetworkManageable
    
    // Dependency injection for mocking in tests
    init(networkManager: NetworkManageable = NetworkManager.shared) {
        self.networkManager = networkManager
        setupBindings()
        fetchData()
    }
    
    private func setupBindings() {
        $searchtext
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filterServices(with: text)
            }
            .store(in: &cancellables)
    }
    
    func fetchData() {
        
        networkManager.fetchServices { [weak self] services in
            guard let self = self else { return }
            
            self.allServices = services
            self.filterServices(with: self.searchtext)
            
        }
    }
    
    func addNewData() {
        fetchData()
    }
    
    private func filterServices(with text: String) {
        if text.isEmpty {
            services = allServices
        } else {
            services = allServices.filter {
                $0.title.localizedCaseInsensitiveContains(text)
            }
        }
    }
}
