//
//  PatientsListView.swift
//  Dental X
//
//  Presentation Layer - Patients Module
//

import SwiftUI

/// Main view showing list of all patients
struct PatientsListView: View {
    @StateObject private var viewModel = PatientsViewModel()
    @State private var showingAddPatient = false

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.filteredPatients.isEmpty && viewModel.searchText.isEmpty {
                    emptyStateView
                } else {
                    patientsList
                }
            }
            .navigationTitle("Пациенты")
            .searchable(text: $viewModel.searchText, prompt: "Поиск по имени или телефону")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddPatient = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPatient) {
                AddPatientView(viewModel: viewModel)
            }
        }
    }

    // MARK: - Subviews
    private var patientsList: some View {
        List {
            ForEach(viewModel.filteredPatients) { patient in
                NavigationLink(destination: PatientDetailView(patient: patient, viewModel: viewModel)) {
                    PatientRowView(patient: patient)
                }
            }
            .onDelete(perform: viewModel.deletePatients)
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.2.slash")
                .font(.system(size: 70))
                .foregroundStyle(.gray)

            Text("Нет пациентов")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Добавьте первого пациента, нажав на кнопку +")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button {
                showingAddPatient = true
            } label: {
                Text("Добавить пациента")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
    }
}

// MARK: - Patient Row View
struct PatientRowView: View {
    let patient: Patient

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(patient.name)
                .font(.headline)

            Text(patient.phone)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if !patient.note.isEmpty {
                Text(patient.note)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview
#Preview {
    PatientsListView()
}
