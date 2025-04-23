//
//  ContactStorage.swift
//  ContactsProject
//
//  Created by Suzie Kim on 4/22/25.
//

import Foundation

class ContactStorage {
    static let shared = ContactStorage()
    private let key = "contacts"

    func save(_ contacts: [Contact]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(contacts) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func load() -> [Contact] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Contact].self, from: data) else {
            return []
        }
        return decoded
    }
}
