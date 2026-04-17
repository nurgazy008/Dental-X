//
//  SettingsView.swift
//  Dental X
//
//  Presentation Layer - Settings Module
//

import SwiftUI

/// Settings view with app preferences
struct SettingsView: View {
    @AppStorage("selectedLanguage") private var selectedLanguage = "Русский"
    @AppStorage("enableNotifications") private var enableNotifications = true
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false

    var body: some View {
        NavigationStack {
            List {
                // Profile Section
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Dental X")
                                .font(.headline)
                            Text("Стоматологическая клиника")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                // General Settings
                Section("Общие настройки") {
                    // Language picker
                    Picker("Язык", selection: $selectedLanguage) {
                        Text("Русский").tag("Русский")
                        Text("Қазақша").tag("Қазақша")
                        Text("English").tag("English")
                    }

                    // Notifications toggle
                    Toggle("Уведомления", isOn: $enableNotifications)

                    // Dark mode toggle (UI only)
                    Toggle("Темная тема", isOn: $darkModeEnabled)
                }

                // App Info
                Section("О приложении") {
                    HStack {
                        Text("Версия")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        Text("Сборка")
                        Spacer()
                        Text("2026.04.17")
                            .foregroundStyle(.secondary)
                    }

                    Link(destination: URL(string: "https://github.com")!) {
                        HStack {
                            Text("GitHub")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                // Data Management
                Section("Данные") {
                    Button {
                        // Export data action (UI only)
                    } label: {
                        Label("Экспорт данных", systemImage: "square.and.arrow.up")
                    }

                    Button {
                        // Import data action (UI only)
                    } label: {
                        Label("Импорт данных", systemImage: "square.and.arrow.down")
                    }

                    Button(role: .destructive) {
                        // Clear data action (UI only)
                    } label: {
                        Label("Очистить все данные", systemImage: "trash")
                    }
                }

                // Support
                Section("Поддержка") {
                    Link(destination: URL(string: "mailto:support@dentalx.kz")!) {
                        Label("Написать в поддержку", systemImage: "envelope")
                    }

                    Button {
                        // Rate app action (UI only)
                    } label: {
                        Label("Оценить приложение", systemImage: "star")
                    }
                }

                // Legal
                Section {
                    NavigationLink {
                        PrivacyPolicyView()
                    } label: {
                        Text("Политика конфиденциальности")
                    }

                    NavigationLink {
                        TermsOfServiceView()
                    } label: {
                        Text("Условия использования")
                    }
                }
            }
            .navigationTitle("Настройки")
        }
    }
}

// MARK: - Privacy Policy View
struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Политика конфиденциальности")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Последнее обновление: 17 апреля 2026")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("""
                Dental X уважает вашу конфиденциальность и стремится защитить ваши персональные данные.

                1. Сбор данных
                Мы собираем только те данные, которые вы предоставляете добровольно при использовании приложения.

                2. Использование данных
                Все данные хранятся локально на вашем устройстве и не передаются третьим лицам.

                3. Безопасность
                Мы используем современные методы шифрования для защиты ваших данных.

                4. Ваши права
                Вы имеете право на доступ, исправление и удаление ваших персональных данных.
                """)
                .font(.body)
            }
            .padding()
        }
        .navigationTitle("Конфиденциальность")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Terms of Service View
struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Условия использования")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Последнее обновление: 17 апреля 2026")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("""
                Используя приложение Dental X, вы соглашаетесь с следующими условиями:

                1. Использование приложения
                Приложение предназначено для управления стоматологической практикой.

                2. Ответственность пользователя
                Вы несете ответственность за точность вводимых данных.

                3. Ограничение ответственности
                Приложение предоставляется "как есть" без каких-либо гарантий.

                4. Изменения условий
                Мы оставляем за собой право изменять эти условия в любое время.
                """)
                .font(.body)
            }
            .padding()
        }
        .navigationTitle("Условия")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
}
