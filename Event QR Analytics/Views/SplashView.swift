//
//  SplashView.swift
//  Event QR Analytics
//
//  Created by Mathias Törnblom on 2024-04-23.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        VStack {
            if isActive {
                NavigationViewManager() // Assuming NavigationViewManager is another SwiftUI view
            } else {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Event QR Analytics")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
                self.isActive = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
