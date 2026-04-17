//
//  ScheduleView.swift
//  Dental X
//
//  Presentation Layer - Schedule Module
//

import SwiftUI

/// View showing today's schedule and upcoming appointments
struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @StateObject private var appointmentsViewModel = AppointmentsViewModel()
    @State private var showingAddAppointment = false

    var body: some View {
        NavigationStack {
            List {
                // Today Section
                Section {
                    if viewModel.todayAppointments.isEmpty {
                        emptyTodayView
                    } else {
                        ForEach(viewModel.todayAppointments) { appointment in
                            ScheduleAppointmentRow(
                                appointment: appointment,
                                viewModel: viewModel
                            )
                        }
                    }
                } header: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Сегодня")
                            .font(.headline)
                        Text(viewModel.todayDateString)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                // Upcoming Appointments Section
                if !viewModel.upcomingAppointments.isEmpty {
                    Section("Предстоящие записи") {
                        ForEach(viewModel.upcomingAppointments, id: \.date) { group in
                            Section(group.date) {
                                ForEach(group.appointments) { appointment in
                                    ScheduleAppointmentRow(
                                        appointment: appointment,
                                        viewModel: viewModel
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Расписание")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddAppointment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddAppointment) {
                AddAppointmentView(viewModel: appointmentsViewModel)
            }
            .refreshable {
                viewModel.loadAppointments()
            }
        }
    }

    // MARK: - Subviews
    private var emptyTodayView: some View {
        HStack {
            Image(systemName: "calendar.badge.clock")
                .foregroundStyle(.secondary)
            Text("Нет записей на сегодня")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }
}

// MARK: - Schedule Appointment Row
struct ScheduleAppointmentRow: View {
    let appointment: Appointment
    let viewModel: ScheduleViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // Time badge
                Text(appointment.timeString)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .foregroundStyle(.blue)
                    .cornerRadius(6)

                Spacer()

                // Today indicator
                if appointment.isToday {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                }
            }

            // Patient name
            if let patient = viewModel.getPatient(for: appointment) {
                Text(patient.name)
                    .font(.headline)

                Text(patient.phone)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Notes
            if !appointment.notes.isEmpty {
                Text(appointment.notes)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview
#Preview {
    ScheduleView()
}
