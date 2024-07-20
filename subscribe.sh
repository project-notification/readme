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

FULL_URL="${API_URL}/subscribe"

# Post 요청
RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d "$JSON_DATA" "$FULL_URL")

HTTP_BODY=$(echo "$RESPONSE" | sed '$d')
HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)

# 상태 코드에 따른 처리
if [ "$HTTP_STATUS" -eq 201 ]; then
    echo "성공: API 요청이 성공적으로 처리되었습니다. (상태 코드: $HTTP_STATUS)"
    exit 0
elif [ "$HTTP_STATUS" -eq 400 ] || [ "$HTTP_STATUS" -eq 500 ]; then
    echo "오류: API 요청 처리 중 오류가 발생했습니다. (상태 코드: $HTTP_STATUS)"
    echo "오류 메시지: $HTTP_BODY"
    exit 1
else
    echo "알 수 없는 응답: 예상치 못한 상태 코드를 받았습니다. (상태 코드: $HTTP_STATUS)"
    echo "응답 본문: $HTTP_BODY"
    exit 1
fi