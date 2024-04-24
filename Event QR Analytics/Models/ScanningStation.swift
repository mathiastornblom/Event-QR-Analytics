//
//  ScanningStation.swift
//  Event QR Analytics
//
//  Created by Mathias Törnblom on 2024-04-21.
//

import Foundation

struct ScanningStation: Codable, Identifiable {
    var id: String
    var name: String
    var totalScansPossible: Int
    var totalScansPerformed: Int
    var teams: [Team]
}
