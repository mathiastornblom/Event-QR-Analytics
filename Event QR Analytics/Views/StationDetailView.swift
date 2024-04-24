//
//  StationDetailView.swift
//  Event QR Analytics
//
//  Created by Mathias Törnblom on 2024-04-20.
//

import SwiftUI
import Charts

struct StationDetailView: View {
    var station: ScanningStation

    var body: some View {
        List {
            Section(header: Text("Total Scans")) {
                VStack(alignment: .leading) {
                    Chart {
                        // Horizontal Bar for total scans
                        BarMark(
                            x: .value("Scans Performed", station.totalScansPossible),
                            y: .value("Total Scans", "Total")
                        )
                        .foregroundStyle(.blue)
                        
                        // Horizontal Bar for performed scans
                        if station.totalScansPerformed > 0 {
                            BarMark(
                                x: .value("Scans Performed", station.totalScansPerformed),
                                y: .value("Total Scans", "Performed")
                            )
                            .foregroundStyle(station.totalScansPossible > 0 ? .blue : .clear)
                        }
                        // Horizontal Bar for remaining scans
                            BarMark(
                                x: .value("Scans Remaining", station.totalScansPossible - station.totalScansPerformed),
                                y: .value("Total Scans", "Remaining")
                            )
                            .foregroundStyle((station.totalScansPossible - station.totalScansPerformed) > 0 ? .blue.opacity(0.5) : .clear)
                    }
                    .frame(height: 100)
                    .chartLegend(position: .bottom) // Position legend at the bottom
                    Text("Scans: \(station.totalScansPossible) / \(station.totalScansPerformed) / \(station.totalScansPossible - station.totalScansPerformed)")
                        .accessibilityLabel("Scans completed: \(station.totalScansPerformed) out of \(station.totalScansPossible)")
                }
            }

            Section(header: Text("Scans Per Teams")) {
                ForEach(station.teams) { team in
                    VStack(alignment: .leading) {
                        Text(team.team_name)
                            .font(.headline)
                        Chart {
                            // Horizontal Bar for total scans
                            BarMark(
                                x: .value("Scans Performed", team.scansPossible ),
                                y: .value("Team Scans", "Total")
                            )
                            .foregroundStyle(.green)
                            
                            // Horizontal Bar for performed scans
                            if team.scansPerformed > 0 {
                                BarMark(
                                    x: .value("Scans Performed", team.scansPerformed),
                                    y: .value("Team Scans", "Performed")
                                )
                                .foregroundStyle(.green)
                            }
                            
                            // Horizontal Bar for remaining scans
                            if (team.scansPossible - team.scansPerformed) > 0 {
                                BarMark(
                                    x: .value("Scans Remaining", team.scansPossible - team.scansPerformed),
                                    y: .value("Team Scans", "Remaining")
                                )
                                .foregroundStyle(.green.opacity(0.5))
                            }
                        }
                        .frame(height: 100)
                        .chartLegend(position: .bottom) // Position legend at the bottom
                        Text("Scans: \(team.scansPossible) / \(team.scansPerformed) / \(team.scansPossible - team.scansPerformed) ")
                            .accessibilityLabel("Scans completed: \(team.scansPerformed) out of \(team.scansPossible )")
                    }
                }
            }
        }
        .navigationTitle(station.name)
    }
}


// Sample data for the preview
extension StationDetailView {
    static var previewStation: ScanningStation {
        ScanningStation(id: "1", name: "Station Alpha", totalScansPossible: 100, totalScansPerformed: 70, teams: [
            Team(team_id: "1-1", team_name: "Team A", scansPossible: 50, scansPerformed: 30),
            Team(team_id: "1-2", team_name: "Team B", scansPossible: 50, scansPerformed: 40)
        ])
    }
}

// Preview provider
struct StationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StationDetailView(station: StationDetailView.previewStation)
        }
    }
}

