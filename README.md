# 프로젝트D - 캡스톤 프로젝트 소개 웹사이트

## 1. 작품주제(Subject)
- **제목**: 프로젝트D - 액션 턴 기반 수집형 모바일 RPG
- **요약**: 실시간 액션과 전략적 턴제를 결합한 캐릭터 수집형 모바일 RPG 게임으로, 액션 요소를 가미한 빠른 템포의 턴 기반 전투 시스템을 통해 차별화된 게임 경험을 제공합니다.

## 2. 실용적 근거(Rationale)
- **문제**: 모바일 게임 시장은 전 세계적으로 $92.6B 규모로 성장하고 있으며(+3.0% YoY), 전체 게임 시장의 49.3%를 차지하고 있습니다.
- **근거**: 단순 반복적인 턴제 전투에서 벗어나 액션 요소를 가미한 새로운 전투 시스템에 대한 수요가 증가하고 있습니다.
- **기대 가치**: 턴제의 전략성과 액션의 역동성을 결합하여 차별화된 게임 경험을 제공하고 유저 참여도를 향상시킵니다.

## 3. 핵심기능(Features)
- **기능 1**: 실시간 액션 턴 기반 전투 - 턴제 전략과 액션 컨트롤을 결합한 독창적인 전투 시스템
- **기능 2**: 캐릭터 수집 및 육성 시스템 - 다양한 캐릭터를 수집하고 성장시키는 RPG 요소
- **기능 3**: 서버 기반 보안 시스템 - UGS Cloud Code를 활용한 부정행위 방지 및 안전한 게임 환경
- **기능 4**: 크로스 플랫폼 계정 연동 - Google Play 연동을 통한 손쉬운 로그인 및 데이터 동기화
- **기능 5**: Spine 2D 애니메이션 - 고품질의 2D 캐릭터 애니메이션으로 몰입감 제공

## 4. 구현환경(Environment)
- **Front-End(프론트엔드)**: HTML5, CSS3, Jinja2 Template
- **Back-End(백엔드)**: Flask 2.3.0, Python 3.9
- **Runtime(런타임)**: Docker, Docker Compose
- **Deploy(배포)**: AWS ECS (Fargate), AWS ECR
- **Game Engine**: Unity Engine
- **Game Language**: C#
- **Game Backend**: Unity Gaming Service (UGS) - Cloud Save, Cloud Code, Unity Authentication
- **External Integration**: Google Play Games Services
- **Animation**: Spine 2D

## 5. 팀원 구성 및 역할(Team)
- **이어진** - 팀장 / 기획 (프로젝트 총괄, 게임 기획, UI/UX 개발)
- **신우철** - 개발 (전투 시스템 개발, AI 알고리즘 개발, 서버사이드 개발)
- **홍요아** - 개발 / 디자인 (아트 작업, Spine 애니메이션, 로비 및 게임 시스템 개발)
- **지도교수**: 민준식

## 6. 실행 방법(Run)

### 로컬 실행
```bash
# Docker Compose로 실행
docker-compose up --build -d

# 접속
http://localhost:5000
```

### AWS ECS 배포 URL
```
http://43.203.102.84:5000
```

### API 엔드포인트
- `/api/subject` - 작품주제 데이터
- `/api/rationale` - 실용적 근거 데이터
- `/api/features` - 핵심기능 데이터
- `/api/environment` - 구현환경 데이터
- `/api/team` - 팀 구성 데이터
- `/api/all` - 전체 데이터

## 7. 프로젝트 구조
```
capstone-web/
├── app.py                 # Flask 메인 애플리케이션
├── data.json             # 프로젝트 데이터 (JSON)
├── requirements.txt      # Python 의존성
├── Dockerfile           # Docker 이미지 설정
├── docker-compose.yml   # Docker Compose 설정
├── task-definition.json # ECS 작업 정의
├── service-definition.json # ECS 서비스 정의
├── templates/           # HTML 템플릿
│   ├── main.html       # 메인 페이지
│   ├── subject.html    # 작품주제
│   ├── rationale.html  # 실용적 근거
│   ├── features.html   # 핵심기능
│   ├── environment.html # 구현환경
│   └── team.html       # 팀 구성
└── static/
    └── style.css       # 스타일시트
```

## 9. 주요 페이지
- **메인 페이지** (`/main`): 프로젝트 소개, 팀 정보, 네비게이션
- **작품주제** (`/subject`): 프로젝트 목표 및 한 줄 요약
- **실용적 근거** (`/rationale`): 문제 인식, 필요성, 실용적 가치
- **핵심기능** (`/features`): 주요 기능 5가지
- **구현환경** (`/environment`): 개발 도구 및 기술 스택
- **팀 구성** (`/team`): 팀원별 역할 및 담당 업무

## 10. 기술 스택 선택 이유
- **Unity Engine**: 비용적 관점에서 효율적이며 2D 개발에 중점적으로 맞춰진 엔진
- **C#**: Unity 엔진에서 주로 사용하는 언어
- **Unity Gaming Service (UGS)**: Unity 엔진과 자연스럽게 통합되며, 여러 기능을 빠르고 효율적으로 구축 가능
- **Cloud Save**: 클라우드 기반 데이터 저장 서비스로 기기 변경 시 데이터 손실 방지
- **Cloud Code**: 트래픽 수요에 맞춰 자동 확장, 부정행위 방지를 위한 클라이언트-서버 로직 분리
- **Flask**: 경량 웹 프레임워크로 빠른 개발 및 배포 가능
- **Docker**: 컨테이너화를 통한 일관된 실행 환경 제공
- **AWS ECS**: 완전 관리형 컨테이너 오케스트레이션 서비스
---

