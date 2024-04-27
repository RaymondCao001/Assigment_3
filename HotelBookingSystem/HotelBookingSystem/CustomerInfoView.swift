//
//  CustomerInfoView.swift
//  HotelBookingSystem
//
//  Created by Relex on 27/4/2024.
//

import SwiftUI

struct CustomerInfoView: View {
    @State private var firstName: String = ""
        @State private var lastName: String = ""
        @State private var phoneNumber: String = ""
        
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
                            TextField("Enter Your Phone Number", text: $phoneNumber)
                                .keyboardType(.numberPad)
                        }
                    }
                    
                    Section {
                        Button("Book") {
                            // Action for the Book button
                            bookAction()
                        }
                        .disabled(!isFormValid())
                    }
                }
                .navigationBarTitle("Booking Form")
            }
    }
    
    private func isFormValid() -> Bool {
            let isPhoneNumberValid = phoneNumber.allSatisfy { $0.isNumber } && !phoneNumber.isEmpty
            let isFirstNameValid = !firstName.isEmpty
            let isLastNameValid = !lastName.isEmpty
            
            return isPhoneNumberValid && isFirstNameValid && isLastNameValid
        }
    
    private func bookAction() {
            // Implement the booking action here
            print("Booking information: \(firstName) \(lastName) \(phoneNumber)")
        }
}

#Preview {
    CustomerInfoView()
}
