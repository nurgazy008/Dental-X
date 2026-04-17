//
//  Dental_XApp.swift
//  Dental X
//
//  Created by Nurgazy Zhangozy on 17.04.2026.
//

import SwiftUI

/// Main app entry point
/// Dental X - Dental Clinic Management System
@main
struct Dental_XApp: App {
    // Initialize shared storage on app launch
    @StateObject private var storage = StorageService.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(storage)
        }
    }
}
