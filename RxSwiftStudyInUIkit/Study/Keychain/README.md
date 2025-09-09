# 🔍 UserDefaults vs Keychain 저장 보장성 비교

## 1. UserDefaults

- set(_:forKey:) 호출 시 → 메모리에만 기록하고, iOS가 나중에 디스크에 flush.
- 그래서 앱이 갑자기 죽으면 디스크에 기록되지 않은 값은 날아감.
동기화를 강제하려면 synchronize()를 호출해야 하지만, 이것도 내부적으로는 *“강제로 flush 요청”*일 뿐 100% 즉시 기록을 보장하진 않음 (게다가 iOS 12 이후 deprecated).

## 2. Keychain

- SecItemAdd / SecItemUpdate 호출 시 → Security Daemon이 즉시 트랜잭션 처리.
- 호출이 성공 리턴되면 DB에 commit 완료된 상태.
다만, 호출 중간에 앱이 죽으면 (예: 크래시, 강제 종료) → 당연히 commit이 끝나지 않았으니 저장이 안될 수 있습니다.

## ✅ 차이의 본질

- UserDefaults: “나중에 저장” 모델이라 실패 가능성이 더 큼.

- Keychain: “지금 저장” 모델이라, 저장 완료 리턴을 받으면 디스크에 반영된 상태 → 안정성이 훨씬 높음.

즉,

UserDefaults는 저장했다고 해도 실제로 안 들어가 있을 수 있음.

Keychain은 성공 리턴을 받았다면 저장은 이미 된 상태 → 여기서 신뢰성이 올라가는 거예요.

# 🔒 결론

네, 앱이 저장 함수 호출 중에 죽으면 Keychain도 저장이 안될 수 있습니다.

하지만 성공 코드(errSecSuccess)를 받은 시점에는 이미 시스템 DB에 기록이 끝난 상태라 이후에는 안전합니다.

그래서 자동 로그인 토큰 같은 중요한 값은 Keychain을 쓰는 게 맞습니다.

# 동작 방식 비교

## 1. UserDefaults 동작 방식

UserDefaults는 결국 plist 파일 (.GlobalPreferences.plist)에 key-value를 저장하는 구조입니다.

iOS가 메모리에 캐싱해두었다가 비동기적으로 디스크에 flush합니다.

그래서 문제가 생길 수 있어요

- 앱이 저장 직후 강제 종료되면 디스크에 안 내려가서 값이 유실될 수 있음.
- 디스크 부족이나 iOS 최적화 과정에서 캐시/파일이 날아갈 수 있음.
- 앱 업데이트 과정에서 plist 구조가 바뀌거나 마이그레이션이 꼬이면 값이 초기화되기도 함.

즉, UserDefaults는 편리하지만 영속성과 안정성이 100% 보장되지 않음.

## 2. Keychain 동작 방식

Keychain은 단순 파일 기반이 아니라 iOS 보안 서브시스템(Security Framework) 에 의해 관리되는 Encrypted Database입니다.

특징:

- 시스템 레벨 트랜잭션 보장
    - 저장/삭제/읽기 요청은 Security Daemon을 통해 처리되고, 완료되기 전까지 앱이 블록(block)됨.
    - 따라서 “저장했다고 했는데 실제로는 안 저장된 상태”가 발생하지 않음.

앱 샌드박스 보호
→ 해당 앱(혹은 지정한 App Group)만 접근 가능.

암호화 저장
→ Secure Enclave, Device Keychain과 연계, iOS가 직접 보호.

시스템 이벤트에 안전

앱 업데이트, 기기 재부팅, 백그라운드 종료 등에도 값이 유지.

디스크 부족 상황에서도 날아가지 않음 (앱 삭제 시에만 삭제).

즉, Keychain은 보안 + 안정성을 모두 보장하는 저장소라서 인증서, 비밀번호, 토큰 같은 민감 정보 저장에 권장됩니다.
