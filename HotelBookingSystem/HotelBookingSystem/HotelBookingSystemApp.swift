import SwiftUI

@main
struct HotelBookingSystemApp: App {
    @StateObject private var pathManager = PathManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pathManager)
        }
    }
}
