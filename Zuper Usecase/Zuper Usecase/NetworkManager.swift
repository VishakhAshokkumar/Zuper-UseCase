//
//  NetworkManager.swift
//  Zuper Usecase
//
//  Created by Vishak on 12/07/25.
//

import Foundation
import ServicesSampleData

// For mocking during unit testing
protocol NetworkManageable {
    func fetchServices(completion: @escaping ([ServiceModel]) -> Void)
}

// MARK: - Network Manager

class NetworkManager: NetworkManageable {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetchServices(completion: @escaping ([ServiceModel]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let sampleServices = SampleData.generateServices()
            let mappedServices = sampleServices.map { self.mapToServiceModel($0) }
            DispatchQueue.main.async {
                completion(mappedServices)
            }
        }
    }
    

    
    private func mapToServiceModel(_ service: Service) -> ServiceModel {
        return ServiceModel(
            id: UUID(uuidString: service.id) ?? UUID(),
            title: service.title,
            customer: service.customerName,
            description: service.description,
            scheduledTime: ISO8601DateFormatter().date(from: service.scheduledDate) ?? Date(),
            location: service.location,
            serviceNotes: service.serviceNotes,
            planStatus: mapPlanStatus(from: service.priority),
            status: mapStatus(from: service.status)
        )
    }
    
    private func mapPlanStatus(from priority: Priority) -> PlanStatus {
        switch priority {
        case .low: return .planned
        case .medium: return .scheduled
        case .high: return .confirmed
        case .critical: return .approved
        }
    }
    
    private func mapStatus(from status: ServiceStatus) -> Status {
        switch status {
        case .active:
            return .blue
        case .scheduled:
            return .blue
        case .completed:
            return .green
        case .inProgress:
            return .yellow
        case .urgent:
            return .yellow
        }
    }

}

