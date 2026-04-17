//
//  PatientsViewModel.swift
//  Dental X
//
//  Presentation Layer - Patients Module
//

import Foundation
import Combine

/// ViewModel for managing patients list and operations
final class PatientsViewModel: ObservableObject {
    // Published properties that trigger UI updates
    @Published var patients: [Patient] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let patientRepository: PatientRepositoryProtocol
    private let storage: StorageService
    private var cancellables = Set<AnyCancellable>()

    init(patientRepository: PatientRepositoryProtocol = PatientRepository()) {
        self.patientRepository = patientRepository
        self.storage = StorageService.shared

        // Observe storage changes to update UI automatically
        storage.$patients
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadPatients()
            }
            .store(in: &cancellables)

        loadPatients()
    }

    // MARK: - Data Loading
    func loadPatients() {
        patients = patientRepository.getAllPatients()
    }

    // MARK: - Computed Properties
    var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return patients
        }
        return patients.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.phone.contains(searchText)
        }
    }

    // MARK: - CRUD Operations
    func addPatient(name: String, phone: String, note: String) {
        let patient = Patient(name: name, phone: phone, note: note)
        patientRepository.addPatient(patient)
    }

    func updatePatient(_ patient: Patient) {
        patientRepository.updatePatient(patient)
    }

    func deletePatient(_ patient: Patient) {
        patientRepository.deletePatient(patient)
    }

    func deletePatients(at offsets: IndexSet) {
        offsets.forEach { index in
            let patient = filteredPatients[index]
            deletePatient(patient)
        }
    }
}
