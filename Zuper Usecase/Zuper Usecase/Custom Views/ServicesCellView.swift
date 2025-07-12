//
//  ServicesCellView.swift
//  Zuper Usecase
//
//  Created by Vishak on 12/07/25.
//

import SwiftUICore
import SwiftUI


struct ServicesCellView: View {
    
    let service: ServiceModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(service.title)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Circle()
                    .foregroundStyle(statusColor(for: service.status))
                    .frame(width: 10, height: 10)
            }
            
            HStack(spacing: 6) {
                Image(systemName: "person.circle")
                    .foregroundColor(Color.blue)
                    .frame(width: 16)
                    .padding(.trailing, 8)
                Text(service.customer)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            HStack(spacing: 6) {
                Image(systemName: "note.text")
                    .foregroundColor(Color.blue)
                    .frame(width: 16)
                    .padding(.trailing, 8)
                Text(service.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                HStack(spacing: 6) {
                    Rectangle()
                        .fill(planStatusColor(for: service.planStatus).opacity(0.3))
                        .frame(width: 10, height: 10)
                        .cornerRadius(2)
                    
                    Text(planStatusText(service.planStatus))
                        .font(.caption)
                        .foregroundColor(planStatusColor(for: service.planStatus))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(planStatusColor(for: service.planStatus).opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(planStatusColor(for: service.planStatus), lineWidth: 1)
                )
                .cornerRadius(8)
                
                Spacer()
                
                Text(formatDate(service.scheduledTime))
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
    
    // MARK: - Utility Methods
    
    func formatDate(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today, \(timeFormatter.string(from: date))"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday, \(timeFormatter.string(from: date))"
        } else {
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.dateFormat = "EEEE"
            return "\(weekdayFormatter.string(from: date)), \(timeFormatter.string(from: date))"
        }
    }
    
    func planStatusText(_ status: PlanStatus) -> String {
        switch status {
        case .planned: return "Planned"
        case .scheduled: return "Scheduled"
        case .confirmed: return "Confirmed"
        case .approved: return "Approved"
        }
    }
    
    func planStatusColor(for status: PlanStatus) -> Color {
        switch status {
        case .planned: return .blue
        case .scheduled, .confirmed: return .green
        case .approved: return .orange
        }
    }
    
    func statusColor(for status: Status) -> Color {
        switch status {
        case .green: return .green
        case .yellow: return .yellow
        case .blue: return .blue
        }
    }
}




#Preview {
    let service = ServiceModel(title: "Office Space Revamp", customer: "XYZ industries", description: "Transform your office with sleek, contemporary furnishings", scheduledTime: Date(), location: "Maple Avenue, Seatle, WA 98101", serviceNotes: "Ensure all furnitures is removed before the renovation begins", planStatus: .planned, status: .green)
    ServicesCellView(service: service)
}
