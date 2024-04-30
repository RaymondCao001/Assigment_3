//
//  RoomListView.swift
//  HotelBookingSystem
//
//  Created by Jiale Zhou on 30/04/2024.
//

import SwiftUI

struct RoomListView: View {
    let rooms: [Room]
    
    var body: some View {
        List(rooms) { room in
            RoomView(room: room)
        }
    }
}

struct RoomView: View {
    var room: Room
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(room.type).font(.headline)
            Text("Area: \(room.area, specifier: "%.2f") sqm")
            Text("Occupancy: \(room.occupancy) people")
            Text("Bed: \(room.bedType)")
            Text("Price: $\(room.price, specifier: "%.2f")")
            Button("Select") {
                // Handle selection action
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding(.vertical)
    }
}

// Preview Provider
struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView(rooms: [
            Room(id: "1", type: "Standard Room", occupancy: 2, bedType: "Queen Size", price: 120.00, area: 45),
            Room(id: "2", type: "Luxury Room", occupancy: 2, bedType: "King Size", price: 200.00, area: 45),
            Room(id: "3", type: "Suite", occupancy: 2, bedType: "King Size", price: 400.00, area: 90),
        ])
    }
}
