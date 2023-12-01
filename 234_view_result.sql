CREATE VIEW Top10SrcIPs AS
SELECT src_ip, COUNT(*) as attack_try_cnt
FROM logsample
GROUP BY src_ip
ORDER BY attack_try_cnt DESC
LIMIT 10;

/* 출발지top10 뷰생성*/

SELECT t.src_ip, dst_ip, SUM(l.attack_try_cnt) as total_attack_try_cnt
FROM Top10SrcIPs t
JOIN logsample l ON t.src_ip = l.src_ip
GROUP BY t.src_ip, dst_ip
order by total_attack_try_cnt desc;

/* 출발지top10의 목적지별 공격 수행수 출력(2번) */

CREATE VIEW Top20SrcIPs AS
SELECT src_ip, COUNT(*) as attack_count
FROM logsample
GROUP BY src_ip
ORDER BY attack_count DESC
LIMIT 20;
/* src_ip top 20  뷰 생성*/

SELECT l.attackname, SUM(l.attack_try_cnt) as total_attack_try_cnt
FROM logsample l
JOIN Top20SrcIPs t ON l.src_ip = t.src_ip
GROUP BY l.attackname;

/* attack_try_cnt 횟수 총합, 공격명 별 시도 회수 (4번) */

SELECT attackname, count(attackname) as cnt FROM logtest1.logsample
group by attackname
order by cnt desc;

/* 공격이름 별 공격 카운트 (레코드)*/

CREATE VIEW Top20AttackName AS
SELECT attackname, COUNT(*) as attack_count
FROM logsample
GROUP BY attackname
ORDER BY attack_count DESC
LIMIT 20;

/*공격이름 top20 뷰 생성*/

SELECT l.attackname, l.src_ip, COUNT(l.src_ip) as ip_count
FROM logsample l
JOIN Top20AttackName t ON l.attackname = t.attackname
GROUP BY l.attackname, l.src_ip
order by ip_count desc;

/* (3번) 공격상위20의 src_ip 의 공격 시도 회수 */

SELECT l.attackname, SUM(l.attack_try_cnt) as total_attack_try_cnt
FROM logsample l
JOIN Top20AttackName t ON l.attackname = t.attackname
GROUP BY l.attackname
order by total_attack_try_cnt desc;

/* 공격명 당 공격횟수총합 */