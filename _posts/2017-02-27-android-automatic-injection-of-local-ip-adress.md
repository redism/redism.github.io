---
layout: post
title: Android - automatic injection of local ip adress
---

iOS에서의 방식은 [이 글을 참고](/2017/02/27/ios-automatic-injection-of-local-ip-address.html)하면 됩니다.

**맥에서 기준입니다. 다른 OS에서는 스크립트의 내용을 변경해 주어야 할 것으로 보입니다**

최근에 클라이언트 개발자들에게 각기 로컬 머신에서 서버를 셋업할 수 있도록 하였다. 그리고 Android의 경우 build variant에 따라서 바라보는 IP 주소를 바꿀 수 있도록 코드를 작성했다. 기본적으로는 `http://127.0.0.1:8082`의 주소로 접속하도록 만들어 놓았다.

하지만 시뮬레이터로만 작업을 하지 않고 디바이스를 이용해서 작업하는 경우가 잦다보니, 각자 해당 주소를 자신의 로컬 머신 IP 주소로 변경하여 작업하는 일이 생겨났다. 그런데 실수로 변경된 로컬 머신 IP를 커밋하기도 하고, 매번 지저분한 변경사항을 스태시하고 커밋하는 것도 영 귀찮은 일이 아니었다.

이를 해결하기 위해서 다음과 같은 방법을 이용해서 빌드할 때 각자의 로컬 머신 주소를 이용할 수 있도록 추가했다.

* 커스텀 리소스로 `local_setting.xml` 파일을 추가한다. 내용은 다음과 같다.

  ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <resources>
      <string name="LOCAL_IP">MY_LOCAL_IP_PLACEHOLDER</string>
  </resources>
  ```

* 프로젝트 루트 폴더에 다음과 같은 스크립트 파일을 추가한다.

  ```bash
  #!/bin/bash
  awk '/inet / && $2 != "127.0.0.1"{print $2}' <(ifconfig)
  ```

* gradle 파일에 다음과 같은 내용을 추가한다.

  ```groovy
  android {
      applicationVariants.all { variant ->
          variant.mergeResources.doLast {
              def stdout = new ByteArrayOutputStream()
              exec {
                  commandLine "./getip.sh"
                  standardOutput = stdout;
              }
              def ip = stdout.toString().trim()

              File valuesFile = file("${buildDir}/intermediates/res/merged/${variant.dirName}/values/values.xml")
              println("Replacing LOCAL_IP in " + valuesFile)
              println("Detected LOCAL_IP = " + ip)
              String content = valuesFile.getText('UTF-8')
              content = content.replaceAll(/MY_LOCAL_IP_PLACEHOLDER/, ip)
              valuesFile.write(content, 'UTF-8')
          }
      }
  }
  ```

*  필요한 코드에서 다음과 같이 사용한다. (다음의 예제는 kotlin 형태입니다. 그냥 resource에서 문자열 읽어올 때와 같이 사용하면 됩니다.)

  ```kotlin
  "http://${context.resources.getString(R.string.LOCAL_IP)}:8082"
  ```



iOS의 경우와는 다르게 안드로이드는 gradle 을 이용하여 빌드시에 생성되는 intermediate 파일을 변경할 수 있기 때문에 커밋과 상관 없이 처리할 수 있다.
