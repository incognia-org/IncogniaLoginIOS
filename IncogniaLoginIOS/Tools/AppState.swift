//
//  AppState.swift
//  IncogniaLoginIOS
//
//  Created by Cristiano Oliveira on 06/06/24.
//

import Foundation

class AppState: ObservableObject {
    private let loggedKey = "logged"
    private let nameKey = "name"
    private let emailKey = "email"
    
    static let shared = AppState()

    @Published var reloadID = UUID()
    
    func isLogged() -> Bool {
        return UserDefaults.standard.bool(forKey: loggedKey)
    }
    
    func loggedAccount() -> Account? {
        if (isLogged()) {
            let name = UserDefaults.standard.string(forKey: nameKey)
            let email = UserDefaults.standard.string(forKey: emailKey)
            if (name != nil && email != nil) {
                return Account(name: name!, email: email!)
            }
        }
        return nil
    }
    
    func setLoggedAccount(_ account: Account) {
        UserDefaults.standard.setValue(true, forKey: loggedKey)
        UserDefaults.standard.setValue(account.name, forKey: nameKey)
        UserDefaults.standard.setValue(account.email, forKey: emailKey)
    }
    
    func clearLoggedAccount() {
        UserDefaults.standard.setValue(false, forKey: loggedKey)
    }
    
    func reload() {
        reloadID = UUID()
    }
}
