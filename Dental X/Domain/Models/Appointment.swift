//
//  Appointment.swift
//  Dental X
//
//  Domain Layer - Models
//

import Foundation

/// Appointment model represents a scheduled patient visit
/// Links a patient with a specific date and time
struct Appointment: Identifiable, Codable {
    let id: UUID
    var patientId: UUID
    var date: Date
    var notes: String

    init(id: UUID = UUID(), patientId: UUID, date: Date, notes: String = "") {
        self.id = id
        self.patientId = patientId
        self.date = date
        self.notes = notes
    }
}

// MARK: - Helper Extensions
extension Appointment {
    /// Check if appointment is today
    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }

    /// Get formatted time string (HH:mm)
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    /// Get formatted date string (dd.MM.yyyy)
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

// MARK: - Sample Data for Preview
extension Appointment {
    static let sample = Appointment(
        patientId: Patient.sample.id,
        date: Date()
    )

    static let samples = [
        Appointment(patientId: Patient.samples[0].id, date: Calendar.current.date(byAdding: .hour, value: 1, to: Date())!, notes: "Первичный осмотр"),
        Appointment(patientId: Patient.samples[1].id, date: Calendar.current.date(byAdding: .hour, value: 3, to: Date())!, notes: "Чистка зубов"),
        Appointment(patientId: Patient.samples[2].id, date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, notes: "Консультация ортодонта"),
        Appointment(patientId: Patient.samples[3].id, date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, notes: "Лечение")
    ]
}
