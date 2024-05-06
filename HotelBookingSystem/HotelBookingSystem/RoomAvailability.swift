//
//  RoomAvailability.swift
//  HotelBookingSystem
//
//  Created by Relex on 6/5/2024.
//

import Foundation

struct RoomAvailability {
    var roomId: String
    var date: Date
    var availableUnits: Int
}

func readCSV(fromPath path: String) -> [RoomAvailability] {
    do {
        let content = try String(contentsOfFile: path)
        let rows = content.split(separator: "\n")
        var availabilities = [RoomAvailability]()

        for row in rows.dropFirst() {  // Drop first to skip header
            let columns = row.split(separator: ",")
            if columns.count == 3 {
                if let date = DateFormatter().date(from: String(columns[1])),
                   let availableUnits = Int(columns[2]) {
                    let availability = RoomAvailability(
                        roomId: String(columns[0]),
                        date: date,
                        availableUnits: availableUnits
                    )
                    availabilities.append(availability)
                }
            }
        }
        return availabilities
    } catch {
        print("Error reading CSV file: \(error)")
        return []
    }
}
