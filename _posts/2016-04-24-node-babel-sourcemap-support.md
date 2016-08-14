---
layout: post
title:  "Node babel sourcemap support"
date:   2016-04-24 18:28:48 +0900
categories: javascript
---

[node-source-map-support 라이브러리](https://github.com/evanw/node-source-map-support)를 이용해서 바벨이 적용된 노드 코드를 편리하게 디버깅할 수 있는지 체크해보기로 했다. 사실 처음에 생각했던 것보다 무척이나 쉬운데, 기본적으로 babel을 설정할 때 -s 옵션을 이용하여 ([관련링크](https://babeljs.io/docs/usage/cli/)) sourcemap을 만들게 하면 자동으로 빌드된 파일에 대한 source map이 생성되고, 컴파일된 파일의 맨 하단에 소스맵 정보가 주석으로 붙게 된다.

아래는 `package.json` 파일에 명시된 내용이다. `compile`, `compile-watch`에 보면 `-s` 옵션이 붙은 것을 확인할 수 있다.

```js
  "scripts": {
    "test": "npm run compile && node_modules/.bin/mocha --compilers js:babel-core/register --require ./test/setup.js test/**/*.spec.js",
    "test-watch": "npm test -- --watch",
    "build": "./node_modules/.bin/webpack --config webpack.config.js --progress --profile --colors",
    "build-watch": "./node_modules/.bin/webpack-dev-server",
    "compile": "babel --presets es2015 -s -d lib/ src/",
    "compile-watch": "babel --watch --presets es2015 -s -d lib/ src/"
  },
```

위와 같이 설정해 준 뒤 노드 앱 실행시에 아래와 같은 코드를 최초에 실행만 해주면 source map이 적용되어 stack trace가 출력되게 된다. ([node-source-map-support](https://github.com/evanw/node-source-map-support) 에 있는 설명대로..)

```js
import 'source-map-support/register';
```

Mocha에서의 실행역시 `--require` 옵션을 이용하여 매우 편리하게 가능하다.

웹스톰은 역시 매우 똑똑해서 breakpoint를 걸고 수행했을 때 source map이 있으면 컴파일된 소스가 아닌 실제 오리지널 소스에서 디버깅이 잘 된다.

다만 스택을 찍을 때 퍼포먼스 패널티는 분명히 있다. 10000개의 예외를 강제로 만들어서 스택을 access했을 때 source map이 없는 경우는 0.926초, 있는 경우는 3.497초가 걸렸다. 단, 예외가 만들어지고, 스택까지 찍었을 때 저정도 차이가 나는 것인데, 일반적인 경우에 이 수치는 어쩌면 큰 문제가 아닐 수 있다. `new Error('test').stack`과 같이 스택을 access 하는 경우에만 패널티가 발생하기 때문이다. 스택을 조회하지 않으면 패널티가 발생하지 않는다. 만약 운영 상황에서 이 퍼포먼스 패널티가 걱정된다면 소스맵을 따로 저장해 놓고 찍힌 스택을 해당 버전의 소스맵을 이용해서 다시 파싱해서 봐야 할 것이다. (하지만 구지 그럴 필요가...)

결론적으로 보자면 바벨을 써서 노드 서버단 개발을 망설일 이유가 전혀 없어보인다.

진작 테스트해볼 껄 그랬다. 개인적으로 [destructuring assignment](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)와 [spread operator](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Spread_operator)를 아직도 노드에서 사용하지 못하는게 불만이었는데.. 빨리 갈아타야겠다.
