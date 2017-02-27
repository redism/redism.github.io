---
layout: post
title: MySQL Tip - Upsert
---

MySQL 에서 간편하게 사용할 수 있는 upsert 명령이 있다.

* [참고링크](https://chartio.com/resources/tutorials/how-to-insert-if-row-does-not-exist-upsert-in-mysql/)
* [MySQL - INSERT ON DUPLICATE KEY UPDATE](http://dev.mysql.com/doc/refman/5.7/en/insert-on-duplicate.html)

이를 이용하면 PRIMARY KEY 또는 INDEX에 의하여 INSERT가 실패했을 때 동작을 정의할 수 있다. 성능 이득이 얼마나 되는지 대략적으로나마 확인하고 싶어 테스트를 돌려봤다.

1000개의 데이터에 대하여 내 iMac 에서 docker를 이용하여 띄워놓은 MySQL 인스턴스에 대하여 수행했다.

|                | INSERT 후 예외처리 UPDATE | INSERT ON DUPLICATE |  비교   |
| -------------: | :------------------: | :-----------------: | :---: |
| 중복이 없는 경우 (0%) |       25399 ms       |      25423 ms       | 100%  |
|         50% 중복 |       25906 ms       |      24909 ms       | 94.3% |
|        100% 중복 |       27380 ms       |      24840 ms       | 89.8% |

예상대로 당연히 이득이 있으며, 특히 중복이 많이 존재할 수 있는 경우 생각보다 큰 이득이 있을 수 있으니 적극 활용하는게 좋겠다.
