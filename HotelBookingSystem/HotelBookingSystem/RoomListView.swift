//
//  RoomListView.swift
//  HotelBookingSystem
//
//  Created by Jiale Zhou on 30/04/2024.
//

import SwiftUI

// View representing a list of rooms available for booking in a hotel
struct RoomListView: View {
    
    // Array holding the data for each room, fetched from
    // RoomInfoModel -> 'hotelRooms'
    var rooms = hotelRooms
    
    // Defines the view hierarchy for the RoomListView
    var body: some View {
        NavigationView {
            List(rooms) { room in
                RoomView(room: room)
            }
            .navigationBarTitle("Select a Room")
        }
    }
}

struct RoomView: View {
    var room: Room
    
    var body: some View {
        
        // Defines the view hierarchy for how each room is displayed
        HStack {
            
            // Displays an image corresponding to the room type
            Image(room.type.lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 60)
                .cornerRadius(10)
                .padding(.trailing, 10)

            // Displays the room data
            VStack(alignment: .leading) {
                Text(room.type).font(.headline)
                Text("Area: \(room.area, specifier: "%.2f") sqm")
                Text("Occupancy: \(room.occupancy) people")
                Text("Bed: \(room.bedType)")
                Text("Price: $\(room.price, specifier: "%.2f")")
                
                // Navigation link to book the room, leading to the CustomerInfoView
                NavigationLink(destination: CustomerInfoView(room: room)) {
                    Text("Select")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical)
    }
}

// Provides a preview of the RoomListView
struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView()
    }
}
