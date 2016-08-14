---
layout: post
title:  "Code review with Webstorm"
date: 2016-04-24 12:06:13 +0900
categories: code review
---

회사에서 간단하게 자바스크립트 코드 리뷰를 할 일들이 많이 생기는데 너무 무식한 방법을 쓰고 있었던 것 같아 좀 더 좋은 방법이 없을까 찾아봤다.

기존에는 github 에서 제공하는 [Compare View](https://help.github.com/articles/comparing-commits-across-time/)를 그냥 이용했는데, 이것의 가장 큰 단점은 그냥 텍스트를 눈으로 보는 형태이기 때문에 리뷰가 제대로 되지 않는다는 것이다. 그래서 얼마전에 메일링을 통해서 알게된 젯브레인의 [Upsource](https://www.jetbrains.com/upsource)를 시도했는데, 너무 무겁더라. 서버를 띄우고 깃헙 리포를 땡겨와서 정규 프로세스에 의해 새로운 리뷰 프로세스를 만들고.. 항상 같이 붙어 작업하는 소규모팀에서 사용하기엔 좀 과하다 싶었다.

결국 선택한 것은 그냥 웹스톰의 플러그인을 잘 사용하는 것. 웹스톰의 Git 플러그인에보면 특정 커밋들에서 발생한 수정파일들만 모아서 보여주기도 하고, 해당 파일을 특정 커밋과 side-by-side diff 형태로 보여주기도 한다. 단축키도 꽤 잘 지원하기 때문에 단축키만 손에 맞게 설정하고나면 그 어떤 것보다 상당히 파워풀한 리뷰툴로 동작할 듯.

![git log example](/images/gitlogex.png)
![git log example](/images/diffex.png)
