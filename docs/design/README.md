# 디자인 참고 자료

이 폴더는 **Claude Code 및 개발자가 UI 작업 시 참고할 디자인 자료**를 모아둔 곳입니다.
앱에 실제로 포함되는 리소스가 아니므로 Xcode 프로젝트/빌드와는 무관합니다.

> ⚠️ 앱 화면에서 사용할 이미지/아이콘은 [`ToDoList/Assets.xcassets`](../../ToDoList/Assets.xcassets) 에 추가하세요.

---

## 📁 폴더 구조

```
docs/design/
├── README.md          # 이 파일
├── <screen-name>/     # 화면 단위 폴더 (예: todo-list, add-todo, settings)
│   └── *.png|jpg|pdf|md
└── common/            # 색상 팔레트, 아이콘, 로고 등 공통 요소
```

- **새 화면이 생기면 폴더를 추가**하세요. 예: `add-todo/`, `settings/`
- 화면이 아닌 공통 디자인 요소는 `common/` 에 둡니다.

---

## 📝 파일명 규칙

- **소문자 + 하이픈**: `main-empty-state.png`, `add-button-pressed.png`
- 상태가 다르면 접미사로 구분: `-default`, `-pressed`, `-disabled`, `-dark`
- 기기/사이즈 구분이 필요하면 접두사: `iphone-`, `ipad-`
- 부가 설명은 같은 이름의 `.md` 로 작성 가능: `main-empty-state.md`

예시:
```
todo-list/
├── main-default.png
├── main-empty-state.png
├── main-dark.png
└── main-empty-state.md   # 빈 상태 카피 문구, 동작 등 메모
```

---

## 🎨 권장 포맷

| 용도 | 포맷 |
|---|---|
| 화면 시안 | PNG (선명도 우선) |
| 사진/배경 | JPG |
| 벡터/플로우차트 | PDF, SVG |
| 디자인 메모 | Markdown (`.md`) |

---

## 🤖 Claude 활용법

UI 작업을 시작할 때:
- **"todo-list 화면 시안 참고해줘"** → Claude가 [`todo-list/`](todo-list/) 폴더의 이미지를 Read 합니다.
- **"공통 색상 팔레트 봐줘"** → Claude가 [`common/`](common/) 폴더를 참고합니다.

Claude는 루트 [CLAUDE.md](../../CLAUDE.md) 의 안내에 따라 UI 작업 시 이 폴더를 우선 확인합니다.

---

## 📚 참고

- 외부에서 가져온 시안은 출처를 함께 적어두세요 (라이선스/저작권 분쟁 방지).
- 시안 파일이 수 MB 이상으로 커질 경우 Git LFS 도입을 검토하세요.
