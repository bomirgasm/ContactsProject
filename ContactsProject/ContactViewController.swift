//
//  ContactViewController.swift
//  ContactsProject
//
//  Created by Suzie Kim on 4/22/25.
//

import UIKit

enum ContactMode {
    case add
    case edit(index: Int, contact: Contact)
}

class ContactViewController: UIViewController {

    var mode: ContactMode = .add
    let profileImageView = UIImageView()
    let randomButton = UIButton(type: .system)
    let nameField = UITextField()
    let phoneField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        switch mode {
        case .add:
            title = "연락처 추가"
        case .edit(_, let contact):
            title = contact.name
            nameField.text = contact.name
            phoneField.text = contact.phone
            if let data = contact.imageData {
                profileImageView.image = UIImage(data: data)
            }
        }
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



    @objc func applyContact() {
        guard let name = nameField.text, !name.isEmpty,
              let phone = phoneField.text, !phone.isEmpty else {
            print("이름 또는 전화번호 없음")
            return
        }
        let imageData = profileImageView.image?.pngData()
        let newContact = Contact(name: name, phone: phone, imageData: imageData)
        
        var contacts = ContactStorage.shared.load()

        
        switch mode {
        case .add:
            contacts.append(newContact)
        case .edit(_, let oldContact): // 해당 위치에 수정된 정보로 덮어쓰기
            if let i = contacts.firstIndex(where: { $0.id == oldContact.id }) {
                contacts[i] = newContact
            } else {
                contacts.append(newContact)
            }
        }
        
        ContactStorage.shared.save(contacts)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func fetchRandomImage() {
        let randomID = Int.random(in: 1...1000)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"

        guard let url = URL(string: urlString) else {
            print("잘못된 URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("네트워크 에러: \(error.localizedDescription)")
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let sprites = json["sprites"] as? [String: Any],
                  let imageUrlString = sprites["front_default"] as? String,
                  let imageUrl = URL(string: imageUrlString) else {
                print("JSON 파싱 실패")
                return
            }

            // 이미지 로딩
            URLSession.shared.dataTask(with: imageUrl) { imageData, _, _ in
                guard let imageData = imageData,
                      let image = UIImage(data: imageData) else {
                    print("이미지 로딩 실패")
                    return
                }

                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }.resume()
        }.resume()
    }


}
