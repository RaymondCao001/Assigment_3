import SwiftUI

struct HotelBookingView: View {
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date().addingTimeInterval(86400) // Ensures check-out is a day after check-in
    @State private var showRoomListView = false
    @State private var showManageBViewModel = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Form {
                    Section(header: Text("Choose Dates")) {
                        DatePicker(
                            "Check In",
                            selection: $checkInDate,
                            in: Date()..., // Disallows past dates
                            displayedComponents: .date
                        ).onChange(of: checkInDate) { newDate in
                            if checkOutDate <= newDate {
                                checkOutDate = newDate.addingTimeInterval(86400) // Adjust check-out date
                            }
                        }
                        
                        DatePicker(
                            "Check Out",
                            selection: $checkOutDate,
                            in: checkInDate.addingTimeInterval(86400)..., // Check-out must be after check-in
                            displayedComponents: .date
                        )
                    }
                    Button("Search") {
                        showRoomListView = true
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(checkOutDate <= checkInDate)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    Button("Manage Bookings") {
                        // Implement manage bookings functionality
                        showManageBViewModel = true
                    }
                    .buttonStyle(.bordered)
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                Spacer()
            }
            .navigationTitle("Hotel Booking")
            .background(
                Group {
                                    NavigationLink(destination: RoomListView(checkInDate: checkInDate, checkOutDate: checkOutDate), isActive: $showRoomListView) {
                                        EmptyView()
                                    }
                                    NavigationLink(destination: ManageBViewModel(), isActive: $showManageBViewModel) {
                                        EmptyView()
                                    }
                                }
            )
        }
    }
}

struct HotelBookingView_Previews: PreviewProvider {
    static var previews: some View {
        HotelBookingView()
    }
}
