import SwiftUI

struct ContentView: View {
@State private var showingRoomList = false
@State private var showingCustomerInfo = false
@State private var checkInDate = Date()
@State private var checkOutDate = Date()
@State private var roomCount = 1
@State private var numberOfPeople = 1
@State private var isDateSelected = false
@State private var navigateToBookingView = false
@State private var navigateToManageBookingView = false

var body: some View {
NavigationView {
ZStack {
// Background image or color
Image("hotel_background") // Replace "hotel_background" with the actual image file name if you have one
.resizable()
.scaledToFill()
.edgesIgnoringSafeArea(.all)

VStack {
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
navigateToManageBookingView = true
}
.frame(minWidth: 0, maxWidth: 200)
.padding()
.background(Color.gray)
.foregroundColor(.white)
.cornerRadius(8)
.shadow(radius: 5)

Spacer()
}

// Navigation links to transition to the booking or manage booking views
NavigationLink(destination: HotelBookingView(), isActive: $navigateToBookingView) {
EmptyView()
}

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
