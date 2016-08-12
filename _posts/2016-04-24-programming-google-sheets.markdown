---
layout: post
title:  "Programming google sheets"
date:   2016-04-24 16:11:41 +0900
categories: javascript
---

구글 드라이브는 스크립트 프로그래밍을 지원한다. MS 오피스로 따지면 VBA 같은 개념인데, 늘 있다는 것은 알고 있었지만 제대로 사용해본 적이 없었다. 근데 오늘 내가 가지고 있는 모든 금융상품 계정들을 구글 스프레드 시트에 모아서 관리를 하려고 하다보니 몇 가지 아쉬운 점들이 있어서 구글 시트 스크립트를 사용해 봤다. 그냥 현재 가지고 있는 금(gold) 상품이나 외화 상품의 대략적인 평가액을 알고 싶었을 뿐..

* [Overview of Google Apps Script](https://developers.google.com/apps-script/overview) 문서를 보면서 진행하면 기본적인 것은 쉽게 가능하다.
* 기본적인 매크로 수준의 구현은 매우 쉬운데 스크립트 에디터를 열어서 함수를 구현해주면 구글 시트에서 그냥 바로 함수로 사용이 가능하다.
* 어찌보면 확장을 위해 가장 중요한 기능 중 하나인 네트워크를 통해서 읽어오는 것은 [UrlFetchApp](https://developers.google.com/apps-script/reference/url-fetch/url-fetch-app#fetchurl-params)이라는 것을 사용하는데, 분명 비동기로 동작해야 하는 이 함수가 동기코드처럼 동작한다. 마치 meteor에서 사용하는 형태의 API인데, 스크립트가 서버사이드에서 수행된다는 점을 보았을 때 코드를 내부적으로 트랜스파일해서 사용하던가 하지 않을까 싶다. 어쩌면 fiber를 사용할지도..
* [외부의 라이브러리를 가져다가 사용하는 방법](https://developers.google.com/apps-script/guide_libraries#best-practices-to-writing-a-library)이 있긴 있는데 얼핏 보기에 자유롭게 사용은 안되어 보인다. 필요하면 나중에 한 번 해보고..
* jsdoc을 이용하여 설명을 기입할 수 있으며 `@customFunction`이라는 태그를 붙여주면 자동완성 기능도 제공한다. ([참고링크](https://developers.google.com/apps-script/guides/sheets/functions#autocomplete))
* 외부 API를 통하여 받은 json 파일을 가볍게 파싱해서 체크할 때 역시 제일 편리한 건 [jq](https://jqplay.org/) 툴인 것 같다. 설치까지는 필요없어보이고 그냥 저기서 구조 체크.
* quandl.com 이라는 곳에서 금융과 관련된 다양한 API를 제공하더라. 예를 들면 금 1온스당 한화의 가격은 [이 링크](https://www.quandl.com/api/v3/datasets/WGC/GOLD_DAILY_KRW.json?start_date=2016-04-10)를 통해서 가져올 수 있다. 다만 딜레이가 꽤 있는데, 어차피 단타칠것도 아니고.. 이정도면 쓰기에 훌륭했다.

만들어진 스크립트는 [gist로 공유](https://gist.github.com/redism/c1819482a022d1b75b9ac61c7ed80903)하였으니 혹시라도 쓰고 싶은 분은 가져다 쓰시면 되겠습니다.

다음에 시간날 때 해보고 싶은 작업은, 구글 시트만을 이용해서 히스토리까지 저장하는 것. 업데이트를 자동으로 하는게 아니라 주기적으로, 혹은 내가 정확하게 요청할 때만 업데이트를 하고 자산의 diff를 계속 트래킹할 수 있도록 만드는 것. 그러면 자연스럽게 그래프로 그릴 수 있을테니..
