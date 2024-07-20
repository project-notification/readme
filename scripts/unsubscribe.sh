INPUT_TEXT="$1"
API_URL="$2"

# 이메일 주소 추출
EMAIL=$(echo "$INPUT_TEXT" | grep -oP '[\w.+-]+@[\w-]+\.[\w.-]+')

if [ -z "$EMAIL" ]; then
    echo "Error: 입력 텍스트에서 이메일 주소를 찾을 수 없습니다."
    exit 1
fi

JSON_DATA=$(jq -n \
            --arg email "$EMAIL" \
            '{email: $email}')

FULL_URL="${API_URL}/unsubscribe"

# Post 요청
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST -H "Content-Type: application/json" -d "$JSON_DATA" "$FULL_URL")

# 응답 본문과 상태 코드 분리
HTTP_BODY=$(echo "$RESPONSE" | sed '$d')
HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)

# 상태 코드에 따른 처리
if [ "$HTTP_STATUS" == "204" ]; then
    echo "Success: 구독 취소가 성공적으로 완료되었습니다."
    echo "응답 본문: $HTTP_BODY"
    exit 0
else
    echo "Error: 구독 취소 요청이 실패했습니다. HTTP 상태 코드: $HTTP_STATUS"
    echo "응답 본문: $HTTP_BODY"
    exit 1
fi