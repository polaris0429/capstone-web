@echo off
echo ========================================
echo ProjectD ECS 완전 배포 스크립트
echo ========================================
echo.

echo [1/9] 보안 그룹에 포트 5000 추가...
aws ec2 authorize-security-group-ingress --group-id sg-07bb5feadb0d402b1 --protocol tcp --port 5000 --cidr 0.0.0.0/0 --region ap-northeast-2 2>nul
echo 포트 5000 추가 완료 (이미 있으면 건너뜀)

echo [2/9] ECR 로그인 중...
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 434413664301.dkr.ecr.ap-northeast-2.amazonaws.com
if %errorlevel% neq 0 (
    echo ECR 로그인 실패!
    pause
    exit /b 1
)

echo [3/9] Docker 이미지 빌드 중...
docker build -t projectd .
if %errorlevel% neq 0 (
    echo Docker 빌드 실패!
    pause
    exit /b 1
)

echo [4/9] Docker 이미지 태그 지정 중...
docker tag projectd:latest 434413664301.dkr.ecr.ap-northeast-2.amazonaws.com/projectd:latest

echo [5/9] ECR에 이미지 푸시 중...
docker push 434413664301.dkr.ecr.ap-northeast-2.amazonaws.com/projectd:latest
if %errorlevel% neq 0 (
    echo ECR 푸시 실패!
    pause
    exit /b 1
)

echo [6/9] CloudWatch 로그 그룹 생성 중...
aws logs create-log-group --log-group-name /ecs/projectd --region ap-northeast-2 2>nul
echo 로그 그룹 생성 완료 (이미 있으면 건너뜀)

echo [7/9] ECS 클러스터 생성 중...
aws ecs create-cluster --cluster-name projectd-cluster --region ap-northeast-2 2>nul
echo 클러스터 생성 완료 (이미 있으면 건너뜀)

echo [8/9] ECS 작업 정의 등록 중...
aws ecs register-task-definition --cli-input-json file://task-definition.json --region ap-northeast-2
if %errorlevel% neq 0 (
    echo 작업 정의 등록 실패!
    pause
    exit /b 1
)

echo [9/9] ECS 서비스 생성 중...
aws ecs create-service --cli-input-json file://service-definition.json --region ap-northeast-2
if %errorlevel% neq 0 (
    echo 서비스 생성 실패! (이미 있을 수 있음)
    echo 기존 서비스를 업데이트하려면:
    echo aws ecs update-service --cluster projectd-cluster --service projectd-service --force-new-deployment --region ap-northeast-2
)

echo.
echo ========================================
echo 배포 완료!
echo ========================================
echo.
echo 태스크가 시작되는 중입니다... (약 1-2분 소요)
echo.
timeout /t 60 /nobreak
echo 퍼블릭 IP 확인 중...
echo.

aws ecs list-tasks --cluster projectd-cluster --service-name projectd-service --region ap-northeast-2

echo.
echo 위 TASK_ARN을 복사해서 다음 명령어로 IP를 확인하세요:
echo aws ecs describe-tasks --cluster projectd-cluster --tasks [TASK_ARN] --region ap-northeast-2
echo.
pause
