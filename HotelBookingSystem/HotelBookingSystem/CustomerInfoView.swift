//
//  CustomerInfoView.swift
//  HotelBookingSystem
//
//  Created by Relex on 27/4/2024.
//

import SwiftUI

struct CustomerInfoView: View {
    var room: Room
    
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
                        Alert(title: Text("Booking Confirmed"), message: Text("Your booking for \(firstName) \(lastName) has been successfully made."), dismissButton: .default(Text("Return to Homepage")){
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
        showingAlert = true
    }
}

struct CustomerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerInfoView(room: Room(id: "1", type: "Standard Room", occupancy: 2, bedType: "Queen Size", price: 120.00, area: 45))
    }
}
