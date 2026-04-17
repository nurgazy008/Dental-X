//
//  MainTabView.swift
//  Dental X
//
//  Presentation Layer - Main Navigation
//

import SwiftUI

/// Main TabView for app navigation
/// Contains 4 tabs: Patients, Schedule, AI, Settings
struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // Patients Tab
            PatientsListView()
                .tabItem {
                    Label("Пациенты", systemImage: "person.2.fill")
                }
                .tag(0)

            // Schedule Tab
            ScheduleView()
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }
                .tag(1)

            // AI Tab
            AIView()
                .tabItem {
                    Label("AI", systemImage: "brain.head.profile")
                }
                .tag(2)

            // Settings Tab
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                }
                .tag(3)
        }
        .tint(.blue)
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}
