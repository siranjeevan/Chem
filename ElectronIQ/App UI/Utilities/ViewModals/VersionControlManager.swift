//
//  ViewModal.swift
//  H3'sChemistryApp
//
//  Created by shamtech07 on 09/11/24.
//


import Foundation
import Combine

struct VersionInfo: Codable {
    let version: String
}

class VersionViewModel: ObservableObject {
    @Published var versionInfo: VersionInfo?
    @Published var isLoading = false
    @Published var error: String?

    // Fetch version from API
    func fetchVersion() {
        guard let url = URL(string: "https://gmx6yvrje6.execute-api.ap-southeast-2.amazonaws.com/prod/version") else {
            error = "Invalid URL"
            return
        }

        isLoading = true
        error = nil

        URLSession.shared.dataTask(with: url) { [weak self] data, _, networkError in
            DispatchQueue.main.async {
                guard let self = self else { return }

                self.isLoading = false

                if let networkError = networkError {
                    self.error = "Failed to fetch data: \(networkError.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.error = "No data received."
                    return
                }

                let decoder = JSONDecoder()
                if let decodedData = try? decoder.decode(VersionInfo.self, from: data) {
                    self.versionInfo = decodedData
                } else {
                    self.error = "Failed to decode data."
                }
            }
        }
        .resume()
    }
}
import SwiftUI

struct VersionView: View {
    @StateObject private var viewModel = VersionViewModel()

    var body: some View {
        VStack {
            // Show loading spinner when fetching version
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.trailing,20)
            }
            // Show error if any
            else if let error = viewModel.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding(.trailing,20)
            }
            // Show version info once fetched
            else if let version = viewModel.versionInfo?.version {
                Text("Version \(version)")
                    .font(.custom(versionFont,size: 10 ))
                Text("Powered by Hope3 Foundation")
                    .font(.custom(versionFont,size: 12 ))
                Text("Developed by Arjava Technologies")
                    .font(.custom(versionFont,size: 12 ))
            }
        }
        .opacity(0.5)
        
        .padding()
        .foregroundColor(versionContentColor)
        .onAppear {
            viewModel.fetchVersion()  // Fetch version when the view appears
        }
        
    }
}

#Preview {
    PeriodicTableView()
}
