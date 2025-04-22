//
//  ContactViewController.swift
//  ContactsProject
//
//  Created by Suzie Kim on 4/22/25.
//

import UIKit

class ContactViewController: UIViewController {

    let profileImageView = UIImageView()
    let randomButton = UIButton(type: .system)
    let nameField = UITextField()
    let phoneField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(applyContact))

        // 프로필 이미지뷰
        profileImageView.image = UIImage(systemName: "nil")
        profileImageView.tintColor = .lightGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 100
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.clipsToBounds = true

        // 랜덤 버튼
        randomButton.setTitle("랜덤 이미지", for: .normal)
        randomButton.addTarget(self, action: #selector(fetchRandomImage), for: .touchUpInside)

        // 텍스트필드
        nameField.placeholder = "이름"
        phoneField.placeholder = "전화번호"
        [nameField, phoneField].forEach {
            $0.borderStyle = .roundedRect
        }

        // AutoLayout 설정
        let stack = UIStackView(arrangedSubviews: [profileImageView, randomButton, nameField, phoneField])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        view.addSubview(stack)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            nameField.widthAnchor.constraint(equalToConstant: 350),
            phoneField.widthAnchor.constraint(equalToConstant: 350),
            

            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    @objc func fetchRandomImage() {
        print("랜덤 이미지 버튼 눌림")
    }

    @objc func applyContact() {
        print("적용 버튼 눌림")
    }

}
