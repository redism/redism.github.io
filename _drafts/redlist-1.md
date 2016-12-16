---
layout: post
title: 'Redlist #1'
---



TLDR 뉴스



* [Redis 4.0 RC1 릴리즈](http://www.antirez.com/news/110)
  * 모듈 기능 추가 : Higher-level API 를 이용하기 때문에 향후에도 하위 호환성을 유지할 수 있을 것임. RDB/AOF 에 저장될 수 있는 새로운 데이터타입이나 non-blocking command 를 만든다거나 할 수 있음. 
  * [redismodules.com](http://redismodules.com/)에서 여러가지 재미있는 모듈들을 볼 수 있음. 다만, 레디스의 가장 큰 강점은 퍼포먼스였다고 생각하는데 모듈들을 마구잡이로 사용하여 문제가 되지는 않을까 걱정되는 측면도 있음.
  * Replication v2 : PSYNC 가 개선되었다고 함. 결론적으로, master-slave 교체가 이루어지거나 할 때 full-synchronization 되는 것을 최대한 회피하도록 개선.
  * Cache eviction 개선 : LFU(Last Frequently Used) 옵션 추가, 기존 eviction policy 들도 개선. [상세한 내용](http://antirez.com/news/109)
  * 비동기 `DEL`, `FLUSHALL`, `FLUSHDB` : `UNLINK` 커맨드가 추가되어 non-blocking 방식으로 삭제 가능. (key에 대한 레퍼런스만 삭제하는 방식) `FLUSHALL` 역시 비동기 방식으로 동작이 가능함.
  * RDB-AOF 혼합 포맷 사용 가능.
  * `MEMORY` 명령어 추가 : 메모리 이슈 확인용 - `MEMORY DOCTOR` , `MEMORY HELP`
  * Redis Cluster가 이제 도커와 호환됨



* [SwifterSwift](http://swiftierswift.com/) : Swift extensions. 자바스크립트의 underscore, lodash 같은 느낌이랄까?
* [A Beginner’s Guide to the True Order of SQL Operations](https://blog.jooq.org/2016/12/09/a-beginners-guide-to-the-true-order-of-sql-operations/?utm_source=dbweekly&utm_medium=email)
  * FROM이 정의되지 않으면 auto-complete 이 동작할 수 없다. 사람이 생각하는 order와 SQL의 order가 다르다.
  * `FROM` : 논리적으로 `FROM` 이 항상 먼저다. 또한 모든 `JOIN` 구문은 사실상 `FROM` 구문의 일부이다. `JOIN`은 [relational algebra](https://en.wikipedia.org/wiki/Relational_algebra)의 operator이다. 따라서 `+`, `-` 같은 수학의 operator처럼 `JOIN`은 독립적인 구문이 아니다.
  * `WHERE` : (논리적으로) `FROM` 구문을 통해서 모든 테이블들을 읽어온 다음에, `WHERE`를 통해서 데이터를 필터링할 수 있다.
  * `GROUP BY` : `WHERE` 구문으로 남겨진 열들을 `GROUP BY` expression 에 의해 같은 값을 가진 그룹으로 묶게 된다. 자바라면 `Map<String, List<Row>>` 와 같은 형태의 데이터가 남는다고 볼 수 있다. `GROUP BY` 구문을 명시하면, 실제 rows 에는 그룹 column 들만 남게 되고, 나머지 column 들은 리스트에만 남게 된다. 이 리스트에 남은 컬럼들은, aggregate functions 만 조회하고, 사용할 수 있게 된다.
  * **`aggregations`** : 이것이 중요한데, 문법적으로 어디에 aggregate function 을 배치하던간에, (`SELECT` 구문에서든, `ORDER BY` 구문에서든) 이 시점이 실제로 aggregate function 이 수행되는 곳이다. `GROUP BY` 직후. (논리적으로만 그렇다는 이야기이다.) 그렇기 때문에 `WHERE` 구문에는 aggregate function 을 넣을 수 없다. 아직 값을 조회할 수 없는 상태이기 때문이다. (`WHERE` 구문이 논리적으로 aggregate function 보다 먼저 수행된다.) Aggregate function 들은 각 그룹의 "list"에 넣어둔 컬럼들을 조회할 수 있다. aggregation이 끝나면 이 "list"는 사라지고, 더 이상 사용할 수 없게 된다. 만약 `GROUP BY` 구문이 없다면, 모든 rows를 담고 있는, 아무 키도 담고 있지 않은 하나의 거대한 그룹만이 남을 것이다.
  * `HAVING` : `HAVING`은 `GROUP BY` 이후에 수행되기 때문에, `GROUP BY` 컬럼에 없는 값은 조회할 수 없다.
  * `WINDOW` : 만약 이 기능을 사용한다면, 이 곳이 모든 것이 계산되는 시점이다. 딱 지금뿐이다. 논리적으로 모든 aggregate functions를 수행했기 때문에, window function 에서는 aggregate functions를 nesting 할 수 있다. => 더 체크가 필요하다. 이게 뭔지.
  * `SELECT` : 드디어.. 이제 우리는 위 모든 구문들을 통해서 만들어진 rows를 사용할 수 있고, `SELECT`를 통해서 새로운 rows / tuples 를 만들어 낼 수 있다. 이미 계산한 window functions, aggregate functions, 그룹핑된 컬럼들을 사용할 수 있다. `count(*)` 함수가 `SELECT`안에 있지만 실제로는 이미 예전에 계산되고 여기서 레퍼런스할 뿐이다.
  * `DISTINCT` : `DISTINCT`는 `SELECT` 이후에 실행된다. 문법적으로는 비록 `SELECT` 컬럼 리스트 전에 기술되지만 말이다.
  * `UNION`, `INTERSECT`, `EXCEPT` : `UNION`은 두 개의 sub-query 를 연결해주는 operator이다.
  * `ORDER BY` : 이제서야 결과를 줄세울 수 있다.
  * `OFFSET` : 쓰지 말아라.
  * `LIMIT`, `FETCH`, `TOP` 



**NEXT**

* relational algebra?


* [Probably the Coolest SQL Feature: Window Functions](https://blog.jooq.org/2013/11/03/probably-the-coolest-sql-feature-window-functions/)
* [KEYSET pagination](https://blog.jooq.org/2014/08/06/join-the-no-offset-movement/)
* ​