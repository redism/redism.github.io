---
layout: post
title:  "웹스톰으로 바벨 프로젝트 디버깅하기"
date:   2016-08-14 03:37:41 +0900
categories: javascript
---

이 포스트에서는 node.js 서버 파트를 babel 을 이용하여 변환하여 사용하는 경우 웹스톰을 이용해서 디버깅을 하는 방법에 대해서 간단히 짚어보고자 합니다.

### babel-node 를 이용한 디버깅

다음과 같이 `babel-node`를 인터프리터로 사용하여 코드를 디버깅하면 일반 노드 디버깅 하듯이 별 문제 없이 디버깅이 가능합니다.  

![debugging](/images/webstorm_debugging/debugging.png)

2016.1 버전의 웹스톰에서 테스트되었습니다. 테스트케이스를 이용하여 디버깅을 하고 싶을 때도 문제 없이 가능합니다.

 ![testcase](/images/webstorm_debugging/testcase.png)

### Asynchronous code debugging

다음과 같이 Promise를 `async`, `await` 하는 경우 `await` 에서 breakpoint 를 걸어놓고 `Step over`를 수행하더라도 다음 라인으로 넘어가지 않습니다. 이는 `async`, `await` 이 generator를 이용하여 구현되기 때문에 어쩔 수 없는 부분이라 생각됩니다. (아직까지는 이 경우에 대하여 나이스하게 디버깅되는 툴은 본 적이 없습니다.)

 ![promise_await](/images/webstorm_debugging/promise_await.png)

이 경우 그나마 가장 편리하게 디버깅할 수 있는 방법은 다음 코드 라인에 추가적으로 breakpoint 를 잡아서 `Resume Program`을 하거나, `Run to cursor`를 이용하는 방법으로 보입니다. 조금 아쉬운 부분인 것은 어쩔 수 없네요. 하지만 왠지 조만간 웹스톰에서 async debugging 이 지원될 것만 같으니 기다려보죠.

### Evaluate Expression

이번에는 breakpoint 가 잡혀있는 상태에서 코드를 실행할 수 있는 `Evaluate Expression`에 대해서 살펴보지요. 

 ![evaluate_expression](/images/webstorm_debugging/evaluate_expression.png)

Evaluate Expression 메뉴를 선택하면 다음과 같이 편리하게 값을 확인할 수 있고 현재 context 내에서 코드를 실행해 볼 수도 있습니다.

 ![evaluate_expression_2](/images/webstorm_debugging/evaluate_expression_2.png)

간단하게 살펴볼 때는 `Expression Mode`가 더 편리하니 참고하세요.

### Conditional breakpoint

breakpoint 를 잡을 때는 특정 조건에만 breakpoint 에 멈추도록 설정할 수도 있습니다. 사실 사용할 일이 그리 많지 않다보니 모르는 경우가 많더군요. breakpoint에 우클릭을 해보세요.

 ![conditional_debug](/images/webstorm_debugging/conditional_debug.png)

다음과 같이 특정 조건에서 멈추게 됩니다.

 ![conditional_debug_stop](/images/webstorm_debugging/conditional_debug_stop.png)
