import SwiftUI

struct HotelBookingView: View {
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date().addingTimeInterval(86400) // Ensures check-out is a day after check-in
    @State private var showRoomListView = false

    var body: some View {
        VStack {
            Spacer()
            Form {
                Section(header: Text("Choose Dates")) {
                    DatePicker(
                        "Check In",
                        selection: $checkInDate,
                        in: Date()...,
                        displayedComponents: .date
                    ).onChange(of: checkInDate) { newDate in
                        if checkOutDate <= newDate {
                            checkOutDate = newDate.addingTimeInterval(86400)
                        }
                    }
                    
                    DatePicker(
                        "Check Out",
                        selection: $checkOutDate,
                        in: checkInDate.addingTimeInterval(86400)...,
                        displayedComponents: .date
                    )
                }
            }
            
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
        .navigationTitle("Hotel Booking")
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
