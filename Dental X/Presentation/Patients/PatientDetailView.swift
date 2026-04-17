//
//  PatientDetailView.swift
//  Dental X
//
//  Presentation Layer - Patients Module
//

import SwiftUI

/// Detailed view of a single patient with their appointments
struct PatientDetailView: View {
    let patient: Patient
    @ObservedObject var viewModel: PatientsViewModel

    @StateObject private var appointmentsViewModel = AppointmentsViewModel()
    @State private var showingEditSheet = false
    @State private var showingAddAppointment = false
    @State private var showingDeleteAlert = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            // Patient Information Section
            Section("Информация о пациенте") {
                InfoRow(title: "Имя", value: patient.name)
                InfoRow(title: "Телефон", value: patient.phone)

                if !patient.note.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Заметки")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(patient.note)
                            .font(.body)
                    }
                    .padding(.vertical, 4)
                }
            }

            // Appointments Section
            Section {
                if patientAppointments.isEmpty {
                    Text("Нет записей")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    ForEach(patientAppointments) { appointment in
                        AppointmentRowView(
                            appointment: appointment,
                            patient: patient
                        )
                    }
                }
            } header: {
                HStack {
                    Text("Записи")
                    Spacer()
                    Button {
                        showingAddAppointment = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
        .navigationTitle("Пациент")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button {
                        showingEditSheet = true
                    } label: {
                        Label("Редактировать", systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        showingDeleteAlert = true
                    } label: {
                        Label("Удалить", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditPatientView(patient: patient, viewModel: viewModel)
        }
        .sheet(isPresented: $showingAddAppointment) {
            AddAppointmentView(
                viewModel: appointmentsViewModel,
                preselectedPatient: patient
            )
        }
        .alert("Удалить пациента?", isPresented: $showingDeleteAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Удалить", role: .destructive) {
                viewModel.deletePatient(patient)
                dismiss()
            }
        } message: {
            Text("Это действие нельзя отменить. Все записи пациента также будут удалены.")
        }
    }

    // MARK: - Computed Properties
    private var patientAppointments: [Appointment] {
        appointmentsViewModel.getAppointments(for: patient.id)
            .sorted { $0.date > $1.date }
    }
}

// MARK: - Info Row View
struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Appointment Row View
struct AppointmentRowView: View {
    let appointment: Appointment
    let patient: Patient

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(appointment.dateString)
                    .font(.headline)
                Text(appointment.timeString)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if !appointment.notes.isEmpty {
                Text(appointment.notes)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Edit Patient View
struct EditPatientView: View {
    @Environment(\.dismiss) private var dismiss
    let patient: Patient
    @ObservedObject var viewModel: PatientsViewModel

    @State private var name: String
    @State private var phone: String
    @State private var note: String

    init(patient: Patient, viewModel: PatientsViewModel) {
        self.patient = patient
        self.viewModel = viewModel
        _name = State(initialValue: patient.name)
        _phone = State(initialValue: patient.phone)
        _note = State(initialValue: patient.note)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Основная информация") {
                    TextField("Имя пациента", text: $name)
                    TextField("Телефон", text: $phone)
                        .keyboardType(.phonePad)
                }

                Section("Дополнительно") {
                    TextField("Заметки", text: $note, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Редактировать")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        saveChanges()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }

    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func saveChanges() {
        var updatedPatient = patient
        updatedPatient.name = name.trimmingCharacters(in: .whitespaces)
        updatedPatient.phone = phone.trimmingCharacters(in: .whitespaces)
        updatedPatient.note = note.trimmingCharacters(in: .whitespaces)
        viewModel.updatePatient(updatedPatient)
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PatientDetailView(patient: .sample, viewModel: PatientsViewModel())
    }
}
