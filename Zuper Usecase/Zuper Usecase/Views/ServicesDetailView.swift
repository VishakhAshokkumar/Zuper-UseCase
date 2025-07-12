//
//  ServicesDetailView.swift
//  Zuper Usecase
//
//  Created by Vishak on 12/07/25.
//

import SwiftUI
import MapKit

struct ServicesDetailView: View {
    
    // Local coordinates fo Chennai
    @State private var position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 13.0843, longitude: 80.2705),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )


    
    var services: ServiceModel
    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Map(position: $position) {
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: 13.0843, longitude: 80.2705)) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.brown)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.brown, lineWidth: 0.5)
                )
                .padding(.horizontal)

                
                ServicesPreviewView(service: services)
                    .padding(.leading)
            }
            .navigationTitle("Service Details")
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    let service = ServiceModel(title: "Office Space Revamp", customer: "XYZ industries", description: "Transform your office with sleek, contemporary furnishings", scheduledTime: Date(), location: "Maple Avenue, Seatle, WA 98101", serviceNotes: "Ensure all furnitures is removed before the renovation begins", planStatus: .planned, status: .green)
    ServicesDetailView(services: service)
}
