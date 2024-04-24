//
//  DashboardView.swift
//  Event QR Analytics
//
//  Created by Mathias Törnblom on 2024-04-20.
//

import SwiftUI
import Charts

struct DashboardView: View {
    @ObservedObject var viewModel: ScanningDataViewModel

    init(viewModel: ScanningDataViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    // Show a spinner when data is loading
                    Text("Refreshing station data. Please wait.")
                        .foregroundColor(.secondary)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else if viewModel.stations.isEmpty {
                    // Show a message if no stations are available
                    Text("No scanning stations available. Pull to refresh.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(viewModel.stations) { station in
                        NavigationLink(destination: StationDetailView(station: station)) {
                            VStack(alignment: .leading) {
                                Text(station.name)
                                    .font(.headline)
                                    .accessibilityLabel("Station name: \(station.name)")
                                Chart {
                                    BarMark(
                                        x: .value("Total Scans", station.totalScansPossible),
                                        y: .value("Type", "Total")
                                    )
                                    .foregroundStyle(.blue)
                                    
                                    BarMark(
                                        x: .value("Scans Performed", station.totalScansPerformed),
                                        y: .value("Type", "Performed")
                                    )
                                    .foregroundStyle(.green)
                                    
                                    BarMark(
                                        x: .value("Scans Remaining", station.totalScansPossible - station.totalScansPerformed),
                                        y: .value("Type", "Remaining")
                                    )
                                    .foregroundStyle(.red)
                                }
                                .frame(height: 100)
                                .chartLegend(position: .bottom)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Scanning Stations")
            .refreshable {
                viewModel.loadData()
            }
            .listStyle(.automatic)
        }
        .onAppear {
            if viewModel.stations.isEmpty {
                viewModel.loadData()
            }
        }
    }
}


extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
