//
//  ServicesPreviewView.swift
//  Zuper Usecase
//
//  Created by Vishak on 12/07/25.
//

import SwiftUI

struct ServicesPreviewView: View {
    let service: ServiceModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(service.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
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


            }
            
            groupField(title: "Customer", value: service.customer, systemImage: "person.circle")
            groupField(title: "Description", value: service.description, systemImage: "note.text")
            groupField(title: "Scheduled Time", value: formatDate(service.scheduledTime), systemImage: "clock")
            groupField(title: "Location", value: service.location, systemImage: "mappin.and.ellipse")
            groupField(title: "Service Notes", value: service.serviceNotes, systemImage: "ellipsis.message")
            
        }
        .padding()
        
    }
    
    // MARK: - Utility Methods
    
    private func groupField(title: String, value: String, systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .foregroundColor(.blue)
                    .frame(width: 20)
                Text(title)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.black)
            }

            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
                .padding(.leading, 30)
            }
        
        }


    
    
    private func formatDate(_ date: Date) -> String {
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
    
    private func planStatusText(_ status: PlanStatus) -> String {
        switch status {
        case .planned: return "Planned"
        case .scheduled: return "Scheduled"
        case .confirmed: return "Confirmed"
        case .approved: return "Approved"
        }
    }
    
    private func planStatusColor(for status: PlanStatus) -> Color {
        switch status {
        case .planned: return .blue
        case .scheduled, .confirmed: return .green
        case .approved: return .orange
        }
    }
}

#Preview {
    let service = ServiceModel(title: "Office Space Revamp", customer: "XYZ industries", description: "Transform your office with sleek, contemporary furnishings", scheduledTime: Date(), location: "Maple Avenue, Seatle, WA 98101", serviceNotes: "Ensure all furnitures is removed before the renovation begins", planStatus: .planned, status: .green)
    ServicesPreviewView(service: service)
}
