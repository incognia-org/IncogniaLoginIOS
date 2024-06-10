//
//  AccountData.swift
//  IncogniaLoginIOS
//
//  Created by Cristiano Oliveira on 06/06/24.
//

import Foundation
import SwiftData

struct Account {
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

@Model
class AccountData: Identifiable {
    var id: String
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.password = password
    }
}
