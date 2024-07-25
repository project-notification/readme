## 프로젝트 구인 알림 서비스

이 서비스는 inflearn과 hola에 새로 등록되는 프로젝트 구인글을 실시간으로 분석하여 원하는 포지션의 글이 올라왔을 때 구독자에게 알림을 보내주는 자동화 시스템입니다.

동작 원리: [사이드 프로젝트 인원 모집 공고 알림 서비스를 만들어보았다.](https://velog.io/@leemhoon00/%EC%82%AC%EC%9D%B4%EB%93%9C-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%9D%B8%EC%9B%90-%EB%AA%A8%EC%A7%91-%EA%B3%B5%EA%B3%A0-%EC%95%8C%EB%A6%BC-%EC%84%9C%EB%B9%84%EC%8A%A4%EB%A5%BC-%EB%A7%8C%EB%93%A4%EC%96%B4%EB%B3%B4%EC%95%98%EB%8B%A4)

## 주요 기능
- inflearn과 hola의 새로운 프로젝트 구인글 실시간 모니터링
- 사용자가 지정한 포지션에 대한 맞춤형 알림 서비스
- 1시간 간격으로 업데이트되는 정보
- 이메일을 통한 알림 전송
- Claude AI API를 사용해 각 공고별 주제를 분류

## 사용 방법
### 1. 구독 신청
- 이 저장소의 Issue 탭으로 이동합니다.
- `New Issue` 버튼을 클릭합니다.
- 다음 사진과 같은 `Issue Form`을 선택합니다.

![image](https://github.com/user-attachments/assets/0866f4e3-98a6-4fcf-9da5-5bbf4534abdf)

- 다음 사진과 같이 이메일과 topic을 선택한 후 `Submit new issue` 버튼을 클릭합니다.

![image](https://github.com/user-attachments/assets/4716f113-289a-4603-a912-81a3baeeea99)

- Issue 에 다음과 같은 comment가 생성되면 구독 신청이 정상적으로 완료되었습니다.

![image](https://github.com/user-attachments/assets/59e1e6d5-418e-4b21-96f0-873973cafa30)


## 주의사항

- 1시간 마다 새로운 최신글을 분석하여 알림을 보냅니다.
- 구독을 취소하고 싶으시다면 `Issue`를 `Close` 해주세요.
- topic별로 분류하지 않고, 모든 프로젝트에 대해서 알림을 받고 싶으시다면 checkbox를 비워주세요.
- 추가 기능 및 버그사항은 Issue를 통해 알려주세요.
