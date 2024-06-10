//
//  ViewExtensions.swift
//  IncogniaLoginIOS
//
//  Created by Cristiano Oliveira on 06/06/24.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func setNavigationView() -> some View {
        NavigationStack {
            ZStack {
                self
                    .navigationTitle("")
                    .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(.stack)
    }
    
    func defaultButtonStyle() -> some View {
        self
            .padding()
            .font(Font.headline)
            .foregroundColor(Color.white)
            .frame(width: 310, height: 48, alignment: .center)
            .background(Color(red:0/255, green:152/255, blue:163/255))
            .cornerRadius(CGFloat(20))
            .shadow(color: Color.primary.opacity(0.5),
                    radius: CGFloat(5),
                    x: CGFloat(0),
                    y: CGFloat(5))
    }
    
    @ViewBuilder
    func landscapeNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
