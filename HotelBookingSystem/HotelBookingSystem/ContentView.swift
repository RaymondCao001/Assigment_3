import SwiftUI

struct ContentView: View {
    @State private var showingRoomList = false
    @State private var showingCustomerInfo = false
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date()
    @State private var roomCount = 1
    @State private var numberOfPeople = 1
    @State private var isDateSelected = false
    
    var body: some View {
        ZStack {
            Image("hotel_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome to our Hotel")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.mint)
                    .padding(.top, 50)
                
                VStack(spacing: 20) {
                    DatePicker("Check-In Date", selection: $checkInDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    DatePicker("Check-Out Date", selection: $checkOutDate, in: checkInDate..., displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Stepper("Rooms: \(roomCount)", value: $roomCount, in: 1...5)
                    Stepper("People: \(numberOfPeople)", value: $numberOfPeople, in: 1...10)
                }
                .padding()

                Spacer()
                
                Button("Search Rooms") {
                    self.showingRoomList = true
                }
                .buttonStyle(PrimaryBlackButtonStyle())
                .padding()
                .disabled(checkOutDate <= checkInDate) // Disable if check-out is before check-in

                Button("Manage") {
                    self.showingCustomerInfo = true
                }
                .buttonStyle(PrimaryBlackButtonStyle())
                .padding()
                
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
