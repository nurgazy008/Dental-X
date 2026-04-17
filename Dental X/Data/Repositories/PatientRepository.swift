//
//  PatientRepository.swift
//  Dental X
//
//  Data Layer - Repositories
//

import Foundation
import Combine

/// Protocol defining patient data operations
protocol PatientRepositoryProtocol {
    func getAllPatients() -> [Patient]
    func getPatient(by id: UUID) -> Patient?
    func addPatient(_ patient: Patient)
    func updatePatient(_ patient: Patient)
    func deletePatient(_ patient: Patient)
}

/// Repository for patient data operations
/// Provides abstraction layer between ViewModels and Storage
final class PatientRepository: PatientRepositoryProtocol {
    private let storage: StorageService

    init(storage: StorageService = .shared) {
        self.storage = storage
    }

    func getAllPatients() -> [Patient] {
        storage.patients.sorted { $0.name < $1.name }
    }

    func getPatient(by id: UUID) -> Patient? {
        storage.getPatient(by: id)
    }

    func addPatient(_ patient: Patient) {
        storage.addPatient(patient)
    }

    func updatePatient(_ patient: Patient) {
        storage.updatePatient(patient)
    }

    func deletePatient(_ patient: Patient) {
        storage.deletePatient(patient)
    }
}
