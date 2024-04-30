//
//  RoomModel.swift
//  HotelBookingSystem
//
//  Created by Jiale Zhou on 30/04/2024.
//

import Foundation

struct Room: Identifiable {
    var id: String
    var type: String
    var occupancy: Int
    var bedType: String
    var price: Double
    var area: Double
}
