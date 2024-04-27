//
//  RoomInfoModel.swift
//  HotelBookingSystem
//
//  Created by Relex on 27/4/2024.
//

import Foundation

struct RoomInfoModel {
    let roomName: String
    let maxOccupancy: Int   // The max number of people can live in this room
    let bedDescription: String  // The bed information
    var remainingRooms: Int   // Rooms remaining
}

var rooms: [RoomInfoModel] = [
    RoomInfoModel(roomName: "Premium King Room", maxOccupancy: 2, bedDescription: "1 king bed", remainingRooms: 100),
    RoomInfoModel(roomName: "King Suite", maxOccupancy: 2, bedDescription: "1 king bed", remainingRooms: 100),
    RoomInfoModel(roomName: "Standard Queen Room", maxOccupancy: 2, bedDescription: "1 queen bed", remainingRooms: 100)
]
