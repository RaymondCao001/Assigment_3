import SwiftUI
// View representing a list of rooms available for booking in a hotel
struct RoomListView: View {
    
    // Array holding the data for each room, fetched from
    // RoomInfoModel -> 'hotelRooms'
    var rooms = hotelRooms
    var checkInDate: Date
    var checkOutDate: Date
    // Defines the view hierarchy for the RoomListView
    var body: some View {
        List(rooms) { room in
            RoomView(room: room, checkInDate: checkInDate, checkOutDate: checkOutDate)
        }
        .navigationBarTitle("Select a Room")
    }
}

struct RoomView: View {
    @State private var numberOfRooms = 0
    @State private var navigateToCustomerInfo = false
    var room: Room
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Image(room.type.replacingOccurrences(of: " ", with: "_").lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text(room.type).font(.headline)
                    Text("Area: \(room.area, specifier: "%.2f") sqm")
                    Text("Occupancy: \(room.occupancy)")
                    Text("Bed: \(room.bedType)")
                    Text("Price: $\(room.price, specifier: "%.2f") pn")
                }
            }
            
            Stepper("No. of Rooms: \(numberOfRooms)", value: $numberOfRooms, in: 0...100)
            
            Button(action: {
                if numberOfRooms > 0 {
                    navigateToCustomerInfo = true  // The jump is only activated when the number of rooms is greater than 0
                }
            }) {
                Text("Select")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(numberOfRooms > 0 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .disabled(numberOfRooms == 0) // Disable button if no room is selected
            }
            
            // Invisible NavigationLink, controlled entirely by “Select” buttons
            NavigationLink(destination: CustomerInfoView(room: room, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfRooms: numberOfRooms), isActive: $navigateToCustomerInfo) {
                EmptyView()
            }.hidden()
        }
        .padding(.vertical)
    }
}



// Provides a preview of the RoomListView
struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {

        let sampleCheckInDate = Date()
        let sampleCheckOutDate = Calendar.current.date(byAdding: .day, value: 1, to: sampleCheckInDate)!
        
        RoomListView(checkInDate: sampleCheckInDate, checkOutDate: sampleCheckOutDate)
    }
}

