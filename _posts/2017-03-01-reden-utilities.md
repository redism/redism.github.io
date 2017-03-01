---
layout: post
title: Reden utilities
---

방금 [Reden](https://github.com/redism/reden) ([npm](https://www.npmjs.com/package/reden)) 이라는 유틸리티를 배포했다. 실제로 npm 으로 무언가를 배포한 것은 [shell-helper](https://github.com/redism/shell-helper) ([npm](https://www.npmjs.com/package/shell-helper)) 이후 처음이다. (어차피 나와 내가 다니는 회사에서만 쓴다. 그래도 편하니까..)

Reden 역시 나 말고 쓰는 사람이 있을지는 잘 모르겠지만, 기록을 위한 목적으로 글을 쓰려 한다.

일단 Reden의 목표는 단순하다. 매일매일 일어나는 workflow 과정에서 조금이라도 편리하게 처리할 수 있는 유틸리티성 실행파일들의 모음이다. 예를 들면, 깃헙에 PR을 날리는 일이라던가, main remote repository의 브랜치를 로컬에 머지하는 일이라던가.. 원리만 알면 간단하지만, 그럼에도 불구하고 SourceTree 등의 UI로 조작하려면 무척 불편하다. 커맨드라인을 이용하더라도 통상 2-3개 이상의 명령어를 순차적으로 입력해야 하므로 불편하다. 당연히 자동화하고 싶어졌고, 원래는 bash script 로 만들어서 혼자 사용하던 것을 회사 팀에 배포해줬다. 근데 의외로 잘 사용하더라.. (사실 이미 커맨드라인에 익숙한 사람들은 자기 방식을 만들어 쓰고 있었지만 말이다.)

앞으로도 자잘하게 필요해지는 유틸리티들을 모두 여기에 집어넣을까 생각중이다.

**단 맥에서의 동작만 가정하고 있으니 유의해야 한다.**

이제 친절한 설치방법이다. 우선 node.js 가 설치되어 있지 않다면 설치한다. ([nvm](https://github.com/creationix/nvm) 을 이용하기를 추천하며, 이후 과정은 nvm을 이용한 과정이다.)

```bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
```

nvm 을 사용하기 위해서 터미널을 다시 열고, 실제 node.js를 설치한다. 현재 최신 LTS인 v6.10.0 을 설치해보자.

```shell
nvm install v6.10.0
```

이제 `Reden`을 설치한다.

```shell
npm i reden -g
```

사용해본다. 자세한 사용법은 [github/reden](https://github.com/redism/reden) 에서 확인 가능하다.

