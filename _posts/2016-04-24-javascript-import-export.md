---
layout: post
title:  "Javascript import export"
date:   2016-04-24 14:09:59 +0900
categories: javascript
---

ES2015 부터 포함된 새로운 모듈 시스템이 단순히 편의성을 위한 내용들인줄만 알았는데, [묵혀놨던 링크](http://benjamn.github.io/empirenode-2015/#/66)를 찾아 읽다보니 단순 편의성뿐 이상으로 중요한 내용이더라. 뭐 결론적으로는 가능하면 새로운 모듈 시스템을 사용하자라고 볼 수 있겠다. 하지만 아직 최신 버전의 노드에서도 지원하지 않고 있고 바벨을 사용한다 하더라도 그냥 CommonJS의 `require/module.exports`를 사용한다고 하니 지금으로써 최선은 그냥 알아두는 정도일까 싶다. 물론 새로운 프로젝트를 셋업할 때는 바벨을 이용해서 새로운 문법을 적극 활용하는 형태로 가는게 좋을테고.. (ex: [jsnext-skeleton](https://github.com/benjamn/jsnext-skeleton)) 그런데 바벨로 변환된 파일은 디버깅하기가 영 짜증나서..

[jspm](http://jspm.io/)이나 [rollup](https://github.com/rollup/rollup)과 같은 툴에 대해서도 미리 공부해 놓고 적용할 수 있는 부분들에 대해서는 공부하는 두는게 좋겠다는 생각이다.
