//
//  MainViewController.swift
//  ContactsProject
//
//  Created by Suzie Kim on 4/22/25.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // UITableView 선언
    let tableView = UITableView()

    // 더미 데이터 (임시 연락처 배열)
    var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(applyContact))
        title = "연락처 추가" // 추후 편집모드면 이름으로 대체

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contacts = ContactStorage.shared.load()
        contacts.sort {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
        tableView.reloadData()
    }

    func setupUI() {
        view.backgroundColor = .white
        title = "포켓몬 연락처"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))

        // 테이블뷰 설정
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.rowHeight = 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }

        let contact = contacts[indexPath.row]
        cell.profileImageView.image = contact.imageData != nil ?
            UIImage(data: contact.imageData!) :
            UIImage(systemName: "nil")
        cell.nameLabel.text = contact.name
        cell.phoneLabel.text = contact.phone
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        let vc = ContactViewController()
        vc.mode = .edit(index: indexPath.row, contact: contact)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func addContact() {
        let vc = ContactViewController()
        vc.mode = .add
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func applyContact() {
        print("적용 버튼 눌림")
    }

}
