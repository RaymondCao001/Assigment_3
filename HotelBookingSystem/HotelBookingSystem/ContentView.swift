import SwiftUI

// Define ContentView as a View type
struct ContentView: View {
    @State private var showingRoomList = false
    @State private var showingCustomerInfo = false
    @State private var roomCount = 1
    @State private var numberOfPeople = 1
    @State private var isDateSelected = false
    @State private var navigateToBookingView = false
    @State private var navigateToManageBookingView = false

    var body: some View {
        NavigationView {
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
                        navigateToBookingView = true
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
                        navigateToManageBookingView = true // Activate the navigation state.
                    }
                    .frame(minWidth: 0, maxWidth: 200)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    
                    Spacer()
                }

                // Hidden NavigationLink to navigate to HotelBookingView when activated
                NavigationLink(destination: HotelBookingView(), isActive: $navigateToBookingView) {
                    EmptyView()
                }

                // Hidden NavigationLink to navigate to ManageBookingView when activated.
                NavigationLink(destination: ManageBViewModel(), isActive: $navigateToManageBookingView) {
                    EmptyView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
