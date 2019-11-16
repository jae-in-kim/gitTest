--- 변경할꺼지롱----



CREATE TABLE movie
(
	movie_id			NUMBER			NOT NULL,
	movie_title			VARCHAR2(100)	NOT NULL,
	movie_director		VARCHAR2(100)	NOT NULL,
	movie_actor     	VARCHAR2(100)	NOT NULL,
	movie_age			NUMBER			NOT NULL,
	movie_openday		DATE			NOT NULL,
	movie_running_time	NUMBER			NOT NULL,
	movie_summary		VARCHAR2(1000)	NOT NULL,
		
	CONSTRAINT movie_pk PRIMARY KEY(movie_id)
)	
/

CREATE SEQUENCE MOVIE_SEQ
START WITH 1
INCREMENT BY 1;
/



--DROP SEQUENCE MOVIE_SEQ;
/

COMMENT ON TABLE MOVIE IS '영화 정보'
/

COMMENT ON COLUMN MOVIE.movie_id IS '영화 번호'
/

COMMENT ON COLUMN MOVIE.movie_title IS '영화 제목'
/

COMMENT ON COLUMN MOVIE.movie_director IS '감독'
/

COMMENT ON COLUMN MOVIE.movie_actor IS '주연 배우'
/

COMMENT ON COLUMN MOVIE.movie_age IS '관람 등급'
/

COMMENT ON COLUMN MOVIE.movie_openday IS '개봉 일시'
/

COMMENT ON COLUMN MOVIE.movie_running_time IS '러닝타임'
/

COMMENT ON COLUMN MOVIE.movie_summary IS '영화 줄거리'
/



-- MOVIE_SCHEDULE Table Create SQL

CREATE TABLE movie_schedule
(
	screen_no		NUMBER			NOT NULL,
	screen_date		DATE			NOT NULL,
	screen_time		DATE			NOT NULL,
	movie_id		NUMBER			NOT NULL,
	CONSTRAINT movie_schedule_pk PRIMARY KEY(screen_no)
)
/

CREATE SEQUENCE MOVIE_SCHEDULE_SEQ
START WITH 1
INCREMENT BY 1;
/

--DROP SEQUENCE MOVIE_SCHEDULE_SEQ;
/

COMMENT ON TABLE MOVIE_SCHEDULE IS '상영 일정'
/

COMMENT ON COLUMN MOVIE_SCHEDULE.screen_no IS '상영 일정 번호'
/

COMMENT ON COLUMN MOVIE_SCHEDULE.screen_date IS '상영 일자'
/

COMMENT ON COLUMN MOVIE_SCHEDULE.screen_time IS '상영 시간'
/

COMMENT ON COLUMN MOVIE_SCHEDULE.movie_id IS '영화 번호'
/

ALTER TABLE MOVIE_SCHEDULE
    ADD CONSTRAINT FK_MOVIE_SCHEDULE_movie_id_MOV FOREIGN KEY (movie_id)
        REFERENCES MOVIE (movie_id)
/


-- CUSTOMER Table Create SQL

CREATE TABLE customers
(
	customer_no			NUMBER			NOT NULL,
	customer_id			VARCHAR2(20)	NOT NULL,
	customer_pw			VARCHAR2(20)	NOT NULL,
	customer_name		VARCHAR2(20)	NOT NULL,
	customer_phone_no	VARCHAR2(20)	NOT NULL,
	customer_birth		DATE			NOT NULL,
	CONSTRAINT customer_pk PRIMARY KEY (customer_no),
	CONSTRAINT customer_id_uk UNIQUE   (customer_id)
)	
/

CREATE SEQUENCE CUSTOMER_SEQ
START WITH 1
INCREMENT BY 1;
/


--DROP SEQUENCE CUSTOMER_SEQ;
/

COMMENT ON TABLE CUSTOMERS IS '고객 정보'
/

COMMENT ON COLUMN CUSTOMERS.customer_no IS '회원 번호'
/

COMMENT ON COLUMN CUSTOMERS.customer_id IS 'UNIQUE'
/

COMMENT ON COLUMN CUSTOMERS.customer_pw IS '회원 pw'
/

COMMENT ON COLUMN CUSTOMERS.customer_name IS '회원 이름'
/

COMMENT ON COLUMN CUSTOMERS.customer_phone_no IS '회원 전화번호'
/

COMMENT ON COLUMN CUSTOMERS.customer_birth IS '생년월일'
/



-- SEAT Table Create SQL
CREATE TABLE SEAT
(
    seat_no         VARCHAR2(20)    NOT NULL, 
    screen_no       NUMBER          NOT NULL, 
    movie_id        NUMBER          NOT NULL, 
    seat_reserve    CHAR(1)         NOT NULL 
)
/

COMMENT ON TABLE SEAT IS '좌석'
/

COMMENT ON COLUMN SEAT.seat_no IS '좌석 번호'
/

COMMENT ON COLUMN SEAT.screen_no IS '상영 일정 번호'
/

COMMENT ON COLUMN SEAT.movie_id IS '영화 번호'
/

COMMENT ON COLUMN SEAT.seat_reserve IS 'check y/n'
/

ALTER TABLE SEAT
    ADD CONSTRAINT FK_SEAT_screen_no_MOVIE_SCHEDU FOREIGN KEY (screen_no)
        REFERENCES MOVIE_SCHEDULE (screen_no)
/

ALTER TABLE SEAT
    ADD CONSTRAINT FK_SEAT_movie_id_MOVIE_movie_i FOREIGN KEY (movie_id)
        REFERENCES MOVIE (movie_id)
/

ALTER TABLE SEAT
	ADD CONSTRAINT seat_reserve_chk CHECK(seat_reserve IN ('Y', 'N', 'y', 'n'));

	
-- TICKETING Table Create SQL
CREATE TABLE TICKETING
(
    booking_no      NUMBER          NOT NULL, 
    customer_no     NUMBER          NOT NULL, 
    ticket_price    NUMBER          NOT NULL, 
    ticket_no       NUMBER          NOT NULL, 
    seat_no         VARCHAR2(20)    NOT NULL, 
    screen_no       NUMBER          NOT NULL
)
/


CREATE SEQUENCE TICKETING_SEQ
START WITH 1
INCREMENT BY 1;
/

--DROP SEQUENCE TICKETING_SEQ;
/

COMMENT ON TABLE TICKETING IS '예매내역'
/

COMMENT ON COLUMN TICKETING.booking_no IS '예매 번호'
/

COMMENT ON COLUMN TICKETING.customer_no IS '회원 번호'
/

COMMENT ON COLUMN TICKETING.ticket_price IS '티켓 가격'
/

COMMENT ON COLUMN TICKETING.ticket_no IS '티켓 매수'
/

COMMENT ON COLUMN TICKETING.seat_no IS '좌석 번호'
/

COMMENT ON COLUMN TICKETING.screen_no IS '상영 일정 번호'
/

ALTER TABLE TICKETING
    ADD CONSTRAINT FK_TICKETING_screen_no_MOVIE_S FOREIGN KEY (screen_no)
        REFERENCES MOVIE_SCHEDULE (screen_no)
/

ALTER TABLE TICKETING
    ADD CONSTRAINT FK_TICKETING_customer_no_CUSTO FOREIGN KEY (customer_no)
        REFERENCES CUSTOMERS (customer_no)
/	

-- PAYMENT Table Create SQL
CREATE TABLE PAYMENT
(
    booking_no         NUMBER          NOT NULL, 
    booking_date      DATE    DEFAULT SYSDATE, 
    payment_confirm    CHAR(1)         NULL   
)
/

COMMENT ON TABLE PAYMENT IS '결제'
/

COMMENT ON COLUMN PAYMENT.booking_no IS '예매 번호'
/

COMMENT ON COLUMN PAYMENT.booking_date IS '결제 일자'
/

COMMENT ON COLUMN PAYMENT.payment_confirm IS 'check y/n'
/

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_booking_no_TICKETIN FOREIGN KEY (booking_no)
        REFERENCES TICKETING (booking_no)
/
	
ALTER TABLE payment
	ADD CONSTRAINT payment_confirm_chk CHECK(payment_confirm IN ('Y', 'N', 'y', 'n'))

/


-- ADMIN Table Create SQL
CREATE TABLE ADMIN
(
    admin_id    VARCHAR2(20)    NOT NULL, 
    admin_pw    VARCHAR2(20)    NOT NULL, 
    CONSTRAINT ADMIN_PK PRIMARY KEY (admin_id)
)
/

COMMENT ON TABLE ADMIN IS '관리자'
/

COMMENT ON COLUMN ADMIN.admin_id IS '관리자 id'
/

COMMENT ON COLUMN ADMIN.admin_pw IS '관리자 pw'
/



INSERT INTO ADMIN
VALUES ('abc', '1234');

INSERT INTO CUSTOMERS
VALUES (1, 'abc', '1234', 'abcc', '010-1234-1234', '92/11/10' );

INSERT INTO CUSTOMERS VALUES (1, 'abc','qwe','yuri','01012341234');

INSERT INTO ADMIN VALUES('abcde','1234');

ALTER TABLE ticketing
	ADD (movie_title VARCHAR2(100) NOT NULL);
	
ALTER TABLE ticketing
    ADD CONSTRAINT FK_ticketing_movie_title FOREIGN KEY (movie_title)
        REFERENCES movie (movie_title);
        
        


-- 관리자

INSERT INTO admin VALUES ('abc', '1234');


-- 고객정보

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'abcd', '1234', 'LeeYuri', '01012341234', '19940204');

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'abc', '1234', 'KimJaein', '01045644564', '19900704');

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'hahaha', 'abcd123', 'BaekKyoungyun', '01011112222', '19830103');
 
INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'hohoho', 'aaa111', 'KimJaehwan', '01044331112', '19640507');

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'hihihi', '4564', 'LeeYoungchan', '01064554433', '20000101');

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'hehehe', '1111', 'KimIntae', '01014123213', '19880508');


-- 영화정보

INSERT INTO MOVIE VALUES (movie_seq.nextval, '어벤져스3', '안소니 루소', '로버트 다우니 주니어', 15, '190302', 130, '역대 최강 빌런 타노스에 맞서 세계의 운명이 걸린 대결이 펼쳐지는데...' );

INSERT INTO MOVIE VALUES (movie_seq.nextval, '돈', '박누리', '류준열', 15, '190405', 150, '흙수저 증권맨, 돈의 향락에 빠져들다.');

INSERT INTO MOVIE VALUES (movie_seq.nextval, '어스', '조던 필', '루피타 뇽오', 19, '190105', 140, '우리는 누구인가?  엄마, 아빠, 딸, 아들...' );

INSERT INTO MOVIE VALUES (movie_seq.nextval, '생일', '이종언', '설경구', 12, '190223', 110,'2014년 4월 이후... 남겨진 우리들의 이야기');

INSERT INTO MOVIE VALUES (movie_seq.nextval, '노팅힐', '로저 미첼', '줄리아 로버츠', 12, '990703', 110, '아주 평범한 사랑을 기다리는 그녀와 너무 특별한 사랑이 두려운 그의 
 꿈 같은 로맨스');

INSERT INTO MOVIE VALUES (movie_seq.nextval, '살인의 추억', '봉준호', '송강호', 15, '030502', 130, '당신은 지금 어디에 있는가 미치도록 잡고 싶었다. ');



-- 상영 일정

insert into movie_schedule(screen_no, screen_date, screen_time, movie_id)
values(MOVIE_SCHEDULE_SEQ.nextval, '19/01/01',to_date('13:30', 'HH24:MI'),1);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190426', to_date('1000', 'HH24:MI'), 1);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190426', to_date('1400', 'HH24:MI'), 3);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190426', to_date('1700', 'HH24:MI'), 6);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190427', to_date('1200', 'HH24:MI'), 4);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190427', to_date('1700', 'HH24:MI'), 2);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190428', to_date('1100', 'HH24:MI'), 1);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190428', to_date('1600', 'HH24:MI'), 1)
;
INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190429', to_date('1300', 'HH24:MI'), 5);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190429', to_date('1700', 'HH24:MI'), 2);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190430', to_date('0900', 'HH24:MI'), 1);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190501', to_date('1200', 'HH24:MI'), 2);

INSERT INTO MOVIE_SCHEDULE VALUES (movie_schedule_seq.nextval, '190501', to_date('1800', 'HH24:MI'), 3);



-- 예매내역



-- 좌석




-- 결제

commit






