//
//  AIView.swift
//  Dental X
//
//  Presentation Layer - AI Module
//

import SwiftUI

/// Placeholder view for AI diagnosis feature
/// Will be implemented in future releases
struct AIView: View {
    @State private var isAnalyzing = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()

                // AI Icon
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 100))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .symbolEffect(.pulse, isActive: isAnalyzing)

                // Title
                VStack(spacing: 12) {
                    Text("AI Диагностика")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Анализ рентгеновских снимков с помощью искусственного интеллекта")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Feature List
                VStack(alignment: .leading, spacing: 16) {
                    FeatureRow(
                        icon: "camera.fill",
                        title: "Загрузка снимков",
                        description: "Поддержка всех форматов медицинских изображений"
                    )

                    FeatureRow(
                        icon: "wand.and.stars",
                        title: "AI Анализ",
                        description: "Автоматическое обнаружение проблемных зон"
                    )

                    FeatureRow(
                        icon: "doc.text.fill",
                        title: "Отчеты",
                        description: "Подробные результаты диагностики"
                    )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal)

                Spacer()

                // Action Button
                Button {
                    isAnalyzing.toggle()
                } label: {
                    HStack {
                        Image(systemName: "camera.metering.spot")
                        Text(isAnalyzing ? "Анализ..." : "Анализировать рентген")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAnalyzing ? Color.gray : Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                }
                .disabled(isAnalyzing)
                .padding(.horizontal)

                // Coming Soon Badge
                Text("Скоро доступно")
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange.opacity(0.2))
                    .foregroundStyle(.orange)
                    .cornerRadius(20)

                Spacer()
            }
            .navigationTitle("AI Диагностика")
        }
    }
}

// MARK: - Feature Row View
struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    AIView()
}
