import SwiftUI
// View representing a list of rooms available for booking in a hotel
struct RoomListView: View {
    
    // Array holding the data for each room, fetched from
    // RoomInfoModel -> 'hotelRooms'
    var rooms = hotelRooms
    
    // Defines the view hierarchy for the RoomListView
    var body: some View {
        List(rooms) { room in
            RoomView(room: room)
        }
        .navigationBarTitle("Select a Room")
    }
}

struct RoomView: View {
    @State private var numberOfRooms = 0
    @State private var navigateToCustomerInfo = false
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
                Spacer()
                
                Stepper("No. \(numberOfRooms)", value: $numberOfRooms, in: 0...room.number)

                // Navigation link to book the room, leading to the CustomerInfoView
               
                Button(action: {
                                    if numberOfRooms > 0 {
                                        navigateToCustomerInfo = true  // 用户点击时如果选了房间，触发跳转
                                    }
                                }) {
                                    Text("Select")
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .background(numberOfRooms > 0 ? Color.blue : Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        .disabled(numberOfRooms == 0)  // 如果未选择房间则禁用按钮
                                }
                                
                                // 隐藏的 NavigationLink，通过状态变量控制激活
                                NavigationLink(destination: CustomerInfoView(room: room), isActive: $navigateToCustomerInfo) {
                                    EmptyView()  // 不显示任何视图作为导航链接
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
