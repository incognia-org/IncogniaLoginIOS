//
//  IncogniaLoginIOSApp.swift
//  IncogniaLoginIOS
//
//  Created by Cristiano Oliveira on 06/06/24.
//

import SwiftUI
import SwiftData
import CoreLocation

@main
struct IncogniaLoginIOSApp: App {
    
    init() {
        // Application Init
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    @StateObject private var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                if appState.isLogged() {
                    HomeView(account: AppState.shared.loggedAccount()!)
                } else {
                    LoginView()
                }
            }
            .id(appState.reloadID)
        }
        .modelContainer(for: AccountData.self)
    }
}
