# **🔍 What is this Project?**

---

### 나혼자만 일일퀘스트 - To-Do App

bit 도트 그래픽 내부 저장 프레임 워크를 사용한 To-Do App
반복 설정한 요일별로 퀘스트가 자정마다 리셋

# **🏆 Challenge**

---

- **CoreData**
1. QuestInfo Model의 저장과 변환 작업을 수행합니다. 
앱이 종료되어도 데이터를 저장하기 위해 필요합니다.
2. CoreData CRUD(Create, Read, Update, Delete) 기능을 구현하여 데이터를 효율적으로 관리합니다.
3. 자정마다 저장된 퀘스트가 재설정되어야하는 요구 사항을 충족시키시 위해, 
매일 자정마다 저장된 퀘스트를 초기화합니다.
- **Network**
1. Back-End 작업을 통해 구축된 서버와의 통신을 위한 네트워크 모듈을 구축합니다. 
클라이언트 앱과 서버 간의 데이터 교환에 용이합니다.
2. JSON Decoding 형태의 DTO(Data Transfer Object)를 구축하여 네트워크에서 전송된 데이터를 클라이언트 앱에서 적절하게 처리할 수 있도록 합니다.
- **AutoLayout**
1. UIKit을 기반으로 한 코드를 통해 AutoLayout을 구현합니다.
이는 다양한 디바이스 크기 및 방향에 대해 유연한 UI를 제공합니다.
2. UI라이브러리를 사용하지 않고 Constraint를 구축하여 UI 요소 간의 관계를 명확하게 정의합니다.
- **Clean Architecture with MVVM-C**
1. MVVM 패턴을 채택하 UI 로직과 비즈니스 로직을 분리하여 유지보수성을 향상시킵니다.
2. Clean Architecture를 적용하기 위해 비즈니스 로직 모듈을 구현하여 의존성을 최소화하고 코드의 재사용성을 높입니다.
3. Coordinator Pattern을 통해 뷰와 화면 전환, 의존성 관리를 분리해 단일 책임 원칙을 준수합니다.

# **📱 UI&UX App Design**

---
![Group 238](https://github.com/jus1234/aloneDailyQuest/assets/130636633/807253b1-d267-497d-ab0a-c83b5985561a)



# **📷 ScreenShot**

---

```swift
GIF 표시
```

# **✅ Checklist**

---

- **CoreData 활용**
CoreData는 Swift에서 제공하는 내부 저장 프레임워크로, 앱이 종료되어도 사용자가 저장한 데이터를 영구적으로 유지시킬 수 있는 기능을 제공합니다. 사용자는 매일 반복할 퀘스트를 설정하고 반복 요일을 지정하여 생성할 수 있습니다. 이러한 퀘스트 데이터는 CoreData에 저장되며, 매일 자정마다 모든 퀘스트는 미완료 상태로 변경됩니다.
CRUD(Create, Read, Update, Delete) 동작은 모두 CoreData를 통해 구현했습니다.
- **Network 활용**
서버와의 통신을 위한 Back-End 작업을 거친 서버와 JSON 형식으로 통신합니다.
이를 통해 서버에 데이터를 저장하거나 업데이트하고, 필요에 따라 데이터를 조회할 수 있습니다.
주로 유저의 닉네임, 경험치 데이터를 통신합니다.
- **AutoLayout 이란?**
제약 조건에 따라 뷰 계층 구조에 있는 모든 뷰의 크기와 위치를 동적으로 지정합니다.
별도의 외부 라이브러리를 사용하지 않고, UIKit에서 제공하는 기능을 활용하여 모든 뷰의 오토레이아웃을 직접 구현했습니다.
- Clean Architecture 란?
추상화 개념을 기반으로 한 아키텍처로, 관심사를 분리하고 의존성을 최소화하는 것이 목표입니다.
각 코드의 종속성은 외부에서 내부로만 가리키도록 제한하여, 고수준 정책이 저수준 정책의 변경에 영향을 받지 않도록 각각의 기능의 모듈화 작업을 통해 구축하였습니다.
- MVVM 적용
    
    ```swift
    폴더링 표시
    ```
    

# **🚨Troubleshooting**

---

- CoreData의 저장 속성
