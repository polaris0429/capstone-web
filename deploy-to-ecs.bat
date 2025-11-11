@echo off
echo ========================================
echo ProjectD ECS 배포 스크립트
echo ========================================
echo.

echo [1/7] ECR 로그인 중...
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 434413664301.dkr.ecr.ap-northeast-2.amazonaws.com
if %errorlevel% neq 0 (
    echo ECR 로그인 실패!
    pause
    exit /b 1
)

echo [2/7] Docker 이미지 빌드 중...
docker build -t projectd .
if %errorlevel% neq 0 (
    echo Docker 빌드 실패!
    pause
    exit /b 1
)

echo [3/7] Docker 이미지 태그 지정 중...
docker tag projectd:latest 434413664301.dkr.ecr.ap-northeast-2.amazonaws.com/projectd:latest

echo [4/7] ECR에 이미지 푸시 중...
docker push 434413664301.dkr.ecr.ap-northeast-2.amazonaws.com/projectd:latest
if %errorlevel% neq 0 (
    echo ECR 푸시 실패!
    pause
    exit /b 1
)

echo [5/7] CloudWatch 로그 그룹 생성 중...
aws logs create-log-group --log-group-name /ecs/projectd --region ap-northeast-2 2>nul
echo 로그 그룹 생성 완료 (이미 있으면 건너뜀)

echo [6/7] ECS 클러스터 생성 중...
aws ecs create-cluster --cluster-name projectd-cluster --region ap-northeast-2 2>nul
echo 클러스터 생성 완료 (이미 있으면 건너뜀)

echo [7/7] ECS 작업 정의 등록 중...
aws ecs register-task-definition --cli-input-json file://task-definition.json --region ap-northeast-2
if %errorlevel% neq 0 (
    echo 작업 정의 등록 실패!
    pause
    exit /b 1
)

echo.
echo ========================================
echo 배포 완료!
echo ========================================
echo.
echo 다음 단계:
echo 1. service-definition.json 파일을 편집하여 서브넷 ID와 보안 그룹 ID를 입력하세요
echo 2. 아래 명령어로 서비스를 생성하세요:
echo    aws ecs create-service --cli-input-json file://service-definition.json --region ap-northeast-2
echo.
pause
