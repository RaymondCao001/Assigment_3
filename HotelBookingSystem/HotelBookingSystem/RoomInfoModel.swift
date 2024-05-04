//
//  RoomInfoModel.swift
//  HotelBookingSystem
//
//  Created by Jiale Zhou on 30/4/2024.
//

import Foundation

struct Room: Identifiable {
    var id: String
    var type: String
    var occupancy: Int
    var bedType: String
    var price: Double
    var area: Double
    var number: Int
}

let hotelRooms: [Room] = [
    Room(id: "1", type: "Standard Room", occupancy: 2, bedType: "Queen Size", price: 150.00, area: 45, number: 20),
    Room(id: "2", type: "Superior Room", occupancy: 2, bedType: "King Size", price: 200.00, area: 45,number: 10),
    Room(id: "3", type: "Luxury Room", occupancy: 3, bedType: "King Size", price: 250.00, area: 45,number: 5),
    Room(id: "4", type: "Suite", occupancy: 4, bedType: "King Size", price: 400.00, area: 90,number: 2)
]
