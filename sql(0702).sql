1. 
create table 도서 (번호 number not null, 이름 varchar2(20), 출판사 varchar2(20), 가격 number);

insert into 도서 values (1,'행복의 역사','굿스포츠',7000);
insert into 도서 values (2,'행복아는 여자','나무수',13000);
insert into 도서 values (3,'행복의 이해','행복미디어',22000);
insert into 도서 values (4,'사랑 바이블','행복미디어',35000);
insert into 도서 values (5,'행복의 조건','행복',10040);

2.
select * from 도서;

3.
select 이름, 출판사, 가격 from 도서 where 가격 < 200000;

4.
select 이름, 출판사 from 도서 where 이름 like '%행복%';

5.
select 이름, 출판사 from 도서 where 이름 like '%행복%' or 가격 >= 25000;

6.
update 도서 set 이름= '행복 바이블' where 이름 = '사랑 바이블';
select 이름 from 도서;

7.
select count(*) from 도서;


8.
select 이름, 출판사 from 도서 where 출판사 ='행복미디어';

9.
#1
alter table 도서 rename column 번호 to 순서;
select 순서, case when 순서 = 1 then '하나' when 순서=2 then '두나' when 순서=3  then '세나' else '기타' end as 담당자 from 도서;
#2
select 번호 as 순서 case when 1 then '하나' when 2 then '두나' when 3  then '세나' else '기타' end as 담당자 from 도서;

10.
#1
select * from 도서 where 출판사 like '%행복%' and rownum<3;
#2
select * from 도서 where 출판사 like '%행복%' and rownum<=2;
