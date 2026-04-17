//
//  AppointmentRepository.swift
//  Dental X
//
//  Data Layer - Repositories
//

import Foundation

/// Protocol defining appointment data operations
protocol AppointmentRepositoryProtocol {
    func getAllAppointments() -> [Appointment]
    func getAppointments(for patientId: UUID) -> [Appointment]
    func getTodayAppointments() -> [Appointment]
    func getUpcomingAppointments() -> [Appointment]
    func addAppointment(_ appointment: Appointment)
    func updateAppointment(_ appointment: Appointment)
    func deleteAppointment(_ appointment: Appointment)
}

/// Repository for appointment data operations
/// Provides abstraction layer between ViewModels and Storage
final class AppointmentRepository: AppointmentRepositoryProtocol {
    private let storage: StorageService

    init(storage: StorageService = .shared) {
        self.storage = storage
    }

    func getAllAppointments() -> [Appointment] {
        storage.appointments.sorted { $0.date < $1.date }
    }

    func getAppointments(for patientId: UUID) -> [Appointment] {
        storage.getAppointments(for: patientId)
    }

    func getTodayAppointments() -> [Appointment] {
        storage.getTodayAppointments()
    }

    func getUpcomingAppointments() -> [Appointment] {
        storage.getUpcomingAppointments()
    }

    func addAppointment(_ appointment: Appointment) {
        storage.addAppointment(appointment)
    }

    func updateAppointment(_ appointment: Appointment) {
        storage.updateAppointment(appointment)
    }

    func deleteAppointment(_ appointment: Appointment) {
        storage.deleteAppointment(appointment)
    }
}
