//
//  Contacts.swift
//  ContactsProject
//
//  Created by Suzie Kim on 4/22/25.
//

import UIKit

struct Contact: Codable {
    var id: UUID
    var name: String
    var phone: String
    var imageData: Data?
    
    init(name: String, phone: String, imageData: Data?) {
        self.id = UUID()
        self.name = name
        self.phone = phone
        self.imageData = imageData
    }
}
