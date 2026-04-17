//
//  ScheduleViewModel.swift
//  Dental X
//
//  Presentation Layer - Schedule Module
//

import Foundation
import Combine

/// ViewModel for managing schedule and today's appointments
final class ScheduleViewModel: ObservableObject {
    @Published var todayAppointments: [Appointment] = []
    @Published var upcomingAppointments: [(date: String, appointments: [Appointment])] = []

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
        todayAppointments = appointmentRepository.getTodayAppointments()
        groupUpcomingAppointments()
    }

    private func groupUpcomingAppointments() {
        let upcoming = appointmentRepository.getUpcomingAppointments()

        let grouped = Dictionary(grouping: upcoming) { appointment in
            appointment.dateString
        }

        upcomingAppointments = grouped
            .sorted { $0.key < $1.key }
            .map { (date: $0.key, appointments: $0.value.sorted { $0.date < $1.date }) }
    }

    // MARK: - Helper Methods
    func getPatient(for appointment: Appointment) -> Patient? {
        patientRepository.getPatient(by: appointment.patientId)
    }

    var todayDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: Date())
    }
}
