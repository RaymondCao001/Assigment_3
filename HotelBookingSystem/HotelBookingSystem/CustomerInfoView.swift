import SwiftUI

struct CustomerInfoView: View {
    var room: Room
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfRooms: Int
    @EnvironmentObject var pathManager: PathManager
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var showingAlert = false 
    
    
    var body: some View {
        NavigationView {
            Form {
                // Section for input fields for personal information
                Section(header: Text("Enter your personal info")) {
                    HStack {
                        Text("First Name:")
                        TextField("Enter Your First Name", text: $firstName)
                    }
                    HStack {
                        Text("Last Name:")
                        TextField("Enter Your Last Name", text: $lastName)
                    }
                    HStack {
                        Text("Phone Number:")
                        TextField("Enter Phone Number", text: $phoneNumber)
                            .keyboardType(.numberPad) // Ensures numeric input for phone numbers
                    }
                }
                
                
                // Section for the confirmation button
                Section {
                    Button("Confirm") {
                        confirmAction()
                    }
                    .disabled(!isFormValid())
                    .alert(isPresented: $showingAlert) { // Show alert on booking confirmation
                        Alert(title: Text("Booking Confirmed !"), message: Text("Your booking \(numberOfRooms) \(room.type) for \(firstName) \(lastName) has been successfully made."), dismissButton: .default(Text("Return to Homepage")){
                            pathManager.path.append(0)
                            //self.presentationMode.wrappedValue.dismiss() // Dismiss view on confirmation
                        })
                    }
                }
            }
            .navigationBarTitle("Booking Confirm") // Set navigation bar title
        }
    }
  
    // Function to check if the form inputs are valid
    private func isFormValid() -> Bool {
        let isPhoneNumberValid = phoneNumber.allSatisfy { $0.isNumber } && !phoneNumber.isEmpty
        let isFirstNameValid = !firstName.isEmpty
        let isLastNameValid = !lastName.isEmpty
        
        return isPhoneNumberValid && isFirstNameValid && isLastNameValid
    }
    
    
    // Function to handle the confirmation action
    private func confirmAction() {
        saveBookingDetails()
        showingAlert = true
    }
    
    // Function to save booking details to a file
    private func saveBookingDetails() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let checkInStr = dateFormatter.string(from: checkInDate)
        let checkOutStr = dateFormatter.string(from: checkOutDate)
        
        // Prepare the CSV formatted string
        let csvLine = "\(firstName),\(lastName),\(phoneNumber),\(room.type),\(numberOfRooms),\(checkInStr),\(checkOutStr)\n"
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = documentsDirectory.appendingPathComponent("bookings.csv")
        
        // Check if the file exists, if not, create it
        if !fileManager.fileExists(atPath: fileName.path) {
            fileManager.createFile(atPath: fileName.path, contents: nil, attributes: nil)
        }
        
        // Attempt to write to the file
        if let fileHandle = try? FileHandle(forWritingTo: fileName) {
            fileHandle.seekToEndOfFile()
            if let data = csvLine.data(using: .utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
            print("Booking details saved to: \(fileName.path)")
                } else {
                    print("Failed to save booking details.")
                }
        }
    }




//struct CustomerInfoView_Previews: PreviewProvider {
   //static var previews: some View {
        //CustomerInfoView(room: Room(id: "1", type: "Standard Room", occupancy: 2, bedType: "Queen Size", price: 120.00, area: 45),checkInDate: Date(), checkOutDate: Date(),numberOfRooms: 3)
   //}
//}
