//
//  Patient.swift
//  Dental X
//
//  Domain Layer - Models
//

import Foundation

/// Patient model represents a dental clinic patient
/// Contains basic information: name, contact, notes
struct Patient: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var phone: String
    var note: String
    var createdDate: Date

    init(id: UUID = UUID(), name: String, phone: String, note: String = "", createdDate: Date = Date()) {
        self.id = id
        self.name = name
        self.phone = phone
        self.note = note
        self.createdDate = createdDate
    }
}

// MARK: - Sample Data for Preview
extension Patient {
    static let sample = Patient(
        name: "Айгерім Нұрланқызы",
        phone: "+7 777 123 4567",
        note: "Регулярный клиент, аллергия на анестезию"
    )

    static let samples = [
        Patient(name: "Айгерім Нұрланқызы", phone: "+7 777 123 4567", note: "Аллергия на анестезию"),
        Patient(name: "Асет Ерланұлы", phone: "+7 701 234 5678", note: "Требуется чистка"),
        Patient(name: "Мадина Сәкенқызы", phone: "+7 702 345 6789", note: "Установка брекетов"),
        Patient(name: "Данияр Болатұлы", phone: "+7 775 456 7890", note: "Лечение кариеса")
    ]
}
