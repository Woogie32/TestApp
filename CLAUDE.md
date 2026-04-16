# CLAUDE.md

이 파일은 Claude Code가 이 저장소에서 작업할 때 참고하는 프로젝트 가이드입니다.
(모든 설명은 한국어로 작성하며, 새 규칙이 생기면 이 파일에 추가합니다.)

---

## 📱 프로젝트 개요

- **이름**: ToDoList
- **종류**: SwiftUI 기반 iOS 앱 (학습용 Todo 앱)
- **플랫폼**: iOS
- **언어/프레임워크**: Swift, SwiftUI
- **목적**: Claude Code 사용법을 익히며 간단한 Todo 앱을 단계적으로 완성

---

## 🏗️ 프로젝트 구조

Clean Architecture 3계층(Domain / Data / Presentation)으로 폴더를 분리합니다.

```
ToDoList/
├── ToDoList/
│   ├── ToDoListApp.swift            # @main 진입점, 의존성 주입 조립
│   ├── Assets.xcassets              # 이미지/색상 리소스
│   │
│   ├── Domain/                      # 🟡 순수 비즈니스 로직 (의존성 없음)
│   │   ├── Entities/                # 도메인 모델 (struct)
│   │   │   └── Todo.swift
│   │   ├── Repositories/            # 저장소 프로토콜(인터페이스)
│   │   │   └── TodoRepository.swift
│   │   └── UseCases/                # 유스케이스 (한 가지 행동)
│   │       ├── FetchTodosUseCase.swift
│   │       ├── AddTodoUseCase.swift
│   │       ├── ToggleTodoUseCase.swift
│   │       └── DeleteTodoUseCase.swift
│   │
│   ├── Data/                        # 🔵 데이터 소스 구현 (Domain에 의존)
│   │   ├── Repositories/            # Repository 프로토콜 구현
│   │   │   └── TodoRepositoryImpl.swift
│   │   ├── DataSources/             # 실제 저장소 (SwiftData, API 등)
│   │   │   └── LocalTodoDataSource.swift
│   │   └── DTOs/                    # 영속화/네트워크용 모델
│   │       └── TodoDTO.swift
│   │
│   └── Presentation/                # 🟢 UI (Domain에 의존)
│       ├── Views/                   # SwiftUI View
│       │   ├── ContentView.swift
│       │   └── TodoRowView.swift
│       └── ViewModels/              # @Observable ViewModel
│           └── TodoListViewModel.swift
│
├── ToDoListTests/                   # 단위 테스트 (Swift Testing)
│   └── ToDoListTests.swift
├── ToDoListUITests/                 # UI 테스트 (XCTest)
│   ├── ToDoListUITests.swift
│   └── ToDoListUITestsLaunchTests.swift
└── ToDoList.xcodeproj
```

---

## 🖼️ 디자인 참고 자료

UI 작업 시 참고할 시안/스크린샷은 [docs/design/](docs/design/) 에 화면별로 정리되어 있습니다.

- 화면별 폴더: `docs/design/<screen-name>/` (예: `todo-list/`, `add-todo/`)
- 공통 요소(색상/아이콘 등): `docs/design/common/`
- **UI 관련 작업을 시작할 때 해당 화면 폴더를 먼저 확인할 것.**
- 자세한 규칙은 [docs/design/README.md](docs/design/README.md) 참고.

> ⚠️ 앱에 실제로 표시되는 이미지는 `ToDoList/Assets.xcassets` 에 추가하며, `docs/design/` 은 순수 참고용입니다.

---

## 🔨 빌드 & 테스트

**반드시 MCP 도구를 사용할 것.** `xcodebuild` 를 Bash로 직접 호출하지 않습니다.

| 작업 | 사용할 MCP 도구 |
|---|---|
| 빌드 | `BuildProject` |
| 전체 테스트 | `RunAllTests` |
| 일부 테스트 | `RunSomeTests` |

### 테스트 프레임워크
- **단위 테스트** (`TestAppTests`): **Swift Testing** 사용
  - `import Testing`, `@Test`, `#expect(...)` 문법
  - XCTest 문법(`XCTAssertEqual` 등) 사용 금지
- **UI 테스트** (`TestAppUITests`): **XCTest** 기반 (Apple 기본 템플릿)

---

## 💻 코딩 컨벤션

### Swift / SwiftUI 규칙
- **Force unwrap 금지** (`!`) — `if let`, `guard let`, `??` 를 사용
  - 이유: 런타임 크래시의 주요 원인
- **네이밍**: Swift API Design Guidelines 준수 (타입 `UpperCamelCase`, 변수/함수 `lowerCamelCase`)
- **들여쓰기**: 4칸 스페이스 (Xcode 기본값)
- **상태 관리**: 작은 범위는 `@State`, 여러 뷰 공유는 `@Observable` (iOS 17+) 또는 `@StateObject`
- **비즈니스 로직은 View에 섞지 말 것** — 별도 모델/ViewModel로 분리

### 일반 원칙
- 주석은 **왜(why)** 가 명확하지 않을 때만 작성 (무엇(what)을 설명하는 주석은 불필요)
- 새 파일을 만들기 전에 기존 파일에 추가할 수 있는지 먼저 검토
- 샘플/더미 데이터가 필요하면 `#Preview` 안에서만 사용

---

## 🚫 하지 말아야 할 것

- `print()` 남발 금지 — 디버깅은 `Logger` 또는 Xcode 디버거 사용
- 미사용 import/변수 남기지 말 것
- 테스트 없이 기능을 추가하지 말 것 (최소한 단위 테스트 하나)
- `main` 브랜치에 바로 커밋하지 말 것 — 기능 단위로 커밋 메시지를 명확히
- 커밋은 사용자가 명시적으로 요청할 때만 수행

---

## 🧩 작업 워크플로우 (Claude가 따라야 할 순서)

1. **요청 이해** → 불명확하면 먼저 질문
2. **계획 공유** → 복잡한 변경이면 Plan 모드로 먼저 제안
3. **작은 단위로 구현** → 한 번에 하나의 기능/파일
4. **빌드 확인** → `BuildProject` 로 빌드 성공 확인
5. **테스트 작성/실행** → 새 로직엔 테스트 추가
6. **결과 요약** → 변경 사항을 간단히 보고
7. **커밋 여부 확인** → 사용자 승인 후에만 커밋

---

## 🏛️ 아키텍처 (MVVM + Clean Architecture)

### 핵심 원칙: 의존성 규칙
**의존성은 안쪽(Domain)으로만 향한다.**

```
Presentation  ──→  Domain  ←──  Data
   (View/VM)      (순수)      (저장소 구현)
```

- **Domain** 은 어떤 계층도 모른다 (SwiftUI, SwiftData, Foundation 최소 사용)
- **Data** 와 **Presentation** 은 Domain 을 import 해도 됨
- **Data ↔ Presentation** 은 **서로 몰라야 함** (절대 금지)

### 각 계층의 역할

#### 🟡 Domain (비즈니스 규칙의 심장)
- **Entities**: 앱의 핵심 모델. 순수 Swift `struct`. `import SwiftUI`/`import SwiftData` **금지**.
  ```swift
  struct Todo: Identifiable, Equatable {
      let id: UUID
      var title: String
      var isCompleted: Bool
      let createdAt: Date
  }
  ```
- **Repositories (프로토콜)**: 데이터 접근 인터페이스만 정의. 구현은 Data 계층에서.
  ```swift
  protocol TodoRepository {
      func fetchAll() async throws -> [Todo]
      func add(_ todo: Todo) async throws
      func update(_ todo: Todo) async throws
      func delete(id: UUID) async throws
  }
  ```
- **UseCases**: 하나의 유스케이스 = 하나의 `struct` + `execute()` 메서드.
  - 유스케이스는 Repository 프로토콜에만 의존 (구체 구현 몰라야 함)
  - 규칙: 한 유스케이스는 한 가지 행동만 수행

#### 🔵 Data (외부 세계와의 다리)
- **Repository 구현**: Domain의 프로토콜을 실제로 구현
- **DataSources**: SwiftData/UserDefaults/네트워크 등 실제 저장소 조작
- **DTOs**: 저장소/API 전용 모델. `Entity ↔ DTO` 변환은 Data 계층 내부에서만 처리
- Domain으로 넘겨줄 땐 **반드시 Entity 로 변환해서** 넘긴다

#### 🟢 Presentation (MVVM)
- **View**: SwiftUI View. **로직 없음** — 상태 표시와 이벤트 전달만.
  - `@State`, `@Binding` 은 UI 전용 상태(텍스트필드 입력 등)만 사용
  - 비즈니스 상태는 **반드시 ViewModel** 에서 관리
- **ViewModel**: `@Observable` 클래스. UseCase를 주입받아 호출, 결과를 `@Observable` 프로퍼티로 노출.
  ```swift
  @Observable
  final class TodoListViewModel {
      private(set) var todos: [Todo] = []
      private(set) var errorMessage: String?

      private let fetchTodos: FetchTodosUseCase
      private let addTodo: AddTodoUseCase

      init(fetchTodos: FetchTodosUseCase, addTodo: AddTodoUseCase) {
          self.fetchTodos = fetchTodos
          self.addTodo = addTodo
      }

      func load() async { /* ... */ }
      func add(title: String) async { /* ... */ }
  }
  ```
- **절대 금지**: ViewModel 에서 `import SwiftUI` (단, `@Observable` 매크로를 위한 `Observation` 은 OK)

### 의존성 주입 (DI)
- **조립 위치**: `TestAppApp.swift` 에서 최상위로 조립
- ViewModel / UseCase / Repository 는 **생성자 주입**(Constructor Injection) 만 사용
- 전역 싱글톤(`TodoRepository.shared`) **금지** — 테스트 어려워짐
- 조립 예시:
  ```swift
  @main
  struct TestAppApp: App {
      var body: some Scene {
          WindowGroup {
              let dataSource = LocalTodoDataSource()
              let repository = TodoRepositoryImpl(dataSource: dataSource)
              let viewModel = TodoListViewModel(
                  fetchTodos: FetchTodosUseCase(repository: repository),
                  addTodo: AddTodoUseCase(repository: repository)
              )
              ContentView(viewModel: viewModel)
          }
      }
  }
  ```

### 네이밍 규칙
| 계층 | 접미사 | 예시 |
|---|---|---|
| UseCase | `UseCase` | `AddTodoUseCase` |
| Repository 프로토콜 | `Repository` | `TodoRepository` |
| Repository 구현 | `RepositoryImpl` | `TodoRepositoryImpl` |
| DataSource | `DataSource` | `LocalTodoDataSource` |
| ViewModel | `ViewModel` | `TodoListViewModel` |
| DTO | `DTO` | `TodoDTO` |

### 테스트 전략
- **Domain (UseCase)**: 가짜 Repository(`MockTodoRepository`)로 단위 테스트 → **가장 중요**
- **Data (Repository 구현)**: 실제 저장소 연결 통합 테스트
- **Presentation (ViewModel)**: 가짜 UseCase 주입하여 상태 변화 검증
- View 자체는 단위 테스트 대상이 아님 (스냅샷/UI 테스트로 대체)

> 💡 UI 디자인 규칙(색상/폰트/간격/컴포넌트/다크모드/접근성)은 [ToDoList/Presentation/CLAUDE.md](ToDoList/Presentation/CLAUDE.md) 참고.

---

## 📚 도메인 용어

| 용어 | 의미 |
|---|---|
| **Todo** | 사용자가 추가/완료/삭제하는 할 일 항목 |
| **Task** | Swift concurrency의 `Task` 와 혼동되므로, 할 일은 항상 "Todo" 로 지칭 |

---

## 🔧 자주 쓰는 MCP/도구 요약

- `BuildProject` — Xcode 빌드
- `RunAllTests` / `RunSomeTests` — 테스트 실행
- `Read` / `Edit` / `Write` — 파일 조작 (Bash의 cat/sed 대신 사용)
- `Grep` / `Glob` — 코드 검색
