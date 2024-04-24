//
//  NavigationViewManager.swift
//  Event QR Analytics
//
//  Created by Mathias Törnblom on 2024-04-20.
//

import SwiftUI

struct NavigationViewManager: View {
    @StateObject var viewModel = ScanningDataViewModel()

    var body: some View {
        NavigationView {
            DashboardView(viewModel: viewModel)
        }
    }
}

struct NavigationViewManager_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewManager()
    }
}
