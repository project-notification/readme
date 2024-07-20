# 인자로 받은 텍스트를 변수에 저장
INPUT_TEXT="$1"

# 입력 텍스트가 비어있는지 확인
if [ -z "$INPUT_TEXT" ]; then
    echo "Error: 입력 텍스트가 비어있습니다. 텍스트를 인자로 제공해주세요."
    exit 1
fi

echo "입력 텍스트: $INPUT_TEXT"
# 이메일 주소 추출
EMAIL=$(echo "$INPUT_TEXT" | grep -oP '[\w.+-]+@[\w-]+\.[\w.-]+')

# 선택된 항목 추출
TOPICS=$(echo "$INPUT_TEXT" | grep -ioP "(?<=- \[)[xX](?=\] ).*" | sed 's/^[xX]\] //' | sed 's/\r//')

echo "topics: $TOPICS"

# JSON 생성
JSON_DATA=$(jq -n \
            --arg email "$EMAIL" \
            --arg topics "$TOPICS" \
            '{email: $email, topics: ($topics | split("\n"))}')

# JSON 데이터 출력 (디버깅용)
echo "생성된 JSON 데이터:"
echo "$JSON_DATA"