---
layout: post
title: iOS - Automatic injection of local IP address
---

Android에서의 방법은 [이 링크](/2017/02/27/android-automatic-injection-of-local-ip-adress.html)를 참고하시면 됩니다.

최근에 클라이언트 개발자들에게 각기 로컬 머신에서 서버를 셋업할 수 있도록 하였다. 그리고 iOS의 경우 build scheme에 따라서 바라보는 IP 주소를 바꿀 수 있도록 코드를 작성했다. 기본적으로는 `http://127.0.0.1:8082`의 주소로 접속하도록 만들어 놓았다.

하지만 시뮬레이터로만 작업을 하지 않고 디바이스를 이용해서 작업하는 경우가 잦다보니, 각자 해당 주소를 자신의 로컬 머신 IP 주소로 변경하여 작업하는 일이 생겨났다. 그런데 실수로 변경된 로컬 머신 IP를 커밋하기도 하고, 매번 지저분한 변경사항을 스태시하고 커밋하는 것도 영 귀찮은 일이 아니었다.

이를 해결하기 위해서 다음과 같은 방법을 이용해서 빌드할 때 각자의 로컬 머신 주소를 이용할 수 있도록 추가했다.



* 프로젝트에 `local_setting.plist` 파일을 추가한다. (테스트 빌드 타겟에만 적용하면 더욱 깔끔하다.)
* 위 파일은 `LOCAL_IP` 라는 값 하나만 갖는 Dictionary 이면 된다. 기본값인 `127.0.0.1`을 넣어두자.
* 프로젝트의 테스트용 타겟에 `Build Phases`로 가서 맨 마지막에 `Run Script`를 추가하고 다음과 같은 내용을 적는다. Shell 은 `bin/bash`로 지정한다. (이 스크립트는 [이 SO 답변의 도움](http://stackoverflow.com/a/27102315/388351)을 받았는데, 만약 네트워크 인터페이스가 여러개라고 좀 더 복잡한 상황이라면 원하는대로 동작하지 않을 수도 있을 것 같다.)

```bash
awk '/inet / && $2 != "127.0.0.1"{print $2}' <(ifconfig) | xargs -I % plutil -replace LOCAL_IP -string % local_setting.plist
```

* IP 주소가 필요한 코드에서 다음과 같이 해당 값을 읽어오도록 만든다.

```swift
if let path = Bundle.main.path(forResource: "local_setting", ofType: "plist") {
    let setting = NSDictionary(contentsOfFile: path)
    if let ip = setting?.value(forKey: "LOCAL_IP") {
      print("Local IP parsed : \(ip)")
    return "http://\(ip):8082"
  }
}
return "http://127.0.0.1:8082"
```

* git 을 이용하여 관리할 때는 다음과 같이 처리해두는게 좋다.
  * `local_setting.plist` 파일은 일단 git 에 추가한다.
  * 모든 개발자 머신에서 다음과 같이 실행하여 향후에 해당 파일의 변경사항이 커밋되지 않도록 다음과 같이 실행한다.

```shell
git update-index --assume-unchanged local_setting.plist
```



사실 처음에는 환경변수나 Launch Argument를 이용하고 싶었는데 원하는대로 되지 않아서 결국 plist 를 이용한 방법으로 올 수 밖에 없었다. 만약 조금 더 개선한다면, `git update-index` 과정을 하지 않을 수 있도록 빌드 스크립트 자체에서 `plist` 파일을 생성하는 방식을 활용하는게 더 좋을 것 같다.



### 참고 스크린샷

![Screenshot](/images/ios_local_ip_injection.jpg)
