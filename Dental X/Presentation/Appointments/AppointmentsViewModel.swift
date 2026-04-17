//
//  AppointmentsViewModel.swift
//  Dental X
//
//  Presentation Layer - Appointments Module
//

import Foundation
import Combine

/// ViewModel for managing appointments
final class AppointmentsViewModel: ObservableObject {
    @Published var appointments: [Appointment] = []

    private let appointmentRepository: AppointmentRepositoryProtocol
    private let patientRepository: PatientRepositoryProtocol
    private let storage: StorageService
    private var cancellables = Set<AnyCancellable>()

    init(
        appointmentRepository: AppointmentRepositoryProtocol = AppointmentRepository(),
        patientRepository: PatientRepositoryProtocol = PatientRepository()
    ) {
        self.appointmentRepository = appointmentRepository
        self.patientRepository = patientRepository
        self.storage = StorageService.shared

        // Observe storage changes to update UI automatically
        storage.$appointments
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadAppointments()
            }
            .store(in: &cancellables)

        loadAppointments()
    }

    // MARK: - Data Loading
    func loadAppointments() {
        appointments = appointmentRepository.getAllAppointments()
    }

    // MARK: - Get Methods
    func getTodayAppointments() -> [Appointment] {
        appointmentRepository.getTodayAppointments()
    }

    func getUpcomingAppointments() -> [Appointment] {
        appointmentRepository.getUpcomingAppointments()
    }

    func getAppointments(for patientId: UUID) -> [Appointment] {
        appointmentRepository.getAppointments(for: patientId)
    }

    func getPatient(for appointment: Appointment) -> Patient? {
        patientRepository.getPatient(by: appointment.patientId)
    }

    func getAllPatients() -> [Patient] {
        patientRepository.getAllPatients()
    }

    // MARK: - CRUD Operations
    func addAppointment(patientId: UUID, date: Date, notes: String) {
        let appointment = Appointment(patientId: patientId, date: date, notes: notes)
        appointmentRepository.addAppointment(appointment)
    }

    func updateAppointment(_ appointment: Appointment) {
        appointmentRepository.updateAppointment(appointment)
    }

    func deleteAppointment(_ appointment: Appointment) {
        appointmentRepository.deleteAppointment(appointment)
    }

    // MARK: - Helper Methods
    func groupedAppointments() -> [(date: String, appointments: [Appointment])] {
        let grouped = Dictionary(grouping: getUpcomingAppointments()) { appointment in
            appointment.dateString
        }

        return grouped.sorted { $0.key < $1.key }.map { (date: $0.key, appointments: $0.value.sorted { $0.date < $1.date }) }
    }
}
