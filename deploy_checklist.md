# BuildingCare
## Frontend Deployment Checklist
### Test Deploy
- [ ] .env.production 파일에서 연결할 백엔드 서버 주소를 설정한다.
- [ ] 해당 주소가 commit되어있는지 확인한다.
- [ ] git status, notpush를 통해 누락된 내용이 없는지 확인한다.

### Real Deploy
- [ ] main branch로 이동한다.
- [ ] release 또는 deploy branch를 main branch에 git merge를 한 뒤 pnpm run build가 되는지 확인해 본다.
- [ ] 시간이 된다면 pnpm run start로 확인도 해본다.
- [ ] App.tsx에서 개발자 체크 로직을 제거한다.
- [ ] .env.production 파일에서 본서버 백엔드 서버 주소를 설정한다.
- [ ] 해당 주소가 commit되어있는지 확인한다.
- [ ] git status, notpush를 통해 누락된 내용이 없는지 확인한다.
- [ ] CloudFlare Pages에서 skip된 빌드를 다시 실행한다.
- [ ] CloudFlare Pages에서 커밋 번호를 확인한다.

## Backend Deployment Checklist
### Test Deploy
- [ ] application.properties에서 profile을 test로 설정한다.
- [ ] application-test.properties에서 server.domain이 백엔드 도메인이 맞는지 확인한다.
- [ ] application-test.properties에서 데이터베이스 schema가 원하는 곳인지 확인한다.
- [ ] 원하는 백엔드 서버가 prod가 아닌 것을 다시 확인한다
- [ ] deploy <product> <branch> <server> 명령어를 실행한다.
- [ ] 해당 백엔드 서버의 nginx가 제대로 설정되어있는지 확인한다.

### Real Deploy
- [ ] main branch로 이동한다.
- [ ] release 또는 deploy branch를 main branch에 git merge를 한다.
- [ ] 시간이 된다면 ./gradlew run이 되는지 확인해 본다.
- [ ] application.properties에서 profile을 prod로 설정한다.
- [ ] application-test.properties에서 server.domain이 백엔드 도메인이 buildingcare.life가 맞는지 확인한다.
- [ ] application-prod.properties에서 데이터베이스 schema가 contract인지 확인한다.
- [ ] 원하는 백엔드 서버가 prod인지 prod2인지 확인한다
- [ ] 원하는 백엔드 서버가 본서버용 target group에 들어가 있는지 확인한다.
- [ ] deploy <product> <branch> <server> 명령어를 실행한다.
- [ ] 해당 백엔드 서버의 nginx가 제대로 설정되어있는지 확인한다.

