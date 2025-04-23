# ContactsProject
---

# iOS 연락처 앱 (ContactsProject)

# 프로젝트 개요

UIKit과 Swift를 활용하여 연락처를 생성하고 관리할 수 있는 iOS 앱을 구현했습니다.  
사용자는 이름, 전화번호를 입력하고, 포켓몬 API를 통해 무작위 이미지를 불러와 프로필로 설정할 수 있습니다.  
연락처는 기기 내 UserDefaults에 저장되며, 앱을 껐다 켜도 정보가 유지됩니다.

---

# 기능 요약

- 연락처 추가 및 수정
- 랜덤 포켓몬 이미지 적용
- 이름순 자동 정렬
- UserDefaults 기반 데이터 저장
- TableView로 목록 표시
- 연락처 수정 시 기존 정보 불러오기

---

# 구현 단계 (Lv1 ~ Lv8)

 Lv1: 테이블뷰와 셀 UI 구성
 Lv2: 연락처 추가 화면 구현
 Lv3: 네비게이션 바 구성 (`적용` 버튼)
 Lv4: 포켓몬 API 연결 및 이미지 설정
 Lv5: 연락처 저장 (UserDefaults)
 Lv6: 이름순 정렬 기능
 Lv7: 연락처 수정 화면 진입
 Lv8: 수정 내용 업데이트 적용

---

# 사용 기술

- 언어: Swift 5.9
- 개발 환경: Xcode (UIKit / 코드베이스 UI)
- 저장 방식: Codable + UserDefaults
- 네트워크: URLSession
- API: https://pokeapi.co
- UI 구성: AutoLayout + StackView

---

# 프로젝트 구조

```
ContactsProject/
├── Contact.swift                 // 연락처 데이터 모델
├── ContactCell.swift             // 커스텀 셀 (UITableViewCell)
├── MainViewController.swift      // 연락처 목록 화면
├── ContactViewController.swift   // 연락처 추가/편집 화면
├── ContactStorage.swift          // UserDefaults 기반 저장소
│
├── AppDelegate.swift             // 앱 라이프사이클 관리
├── SceneDelegate.swift           // 씬 라이프사이클 관리
│
├── Assets.xcassets               // 이미지 및 색상 리소스
├── LaunchScreen.storyboard       // 런치스크린 설정
└── Info.plist                    // 앱 설정 정보
                    // 프로젝트 설명 문서
```

---

# 기능 상세 설명

### 1. 연락처 목록 및 셀 UI 구성 (Lv1)

- 테이블뷰로 이름, 전화번호, 이미지가 보이도록 구성
- `ContactCell`에서 이미지 원형 처리, 폰트 및 색상 지정
- 셀 높이는 80으로 고정

### 2. 연락처 추가 화면 구현 (Lv2~Lv3)

- 스택뷰를 이용해 이미지, 버튼, 텍스트필드 정렬
- 네비게이션 바의 `적용` 버튼으로 저장 동작 연결
- 연락처 추가 시 입력값이 없을 경우 예외 처리

### 3. 랜덤 이미지 로딩 기능 (Lv4)

```swift
let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomID)")
URLSession을 사용해 이미지 URL 요청 → 이미지 데이터 → UIImageView에 적용
```

- JSON 파싱을 통해 `sprites.front_default` 경로에서 이미지 URL 추출

### 4. 저장 및 수정 기능 구현 (Lv5~Lv8)

```swift
// 저장
contacts.append(newContact)
ContactStorage.shared.save(contacts)

// 수정
if let i = contacts.firstIndex(where: { $0.id == oldContact.id }) {
    contacts[i] = updatedContact
}
```

- `Contact`에 UUID를 포함시켜, 정렬 후에도 정확히 수정 대상 판별 가능
- `enum ContactMode`로 .add / .edit 모드 분기 처리

### 5. 이름순 정렬 및 자동 갱신 (Lv6)

- `viewWillAppear`에서 데이터 로드 후 `localizedCaseInsensitiveCompare`로 정렬
- 테이블뷰 reload 처리

---

# 예외 처리 및 개선 포인트

- 이름/전화번호가 비어있을 경우 저장되지 않도록 예외처리 적용
- 포켓몬 이미지가 로드되지 않을 경우 기본 시스템 이미지 사용
- 연락처 삭제 기능은 향후 추가 예정

---

# 실행 방법

1. Xcode에서 프로젝트 열기
2. 시뮬레이터 또는 실제 기기에서 실행
3. 연락처 추가 → 프로필 이미지 랜덤 적용 → 저장 및 수정 확인
