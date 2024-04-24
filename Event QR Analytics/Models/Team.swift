//
//  Team.swift
//  Event QR Analytics
//
//  Created by Mathias Törnblom on 2024-04-21.
//

import Foundation

struct Team: Codable, Identifiable {
    var team_id: String
    var team_name: String
    var scansPossible: Int
    var scansPerformed: Int

    enum CodingKeys: String, CodingKey {
        case team_id = "team_id"
        case team_name = "team_name"
        case scansPossible = "scansPossible"
        case scansPerformed = "scansPerformed"
    }

    var id: String { team_id } // Make `Team` conform to `Identifiable`
}
