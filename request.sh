#!/bin/bash

log=$(cat)

# 이메일 주소 추출
email=$(echo "$log" | sed -n '/### 알림을 받을 이메일 주소를 입력해주세요./,/^$/p' | tail -n 2 | head -n 1)


# 체크된 항목 추출
checked_items=($(echo "$log" | sed -n '/### 알림을 받을 주제를 선택해주세요./,/^$/p' | grep '- \[X\]' | sed 's/- \[X\] //'))

# 결과 출력 (디버깅용)
echo "Email: $email"
echo "Checked items: ${checked_items[@]}"

# JSON 데이터 생성
json_data=$(jq -n \
    --arg email "$email" \
    --arg items "$(printf '%s\n' "${checked_items[@]}")" \
    '{email: $email, items: ($items | split("\n") | map(select(length > 0)))}')


# 결과 출력 (디버깅용)
echo "JSON data: $json_data"

# curl 요청 보내기
# curl -X POST \
#      -H "Content-Type: application/json" \
#      -d "$json_data" \
#      https://api.example.com/endpoint