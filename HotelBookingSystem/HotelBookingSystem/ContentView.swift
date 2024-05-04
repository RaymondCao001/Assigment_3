import SwiftUI

struct ContentView: View {
    @State private var showingRoomList = false
    @State private var showingCustomerInfo = false
    @State private var checkInDate = Date()
    @State private var isDateSelected = false
    
    var body: some View {
        ZStack {
            // 设置背景图片
            Image("hotel_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome to our Hotel")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.mint) // 设置标题颜色为Mint
                    .padding(.top, 50)
                
                DatePicker("Check-In Date", selection: $checkInDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .onChange(of: checkInDate) { _ in
                        isDateSelected = true
                    }

                Spacer()
                
                // 入住Button
                Button("Check In") {
                    self.showingRoomList = true
                }
                .buttonStyle(PrimaryBlackButtonStyle())
                .padding()
                .disabled(!isDateSelected)
                .fullScreenCover(isPresented: $showingRoomList) {
                    NavigationView {
                        RoomListView(rooms: hotelRooms)
                            .navigationBarItems(leading: Button("Close") {
                                self.showingRoomList = false
                            })
                    }
                }
                
                // 管理Button
                Button("Manage") {
                    self.showingCustomerInfo = true
                }
                .buttonStyle(PrimaryBlackButtonStyle())
                .padding()
                .disabled(!isDateSelected)
                .fullScreenCover(isPresented: $showingCustomerInfo) {
                    NavigationView {
                        CustomerInfoView(room: Room(id: "1", type: "Standard Room", occupancy: 2, bedType: "Queen Size", price: 120.00, area: 45))
                            .navigationBarItems(leading: Button("Close") {
                                self.showingCustomerInfo = false
                            })
                    }
                }
                
                Spacer()
            }
        }
    }
}


struct PrimaryBlackButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.black)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
