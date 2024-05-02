//
//  RoomListView.swift
//  HotelBookingSystem
//
//  Created by Jiale Zhou on 30/04/2024.
//

import SwiftUI

struct RoomListView: View {
    var rooms = hotelRooms
    
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
        HStack {
            Image(room.type.lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 60)
                .cornerRadius(10)
                .padding(.trailing, 10)

            VStack(alignment: .leading) {
                Text(room.type).font(.headline)
                Text("Area: \(room.area, specifier: "%.2f") sqm")
                Text("Occupancy: \(room.occupancy) people")
                Text("Bed: \(room.bedType)")
                Text("Price: $\(room.price, specifier: "%.2f")")
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

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView()
    }
}
