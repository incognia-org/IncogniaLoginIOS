//
//  ContentView.swift
//  IncogniaLoginIOS
//
//  Created by Cristiano Oliveira on 06/06/24.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Query var accounts: [AccountData]
    
    @State private var showSignUpView: Bool = false
    @State private var showingAlert: Bool = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var alertMessage: String = ""
    
    @FocusState private var focusedField: Field?
    enum Field: Hashable {
        case email, password
    }
    
    var body: some View {
        VStack {
            Text("Sign in to Incognia")
                .font(.title)
                .foregroundColor(Color(red: 78/255, green: 44/255, blue: 77/255))
            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                .resizable()
                .frame(width: CGFloat(64),
                       height: CGFloat(64),
                       alignment: .center)
                .cornerRadius(50.0)
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
                .submitLabel(.done)
                .focused($focusedField, equals: .password)
            Button("SIGN IN") {
                onLogin()
            }.defaultButtonStyle()
            Button("DON'T HAVE AN ACCOUNT? SIGN UP") {
                showSignUpView = true
            }
            .padding()
            .foregroundColor(Color(red:0/255, green:152/255, blue:163/255))
        }
        .navigationDestination(isPresented: $showSignUpView) {
            SignUpView()
                .navigationTitle("")
                .navigationBarHidden(true)
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                showingAlert = false
            }
        }
        .setNavigationView()
        .padding()
        .landscapeNavigationView()
        .onTapGesture {
            focusedField = nil
        }
    }
    
    func onLogin() {
        let accountMatch = accounts.first(where: { $0.email == email })
        if (accountMatch == nil) {
            alertMessage = "This account doesn't exist"
            showingAlert = true
            return
        }
        
        if (accountMatch?.password != password) {
            alertMessage = "Wrong password"
            showingAlert = true
            return
        }
        
        name = accountMatch?.name ?? ""
        AppState.shared.setLoggedAccount(Account(name: name, email: email))
        AppState.shared.reload()
    }
}

#Preview {
    LoginView()
}
