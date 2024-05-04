import SwiftUI

struct HotelBookingView: View {
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date()
    @State private var numberOfRooms = 1
    @State private var numberOfAdults = 1
    @State private var numberOfChildren = 0
    @State private var showRoomListView = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("选择日期")) {
                    DatePicker("入住日期", selection: $checkInDate, displayedComponents: .date)
                    DatePicker("离店日期", selection: $checkOutDate, displayedComponents: .date)
                }

                
                Button("搜索") {
                    // 当按钮被点击时，触发视图跳转
                    showRoomListView = true
                }
                .buttonStyle(.borderedProminent)

                Button("管理预订") {
                    // 管理预订的逻辑
                    print("管理预订...")
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("酒店预订")
            .background(
                NavigationLink(destination: RoomListView(), isActive: $showRoomListView) {
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
