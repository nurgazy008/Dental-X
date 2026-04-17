//
//  StorageService.swift
//  Dental X
//
//  Data Layer - Services
//

import Foundation

/// StorageService provides in-memory data storage
/// In production, this would use CoreData or a database
final class StorageService: ObservableObject {
    // Singleton instance for shared access
    static let shared = StorageService()

    // Published properties to notify observers of changes
    @Published var patients: [Patient] = []
    @Published var appointments: [Appointment] = []

    private init() {
        // Load sample data for demonstration
        loadSampleData()
    }

    // MARK: - Sample Data
    private func loadSampleData() {
        // Add sample patients
        patients = Patient.samples

        // Add sample appointments
        appointments = Appointment.samples
    }

    // MARK: - Patient Methods
    func addPatient(_ patient: Patient) {
        patients.append(patient)
    }

    func updatePatient(_ patient: Patient) {
        if let index = patients.firstIndex(where: { $0.id == patient.id }) {
            patients[index] = patient
        }
    }

    func deletePatient(_ patient: Patient) {
        patients.removeAll { $0.id == patient.id }
        // Also delete related appointments
        appointments.removeAll { $0.patientId == patient.id }
    }

    func getPatient(by id: UUID) -> Patient? {
        patients.first { $0.id == id }
    }

    // MARK: - Appointment Methods
    func addAppointment(_ appointment: Appointment) {
        appointments.append(appointment)
    }

    func updateAppointment(_ appointment: Appointment) {
        if let index = appointments.firstIndex(where: { $0.id == appointment.id }) {
            appointments[index] = appointment
        }
    }

    func deleteAppointment(_ appointment: Appointment) {
        appointments.removeAll { $0.id == appointment.id }
    }

    func getAppointments(for patientId: UUID) -> [Appointment] {
        appointments.filter { $0.patientId == patientId }
    }

    func getTodayAppointments() -> [Appointment] {
        appointments.filter { $0.isToday }
            .sorted { $0.date < $1.date }
    }

    func getUpcomingAppointments() -> [Appointment] {
        let now = Date()
        return appointments.filter { $0.date >= now }
            .sorted { $0.date < $1.date }
    }
}
