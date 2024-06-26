import SwiftUI

struct ManageBViewModel: View {
    @State private var bookings: [Booking] = []
    @State private var showDeleteConfirmation = false
    @State private var bookingToDelete: Booking?

    var body: some View {
        NavigationView {
            if bookings.isEmpty {
                // Display a message if there are no bookings
                VStack {
                    Spacer()
                    Text("No Booking Now")
                        .foregroundColor(.gray)
                        .font(.title)
                    Spacer()
                }
            } else {
                // List to display booking details
                List(bookings, id: \.id) { booking in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name: \(booking.firstName) \(booking.lastName)")
                            Text("Phone: \(booking.phoneNumber)")
                            Text("Room Type: \(booking.roomType)")
                            Text("Number of Rooms: \(booking.numberOfRooms)")
                            Text("Check-in: \(booking.checkInDate)")
                            Text("Check-out: \(booking.checkOutDate)")
                        }
                        Spacer()
                        Button(action: {
                            bookingToDelete = booking
                            showDeleteConfirmation = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                        }
                        .frame(width: 30, height: 30)
                        .background(Color.red)
                        .cornerRadius(15)
                    }
                }
                .navigationTitle("Bookings List") // Title for the navigation bar
                .alert(isPresented: $showDeleteConfirmation) { // Alert for delete confirmation
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this booking?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let booking = bookingToDelete {
                                deleteBooking(booking)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
        .onAppear {
            loadBookings() // Load bookings from the CSV file when the view appears
        }
    }
    
    
    // Function to load bookings from a CSV file
    func loadBookings() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = documentsDirectory.appendingPathComponent("bookings.csv")
        
        if let fileHandle = try? FileHandle(forReadingFrom: fileName) {
            let csvData = fileHandle.readDataToEndOfFile()
            fileHandle.closeFile()
            
            if let csvString = String(data: csvData, encoding: .utf8) {
                parseCSV(csvString) // Parse the CSV data
            }
        }
    }
    
    
    // Function to parse CSV data into Booking objects
    func parseCSV(_ csvString: String) {
        bookings.removeAll() // Clear current bookings
        
        let rows = csvString.components(separatedBy: "\n").filter { !$0.isEmpty }
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count > 6 {
                let booking = Booking(
                    id: UUID(),
                    firstName: columns[0],
                    lastName: columns[1],
                    phoneNumber: columns[2],
                    roomType: columns[3],
                    numberOfRooms: Int(columns[4]) ?? 1,
                    checkInDate: columns[5],
                    checkOutDate: columns[6]
                )
                bookings.append(booking)
            }
        }
    }
    
    
    // Function to delete a booking and update the CSV file
    func deleteBooking(_ bookingToDelete: Booking) {
        bookings.removeAll { $0.id == bookingToDelete.id }
        updateCSV() // Update the CSV after deletion
    }
    
    
    // Function to rewrite the updated bookings to the CSV file
    func updateCSV() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = documentsDirectory.appendingPathComponent("bookings.csv")
        
        let newCSVString = bookings.map { booking in
            "\(booking.firstName),\(booking.lastName),\(booking.phoneNumber),\(booking.roomType),\(booking.numberOfRooms),\(booking.checkInDate),\(booking.checkOutDate)"
        }.joined(separator: "\n")
        
        do {
            try newCSVString.write(to: fileName, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to write updated bookings to CSV")
        }
    }
}


// Struct to define the properties of a booking
struct Booking: Identifiable {
    let id: UUID
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var roomType: String
    var numberOfRooms: Int
    var checkInDate: String
    var checkOutDate: String
}

struct ManageBViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ManageBViewModel()
    }
}
