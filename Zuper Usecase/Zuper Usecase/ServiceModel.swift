//
//  ServiceModel.swift
//  Zuper Usecase
//
//  Created by Vishak on 12/07/25.
//

import Foundation

// MARK: - Service Model

struct ServiceModel: Identifiable {
    var id = UUID()
    var title: String
    var customer: String
    var description: String
    var scheduledTime: Date
    var location: String
    var serviceNotes: String
    var planStatus: PlanStatus
    var status: Status
}

// MARK: - Plan Status Enum

enum PlanStatus: String, Codable, CaseIterable {
    case planned
    case scheduled
    case confirmed
    case approved
}

// MARK: - Status Enum

enum Status: String, Codable, CaseIterable {
    case green
    case yellow
    case blue
}


