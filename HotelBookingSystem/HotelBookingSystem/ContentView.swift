import SwiftUI


class PathManager: ObservableObject {
    @Published var path = NavigationPath()
}

// Define ContentView as a View type
struct ContentView: View {
    @EnvironmentObject var pathManager: PathManager
    @State private var showingRoomList = false
    @State private var showingCustomerInfo = false
    @State private var roomCount = 1
    @State private var numberOfPeople = 1
    @State private var isDateSelected = false
    @State private var navigateToBookingView = false
    @State private var navigateToManageBookingView = false

    var body: some View {
        NavigationStack(path: $pathManager.path) {
            ZStack {
                // Background image of the hotel
                Image("hotel_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all) // Extend the image to the edges of the display
                
                VStack {
                    // Title text for the welcome message
                    Text("Welcome to Our Hotel")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                    
                    Spacer()
                    
                    // Button for booking rooms
                    Button("Booking Rooms") {
                        pathManager.path.append(1)
                    }
                    .frame(minWidth: 0, maxWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20) // Space between buttons
                    
                    // Button for managing bookings
                    Button("Manage Booking") {
                        pathManager.path.append(4)
                    }
                    .frame(minWidth: 0, maxWidth: 200)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    
                    Spacer()
                }
            }
            .navigationDestination(for: Int.self) { id in
                switch id {
                case 1: HotelBookingView()
                case 2: RoomListView(checkInDate: Date(), checkOutDate: Date().addingTimeInterval(86400))
                case 3: CustomerInfoView(room: Room(id: String(), type: String(), occupancy: Int(), bedType: String(), price: Double(), area: Double()), checkInDate: Date(), checkOutDate: Date(), numberOfRooms: 1)
                case 4: ManageBViewModel()
                default: ContentView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
