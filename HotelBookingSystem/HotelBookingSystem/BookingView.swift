import SwiftUI

struct HotelBookingView: View {
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date().addingTimeInterval(86400) // Ensures check-out is a day after check-in
    @State private var showRoomListView = false

    var body: some View {
        VStack {
            Spacer()
            Form {
                // Section for date pickers to choose check-in and check-out dates
                Section(header: Text("Choose Dates")) {
                    DatePicker(
                        "Check In",
                        selection: $checkInDate,
                        in: Date()..., // Restrict past dates
                        displayedComponents: .date
                    ).onChange(of: checkInDate) { newDate in
                        // Ensure check-out is at least one day after check-in
                        if checkOutDate <= newDate {
                            checkOutDate = newDate.addingTimeInterval(86400)
                        }
                    }
                    
                    DatePicker(
                        "Check Out",
                        selection: $checkOutDate,
                        in: checkInDate.addingTimeInterval(86400)..., // Restrict check-out to at least one day after check-in
                        displayedComponents: .date
                    )
                }
            }
 
            // Button to proceed with the search
            Button("Search") {
                showRoomListView = true
            }
            .frame(minWidth: 0, maxWidth: 200)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .shadow(radius: 5)
            .disabled(checkOutDate <= checkInDate)
            
            Spacer()
        }
        .navigationTitle("Hotel Booking") // Set the title for the navigation bar
        .background(
            NavigationLink(destination: RoomListView(checkInDate: checkInDate, checkOutDate: checkOutDate), isActive: $showRoomListView) {
                EmptyView()
            }
        )
    }
}

struct HotelBookingView_Previews: PreviewProvider {
    static var previews: some View {
        HotelBookingView()
    }
}
