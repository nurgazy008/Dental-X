//
//  AddAppointmentView.swift
//  Dental X
//
//  Presentation Layer - Appointments Module
//

import SwiftUI

/// View for creating a new appointment
struct AddAppointmentView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AppointmentsViewModel

    @State private var selectedPatient: Patient?
    @State private var selectedDate: Date = Date()
    @State private var notes: String = ""

    let preselectedPatient: Patient?

    init(viewModel: AppointmentsViewModel, preselectedPatient: Patient? = nil) {
        self.viewModel = viewModel
        self.preselectedPatient = preselectedPatient
        _selectedPatient = State(initialValue: preselectedPatient)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Пациент") {
                    Picker("Выберите пациента", selection: $selectedPatient) {
                        Text("Не выбран").tag(nil as Patient?)
                        ForEach(viewModel.getAllPatients()) { patient in
                            Text(patient.name).tag(patient as Patient?)
                        }
                    }
                    .disabled(preselectedPatient != nil)
                }

                Section("Дата и время") {
                    DatePicker(
                        "Дата и время",
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }

                Section("Заметки") {
                    TextField("Причина визита", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Новая запись")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        saveAppointment()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }

    // MARK: - Validation
    private var isFormValid: Bool {
        selectedPatient != nil
    }

    // MARK: - Actions
    private func saveAppointment() {
        guard let patient = selectedPatient else { return }

        viewModel.addAppointment(
            patientId: patient.id,
            date: selectedDate,
            notes: notes.trimmingCharacters(in: .whitespaces)
        )
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    AddAppointmentView(viewModel: AppointmentsViewModel())
}
