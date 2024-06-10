//
//  HomeView.swift
//  IncogniaLoginIOS
//
//  Created by Cristiano Oliveira on 06/06/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var account: Account
    
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        Color(red: 78/255, green: 44/255, blue: 77/255)
                .ignoresSafeArea(.all)
                .overlay(
            VStack{
                VStack{
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .resizable()
                        .frame(width: CGFloat(64),
                               height: CGFloat(64),
                               alignment: .center)
                        .cornerRadius(50.0)
                    Text("Welcome").foregroundColor(Color.white).font(.title3)
                    Text("\(account.name)").foregroundColor(Color.white).fontWeight(.bold).font(.title2)
                    Text("to Incognia").foregroundColor(Color.white).font(.title3)
                }.padding()
                Button("TRANSACTION") {
                    doTransaction()
                }.defaultButtonStyle()
                Button("LOGOUT") {
                    doLogout()
                }.defaultButtonStyle()
            }
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    showingAlert = false
                }
            }
            .landscapeNavigationView()
        )
    }
    
    func doTransaction() {
        let uuid = UUID()
        let transactionId = uuid.uuidString.lowercased()
        alertMessage = "Transaction \(transactionId.prefix(5)) successful!"
        showingAlert = true
    }
    
    func doLogout() {
        AppState.shared.clearLoggedAccount()
        AppState.shared.reload()
    }
}

#Preview {
    HomeView(account: Account(name: "Cris", email: ""))
}
