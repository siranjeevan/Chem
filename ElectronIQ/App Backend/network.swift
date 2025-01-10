//
//  network.swift
//  H3'sChemistryApp
//
//  Created by shamtech07 on 14/11/24.
//

import SwiftUI
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    @Published var isConnected: Bool = true
    @Published var connectionType: String = "Unknown"

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                if path.usesInterfaceType(.wifi) {
                    self.connectionType = "WiFi"
                } else if path.usesInterfaceType(.cellular) {
                    self.connectionType = "Cellular"
                } else if path.usesInterfaceType(.wiredEthernet) {
                    self.connectionType = "Wired Ethernet"
                } else if path.usesInterfaceType(.loopback) {
                    self.connectionType = "Loopback"
                } else if path.usesInterfaceType(.other) {
                    self.connectionType = "Other"
                } else {
                    self.connectionType = "Unknown"
                }
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}

struct ContentV: View {
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some View {
        VStack {
            if networkMonitor.isConnected {
                Text("Connected to network")
                    .foregroundColor(.green)
                Text("Connection type: \(networkMonitor.connectionType)")
                    .foregroundColor(.blue)
            } else {
                Text("No network connection")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    ContentV()
}
