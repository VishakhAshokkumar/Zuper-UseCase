//
//  CustomSearchFieldView.swift
//  Zuper Usecase
//
//  Created by Vishak on 12/07/25.
//

import SwiftUI

struct CustomSearchFieldView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)

            TextField("Search", text: $searchText)
                .foregroundColor(.gray)
                .padding(.vertical, 10)

            Image(systemName: "mic.fill")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }
}

