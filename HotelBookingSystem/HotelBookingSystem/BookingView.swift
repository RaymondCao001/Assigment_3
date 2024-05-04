import SwiftUI

struct HotelBookingView: View {
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date()
    @State private var showRoomListView = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose Dates")) {
                    DatePicker("Check In", selection: $checkInDate, displayedComponents: .date)
                    DatePicker("Check Out", selection: $checkOutDate, displayedComponents: .date)
                }

                
                Button("Search") {
                    // 当按钮被点击时，触发视图跳转
                    showRoomListView = true
                }
                .buttonStyle(.borderedProminent)

                Button("Manage Bookings") {
                    // 管理预订的逻辑

                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("Hotel Booking")
            .background(
                NavigationLink(destination: RoomListView(checkInDate: checkInDate, checkOutDate: checkOutDate), isActive: $showRoomListView) {
                    EmptyView()
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
