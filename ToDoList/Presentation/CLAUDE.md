# Presentation 계층 디자인 규칙

이 파일은 **Presentation 계층(View/ViewModel)** 의 UI 디자인 규칙을 정의합니다.
루트 [CLAUDE.md](../../CLAUDE.md) 의 아키텍처/코딩 컨벤션을 보완합니다.

> 📎 화면 시안/스크린샷은 [docs/design/](../../docs/design/) 에서 화면별 폴더로 확인. UI 작업을 시작하기 전 해당 화면 폴더를 먼저 살펴볼 것.
> 시각 언어의 기준 시안: [docs/design/todo-list/main-default.png](../../docs/design/todo-list/main-default.png)
> → **파스텔 톤 + 둥근 카드 + 소프트 그림자 + 플로팅 FAB**.

---

## 🎨 색상

### 팔레트 (Light)

| 용도 | 헥스 | 비고 |
|---|---|---|
| Background | `#F4F5F9` | 앱 최하단 배경 |
| Surface (Card) | `#FFFFFF` | 카드/시트 |
| Text Primary | `#1A1A2E` | 제목·본문 |
| Text Secondary | `#8A8A9E` | 보조 라벨·타임스탬프 |
| Accent Primary | `#B8D4F0` | 기본 포인트 (파스텔 블루) |
| Accent Yellow | `#FFE066` | 강조·별표 |
| Accent Coral | `#FF9A8B` | 경고·중요 Todo |
| Accent Lavender | `#C9A7FB` | 보조 카테고리 |
| Accent Mint | `#B8E6D8` | 완료 상태 |
| Divider | `#E8EAF0` | 1pt 얇은 구분선 |

### 팔레트 (Dark)

| 용도 | 헥스 |
|---|---|
| Background | `#1E1F2E` |
| Surface | `#2B2B3C` |
| Text Primary | `#EDEDF2` |
| Text Secondary | `#A0A0B5` |
| Divider | `#3A3B4D` |
| Accent 계열 | 동일 헥스 사용, `.opacity(0.85)` 로 채도 살짝 다운 |

### 운영 규칙

- 모든 색상은 `Assets.xcassets` 의 **Color Set** 으로 정의하고 Light/Dark 를 함께 지정. 뷰 코드에서 `Color(hex:)` 같은 하드코딩 **금지**.
- 네이밍: `bgPrimary`, `surface`, `textPrimary`, `textSecondary`, `accentBlue`, `accentYellow`, `accentCoral`, `accentLavender`, `accentMint`, `divider`

---

## ✍️ 폰트

iOS 시스템 폰트(SF Pro) 기반, Dynamic Type 지원.

| 역할 | TextStyle | Weight |
|---|---|---|
| 화면 제목 | `.largeTitle` | `.bold` |
| 섹션 헤더 | `.title3` | `.semibold` |
| TodoRow 제목 | `.body` | `.medium` |
| 본문 | `.body` | `.regular` |
| 보조 라벨/시간 | `.footnote` | `.regular` |
| 강조 수치(통계 등) | `.largeTitle` | `.bold` · `monospacedDigit()` |

- `Font.system(.body)` 처럼 **TextStyle 기반** 으로만 지정 (고정 pt 사용 금지) → Dynamic Type 자동 대응.
- `fixedSize()` 사용 금지. 긴 제목은 줄바꿈 허용.

---

## 📏 간격 (Spacing)

4의 배수를 기본 단위로 사용.

| 토큰 | pt | 용도 |
|---|---|---|
| `xs` | 4 | 아이콘-라벨 사이 |
| `sm` | 8 | 인접한 텍스트 요소 |
| `md` | 12 | 카드 간 수직 간격 |
| `lg` | 16 | 카드 내부 padding |
| `xl` | 20 | 화면 좌우 safe area padding |
| `xxl` | 32 | 섹션 간 간격 |

### Corner Radius

| 대상 | pt |
|---|---|
| 카드/시트 | 20 |
| 버튼/입력 필드 | 12 |
| 원형 아이콘 배지 | 20 (지름 40의 절반, 완전 원) |
| FAB | 28 (지름 56) |

### Shadow

- 카드 기본: `color: .black.opacity(0.04), radius: 8, x: 0, y: 2`
- FAB/강조: `color: accentPrimary.opacity(0.3), radius: 12, x: 0, y: 4`

---

## 🧩 컴포넌트 규칙

- **TodoRow** — `surface` 배경, radius `20`, padding `16`, 좌측에 **40×40 원형 아이콘 배지**(카테고리 accent), 우측 끝에 iOS 기본 `Toggle` 또는 체크 아이콘. 카드 간 수직 간격 `md(12)`.
- **FAB (할 일 추가)** — 화면 우하단, 지름 `56`, 배경 `accentPrimary`, white `+` 아이콘, Shadow(FAB 규칙) 적용, safe area 기준 trailing/bottom `20`.
- **탭바** — 현재는 iOS 기본 `TabView` 유지. 추후 플로팅 pill 스타일로 전환 가능 (시안 중앙 버튼 참고).
- **Toggle/Switch** — iOS 기본(`.toggleStyle(.switch)`), tint `accentPrimary`. 커스텀 그리지 말 것.
- **Empty State** — 중앙 정렬, 일러스트/이모지 + `.title3` 제목 + `.footnote` 설명 + 기본 CTA 버튼.

> 새로운 컴포넌트가 필요하면 기존 규칙으로 조합 가능한지 먼저 검토. 중복 컴포넌트 금지.

---

## 🌗 다크모드

- 모든 색상은 Asset Catalog Color Set 으로 Light/Dark 동시 정의 — 런타임에 `colorScheme` 분기 코드 **금지**.
- `#Preview` 에 `.preferredColorScheme(.dark)` 변형을 하나씩 포함해 QA.
- 시스템 설정을 따르며, 앱 내 수동 토글은 제공하지 않음.

---

## ♿ 접근성

- **터치 타깃**: 최소 `44 × 44pt` (FAB, Toggle, 체크박스 포함).
- **대비**: 전경/배경 대비 WCAG AA (본문 4.5:1, 큰 글씨 3:1) 이상. `textSecondary` 를 흰 배경 위에서 본문으로 쓰지 말 것.
- **Dynamic Type**: 모든 텍스트는 TextStyle 기반. AX1~AX3 크기에서도 레이아웃이 깨지지 않는지 `#Preview` 로 확인.
- **VoiceOver**: TodoRow 에 `.accessibilityLabel("\(제목), \(완료 여부)")` · `.accessibilityHint` 지정. 아이콘 전용 버튼(FAB 등)에는 반드시 label 부여.
- **Reduce Motion**: 애니메이션이 필수가 아닐 경우 `@Environment(\.accessibilityReduceMotion)` 체크 후 스킵.
