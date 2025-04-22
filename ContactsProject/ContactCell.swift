//
//  ContactCell.swift
//  ContactsProject
//
//  Created by Suzie Kim on 4/22/25.
//

import UIKit

class ContactCell: UITableViewCell {

    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let phoneLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.clipsToBounds = true

        nameLabel.font = .boldSystemFont(ofSize: 16)
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.textColor = .gray

        [profileImageView, nameLabel, phoneLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),

            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }

    func configure(with contact: Contact) {
        profileImageView.image = contact.image ?? UIImage(systemName: "nil")
        nameLabel.text = contact.name
        phoneLabel.text = contact.phone
    }
}
