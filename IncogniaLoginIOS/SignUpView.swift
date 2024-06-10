//
//  SignUpView.swift
//  IncogniaLoginIOS
//
//  Created by Cristiano Oliveira on 06/06/24.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    @Environment(\.modelContext) var context
    
    @State private var showingAlert: Bool = false
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Query private var accounts: [AccountData]
    @State private var alertMessage: String = ""
    
    @FocusState private var focusedField: Field?
    enum Field: Hashable {
        case name, email, password, confirmPassword
    }
    
    var body: some View {
        VStack {
            Text("Sign Up to Incognia")
                .font(.title)
                .foregroundColor(Color(red: 78/255, green: 44/255, blue: 77/255))
            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                .resizable()
                .frame(width: CGFloat(64),
                       height: CGFloat(64),
                       alignment: .center)
                .cornerRadius(50.0)
            TextField("Full Name", text: $name)
                .padding()
                .submitLabel(.next)
                .focused($focusedField, equals: .name)
                .onSubmit {
                    focusedField = .email
                }
            TextField("Email", text: $email)
                .padding()
                .autocapitalization(.none)
                .submitLabel(.next)
                .focused($focusedField, equals: .email)
                .onSubmit {
                    focusedField = .password
                }
            SecureField("Password", text: $password)
                .padding()
                .submitLabel(.next)
                .focused($focusedField, equals: .password)
                .onSubmit {
                    focusedField = .confirmPassword
                }
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .submitLabel(.done)
                .focused($focusedField, equals: .confirmPassword)
            
            Button("SIGN UP") {
                onSignUp()
            }.defaultButtonStyle()
            
            Button("ALREADY HAVE AN ACCOUNT? SIGN IN") {
                AppState.shared.reload()
            }
            .padding()
            .foregroundColor(Color(red:0/255, green:152/255, blue:163/255))
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                showingAlert = false
            }
        }
        .landscapeNavigationView()
        .setNavigationView()
        .onTapGesture {
            focusedField = nil
        }
    }
    
    func onSignUp() {
        if (password != confirmPassword) {
            alertMessage = "Wrong password"
            showingAlert = true
            return
        }
        
        let containsAccountWithEmail = accounts.contains { $0.email == email }
        if (containsAccountWithEmail) {
            alertMessage = "This email is already in use"
            showingAlert = true
            return
        }
        
        AppState.shared.setLoggedAccount(Account(name: name, email: email))
        context.insert(AccountData(name: name, email: email, password: password))
        AppState.shared.reload()
    }
}

#Preview {
    SignUpView()
}
