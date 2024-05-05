//
//  CustomerInfoView.swift
//  HotelBookingSystem
//
//  Created by Relex on 27/4/2024.
//

import SwiftUI

struct CustomerInfoView: View {
    var room: Room
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfRooms: Int
    
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var showingAlert = false // State to manage the alert visibility
    
    
    var body: some View {
        NavigationView {
            Form {
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
                            .keyboardType(.numberPad)
                    }
                }
                
                Section {
                    Button("Confirm") {
                        // Action for the Book button
                        confirmAction()
                    }
                    .disabled(!isFormValid())
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Booking Confirmed"), message: Text("Your booking \(numberOfRooms) \(room.type) for \(firstName) \(lastName) has been successfully made."), dismissButton: .default(Text("Return to Homepage")){
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
            }
            .navigationBarTitle("Booking Confirm")
        }
    }
    
    private func isFormValid() -> Bool {
        let isPhoneNumberValid = phoneNumber.allSatisfy { $0.isNumber } && !phoneNumber.isEmpty
        let isFirstNameValid = !firstName.isEmpty
        let isLastNameValid = !lastName.isEmpty
        
        return isPhoneNumberValid && isFirstNameValid && isLastNameValid
    }
    
    private func confirmAction() {
        // Implement the booking action here
        saveBookingDetails()
        showingAlert = true
    }
    private func saveBookingDetails() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let checkInStr = dateFormatter.string(from: checkInDate)
        let checkOutStr = dateFormatter.string(from: checkOutDate)
        
        let csvLine = "\(firstName),\(lastName),\(phoneNumber),\(room.type),\(numberOfRooms),\(checkInStr),\(checkOutStr)\n"
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = documentsDirectory.appendingPathComponent("bookings.csv")
        
        if !fileManager.fileExists(atPath: fileName.path) {
            fileManager.createFile(atPath: fileName.path, contents: nil, attributes: nil)
        }
        
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
//    static var previews: some View {
//        CustomerInfoView(room: Room(id: "1", type: "Standard Room", occupancy: 2, bedType: "Queen Size", price: 120.00, area: 45),checkInDate: "2024-11-02", checkOutDate: "2024-11-03",numberOfRooms: 3)
//    }
//}
