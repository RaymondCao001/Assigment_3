import SwiftUI

struct ManageBookingView: View {
    @State private var bookings: [Booking] = []
    
    var body: some View {
        NavigationView {
            List(bookings, id: \.id) { booking in
                VStack(alignment: .leading) {
                    Text("Name: \(booking.firstName) \(booking.lastName)")
                    Text("Phone: \(booking.phoneNumber)")
                    Text("Room Type: \(booking.roomType)")
                    Text("Number of Rooms: \(booking.numberOfRooms)")
                    Text("Check-in: \(booking.checkInDate)")
                    Text("Check-out: \(booking.checkOutDate)")
                }
            }
            .navigationTitle("Bookings List")
            .onAppear {
                loadBookings()
            }
        }
    }
    
    func loadBookings() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = documentsDirectory.appendingPathComponent("bookings.csv")
        
        if let fileHandle = try? FileHandle(forReadingFrom: fileName) {
            let csvData = fileHandle.readDataToEndOfFile()
            fileHandle.closeFile()
            
            if let csvString = String(data: csvData, encoding: .utf8) {
                parseCSV(csvString)
            }
        }
    }
    
    func parseCSV(_ csvString: String) {
        bookings.removeAll()
        
        let rows = csvString.components(separatedBy: "\n")
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
}

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

struct ManageBookView_Previews: PreviewProvider {
    static var previews: some View {
        ManageBookingView()
    }
}
