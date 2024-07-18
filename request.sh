# 인자로 받은 텍스트를 변수에 저장
INPUT_TEXT="$1"

# 입력 텍스트가 비어있는지 확인
if [ -z "$INPUT_TEXT" ]; then
    echo "Error: 입력 텍스트가 비어있습니다. 텍스트를 인자로 제공해주세요."
    exit 1
fi

# 이메일 주소 추출
EMAIL=$(echo "$INPUT_TEXT" | grep -oP '[\w.+-]+@[\w-]+\.[\w.-]+')

# 선택된 항목 추출
ITEMS=$(echo "$INPUT_TEXT" | grep -oP "(?<=- \[X\] ).*" | sed 's/주제 필터링 없이 모든 글을 메일로 받겠습니다./all/' | sed 's/\r//')

# JSON 생성
JSON_DATA=$(jq -n \
            --arg email "$EMAIL" \
            --arg items "$ITEMS" \
            '{email: $email, items: ($items | split("\n"))}')

# JSON 데이터 출력 (디버깅용)
echo "생성된 JSON 데이터:"
echo "$JSON_DATA"