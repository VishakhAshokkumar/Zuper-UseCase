//
//  ServicesView.swift
//  Zuper Usecase
//
//  Created by Vishak on 12/07/25.
//

import SwiftUI


struct ServicesView: View {
    
    // MARK: Viewmodel
    @ObservedObject private var servicesViewModel = ServicesViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomSearchFieldView(searchText: $servicesViewModel.searchtext)
                    .padding(.top)
                
                // Space b.w my search and list
                Spacer()
                // Line below my Search Field
                Divider()
            
                Spacer()
                
                List {
                    ForEach(servicesViewModel.services) { service in
                        ZStack {
                            ServicesCellView(service: service)
        
                            // Defining an navigationLink which overlaps the current servicescellview
                            NavigationLink(destination: ServicesDetailView(services: service)) {
                                EmptyView()
                            }
                            .frame(width: 0, height: 0)
                            
                            
                        }
                        .listRowSeparator(.hidden)
                        
                        
                            
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    servicesViewModel.addNewData()
                }
            }
            .navigationTitle("Services")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    ServicesView()
}

