# 나 혼자만 일일퀘스트
> 일일 퀘스트를 달성해 레벨을 올릴 수 있는 도트 그래픽 게임 형태의 To-Do 앱

## 프로젝트 소개

### 주요 기능
<table>
  <table>
  <tr>
    <tr>
    <th>퀘스트 확인</th>
    <th>퀘스트 등록</th>
    <th>랭킹</th>
    <th>프로필</th>
  </tr>
    <td>
      <img src="https://github.com/jus1234/aloneDailyQuest/assets/47639904/c5e7ff1b-07dc-471e-8797-14c53315fbb4" width="200" heig0ht="400" >
    </td>
    <td>
      <img src="https://github.com/jus1234/aloneDailyQuest/assets/47639904/a9bb0d68-908b-47a4-8a6b-4d155ca99a51" width="200" height="400">
    </td>
    <td>
      <img src="https://github.com/jus1234/aloneDailyQuest/assets/47639904/2b209695-2547-4535-9ebf-b753cd76d7ff" width="200" height="400">
    </td>
    <td>
      <img src="https://github.com/jus1234/aloneDailyQuest/assets/47639904/ad6ba6c1-9d63-42fb-abfd-071fe658b1c7" width="200" height="400">
    </td>
  </tr>
</table>


- **요일 별 퀘스트 등록**
    
    반복이 필요한 요일 별로 퀘스트를 등록할 수 있습니다.
    
- **경험치 획득**
    
    퀘스트 완료를 통해 경험치를 획득하고 순위를 올릴 수 있습니다.


### 팀원 소개(iOS Developers)
| 장우석([sidi](https://github.com/jus1234)) | 김병수([Metthew](https://github.com/kimbs5899)) | 오정석([Ben](https://github.com/jungseok-corine)) |
| --- | --- | --- |
| ![47639904](https://github.com/jus1234/aloneDailyQuest/assets/47639904/c5c3a342-15db-4250-8623-6b4a2c5539cf) | ![130636633](https://github.com/jus1234/aloneDailyQuest/assets/47639904/4df0f420-5b55-4332-bb35-b69f1ce7f1ae) | ![84053571](https://github.com/jus1234/aloneDailyQuest/assets/47639904/8cd8f1ae-8dd4-4c11-9c7e-6585c66359e6) |

### 개발환경 및 도구
| 개발언어 및 환경 | 협업도구 |
| --- | --- |
| Swift | Notion |
| UIKit | Github  |
| Xcode 17.0 | Discord |
|   |  Figma | 

### 프로젝트 구조

App Architecture: Clean Architecture with MVVM-C
<img width="700" alt="스크린샷 2024-05-22 오후 3 59 40" src="https://github.com/jus1234/aloneDailyQuest/assets/47639904/4ebd7a0d-8ebf-424e-901a-cccc4414f967">



## 프로젝트 중 학습 내용

- **CoreData 활용**
1. QuestInfo Model의 저장과 변환 작업을 수행합니다. 
앱이 종료되어도 데이터를 저장하기 위해 필요합니다.
2. CoreData CRUD(Create, Read, Update, Delete) 기능을 구현하여 데이터를 효율적으로 관리합니다.
- **Network 통신**
1. Back-End서버와의 통신을 위한 네트워크 모듈을 구축합니다. 
2. 디자인 패턴(`Builder Pattern`)을 적용해 모든 형태의 HTTP 통신을 지원할 수 있는 네트워크 모델을 구축합니다.
- **AutoLayout**
1. UIKit을 기반으로 한 코드를 통해 AutoLayout을 구현합니다.
이는 다양한 디바이스 크기 및 방향에 대해 유연한 UI를 제공합니다.
2. UI라이브러리를 사용하지 않고 Constraint를 구축하여 UI 요소 간의 관계를 명확하게 정의합니다.
- **Clean Architecture with MVVM-C**
1. MVVM 패턴을 채택하 UI 로직과 비즈니스 로직을 분리하여 유지보수성을 향상시킵니다.
2. Clean Architecture를 적용하기 위해 비즈니스 로직 모듈을 구현하여 의존성을 최소화하고 코드의 재사용성을 높입니다.
3. Coordinator Pattern을 통해 뷰와 화면 전환, 의존성 관리를 분리해 단일 책임 원칙을 준수합니다.
    

### 트러블 슈팅
- **아이디 중복체크 에러**
  네트워크 415 에러
        
    해결: `post` 요청을 보낼 때 `json` 형태로 데이터를 전송하는 경우 `header`에서 `Content-Type`을 `application/json`으로 지정해 줘야함
    
    Before
    
    ```swift
    URLRequestBuilder(baseURL: API.baseURL)
      .setMethod(.post)
      .setPath("/check_id")
      .setBodyParameters(userId)
      .build()
    ```
    
    After
    
    ```swift
    let header = ["Content-Type": "application/json"]
    URLRequestBuilder(baseURL: API.baseURL)
      .setMethod(.post)
      .setHeaderParameters(header)
      .setPath("/check_id")
      .setBodyParameters(userId)
      .build()
    ```

- **코디네이터 화면 전환 중 Thread 에러**
    
    <img width="635" alt="스크린샷 2024-05-21 오전 12 42 45" src="https://github.com/jus1234/aloneDailyQuest/assets/47639904/0ad009f0-3b2e-48a2-9bfb-6561c8644726">

    ui작업인 `popToRootViewController`가 `background thread`에서 실행되는 현상
    
    해결
    
    `didFinish`를 실행하는 `DetailViewModel`을 `@MainActor`로 지정
