# 인자로 받은 텍스트를 변수에 저장
INPUT_TEXT="$1"
API_URL="$2"

# 입력 텍스트가 비어있는지 확인
if [ -z "$INPUT_TEXT" ]; then
    echo "Error: 입력 텍스트가 비어있습니다. 텍스트를 인자로 제공해주세요."
    exit 1
fi

# 이메일 주소 추출
EMAIL=$(echo "$INPUT_TEXT" | grep -oP '[\w.+-]+@[\w-]+\.[\w.-]+')

# 선택된 항목 추출
TOPICS=$(echo "$INPUT_TEXT" | grep -ioP "(?<=- \[)[xX](?=\] ).*" | sed 's/^[xX]\] //' | sed 's/\r//')

# JSON 생성
JSON_DATA=$(jq -n \
            --arg email "$EMAIL" \
            --arg topics "$TOPICS" \
            '{email: $email, topics: ($topics | split("\n"))}')

FULL_URL="${API_URL}/subscription"

# Post 요청
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST -H "Content-Type: application/json" -d "$JSON_DATA" "$FULL_URL")

# 응답 본문과 상태 코드 분리
HTTP_BODY=$(echo "$RESPONSE" | sed '$d')
HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)

# 상태 코드에 따른 처리
if [ "$HTTP_STATUS" == "201" ]; then
    echo "Success: 구독이 성공적으로 완료되었습니다."
    echo "응답 본문: $HTTP_BODY"
    exit 0
else
    echo "Error: 구독 요청이 실패했습니다. HTTP 상태 코드: $HTTP_STATUS"
    echo "응답 본문: $HTTP_BODY"
    exit 1
fi