//
//  AddPatientView.swift
//  Dental X
//
//  Presentation Layer - Patients Module
//

import SwiftUI

/// View for adding a new patient
struct AddPatientView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PatientsViewModel

    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var note: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Основная информация") {
                    TextField("Имя пациента", text: $name)
                        .textContentType(.name)

                    TextField("Телефон", text: $phone)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                }

                Section("Дополнительно") {
                    TextField("Заметки", text: $note, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Новый пациент")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        savePatient()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }

    // MARK: - Validation
    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - Actions
    private func savePatient() {
        viewModel.addPatient(
            name: name.trimmingCharacters(in: .whitespaces),
            phone: phone.trimmingCharacters(in: .whitespaces),
            note: note.trimmingCharacters(in: .whitespaces)
        )
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    AddPatientView(viewModel: PatientsViewModel())
}
