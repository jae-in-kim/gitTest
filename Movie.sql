--- �����Ҳ�����----



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

COMMENT ON TABLE MOVIE IS '��ȭ ����'
/

COMMENT ON COLUMN MOVIE.movie_id IS '��ȭ ��ȣ'
/

COMMENT ON COLUMN MOVIE.movie_title IS '��ȭ ����'
/

COMMENT ON COLUMN MOVIE.movie_director IS '����'
/

COMMENT ON COLUMN MOVIE.movie_actor IS '�ֿ� ���'
/

COMMENT ON COLUMN MOVIE.movie_age IS '���� ���'
/

COMMENT ON COLUMN MOVIE.movie_openday IS '���� �Ͻ�'
/

COMMENT ON COLUMN MOVIE.movie_running_time IS '����Ÿ��'
/

COMMENT ON COLUMN MOVIE.movie_summary IS '��ȭ �ٰŸ�'
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

COMMENT ON TABLE MOVIE_SCHEDULE IS '�� ����'
/

COMMENT ON COLUMN MOVIE_SCHEDULE.screen_no IS '�� ���� ��ȣ'
/

COMMENT ON COLUMN MOVIE_SCHEDULE.screen_date IS '�� ����'
/

COMMENT ON COLUMN MOVIE_SCHEDULE.screen_time IS '�� �ð�'
/

COMMENT ON COLUMN MOVIE_SCHEDULE.movie_id IS '��ȭ ��ȣ'
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

COMMENT ON TABLE CUSTOMERS IS '�� ����'
/

COMMENT ON COLUMN CUSTOMERS.customer_no IS 'ȸ�� ��ȣ'
/

COMMENT ON COLUMN CUSTOMERS.customer_id IS 'UNIQUE'
/

COMMENT ON COLUMN CUSTOMERS.customer_pw IS 'ȸ�� pw'
/

COMMENT ON COLUMN CUSTOMERS.customer_name IS 'ȸ�� �̸�'
/

COMMENT ON COLUMN CUSTOMERS.customer_phone_no IS 'ȸ�� ��ȭ��ȣ'
/

COMMENT ON COLUMN CUSTOMERS.customer_birth IS '�������'
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

COMMENT ON TABLE SEAT IS '�¼�'
/

COMMENT ON COLUMN SEAT.seat_no IS '�¼� ��ȣ'
/

COMMENT ON COLUMN SEAT.screen_no IS '�� ���� ��ȣ'
/

COMMENT ON COLUMN SEAT.movie_id IS '��ȭ ��ȣ'
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

COMMENT ON TABLE TICKETING IS '���ų���'
/

COMMENT ON COLUMN TICKETING.booking_no IS '���� ��ȣ'
/

COMMENT ON COLUMN TICKETING.customer_no IS 'ȸ�� ��ȣ'
/

COMMENT ON COLUMN TICKETING.ticket_price IS 'Ƽ�� ����'
/

COMMENT ON COLUMN TICKETING.ticket_no IS 'Ƽ�� �ż�'
/

COMMENT ON COLUMN TICKETING.seat_no IS '�¼� ��ȣ'
/

COMMENT ON COLUMN TICKETING.screen_no IS '�� ���� ��ȣ'
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

COMMENT ON TABLE PAYMENT IS '����'
/

COMMENT ON COLUMN PAYMENT.booking_no IS '���� ��ȣ'
/

COMMENT ON COLUMN PAYMENT.booking_date IS '���� ����'
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

COMMENT ON TABLE ADMIN IS '������'
/

COMMENT ON COLUMN ADMIN.admin_id IS '������ id'
/

COMMENT ON COLUMN ADMIN.admin_pw IS '������ pw'
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
        
        


-- ������

INSERT INTO admin VALUES ('abc', '1234');


-- ������

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'abcd', '1234', 'LeeYuri', '01012341234', '19940204');

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'abc', '1234', 'KimJaein', '01045644564', '19900704');

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'hahaha', 'abcd123', 'BaekKyoungyun', '01011112222', '19830103');
 
INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'hohoho', 'aaa111', 'KimJaehwan', '01044331112', '19640507');

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'hihihi', '4564', 'LeeYoungchan', '01064554433', '20000101');

INSERT INTO CUSTOMERS VALUES (customer_seq.nextval, 'hehehe', '1111', 'KimIntae', '01014123213', '19880508');


-- ��ȭ����

INSERT INTO MOVIE VALUES (movie_seq.nextval, '�����3', '�ȼҴ� ���', '�ι�Ʈ �ٿ�� �ִϾ�', 15, '190302', 130, '���� �ְ� ���� Ÿ�뽺�� �¼� ������ ����� �ɸ� ����� �������µ�...' );

INSERT INTO MOVIE VALUES (movie_seq.nextval, '��', '�ڴ���', '���ؿ�', 15, '190405', 150, '����� ���Ǹ�, ���� ����� �������.');

INSERT INTO MOVIE VALUES (movie_seq.nextval, '�', '���� ��', '����Ÿ ����', 19, '190105', 140, '�츮�� �����ΰ�?  ����, �ƺ�, ��, �Ƶ�...' );

INSERT INTO MOVIE VALUES (movie_seq.nextval, '����', '������', '���汸', 12, '190223', 110,'2014�� 4�� ����... ������ �츮���� �̾߱�');

INSERT INTO MOVIE VALUES (movie_seq.nextval, '������', '���� ��ÿ', '�ٸ��� �ι���', 12, '990703', 110, '���� ����� ����� ��ٸ��� �׳�� �ʹ� Ư���� ����� �η��� ���� 
 �� ���� �θǽ�');

INSERT INTO MOVIE VALUES (movie_seq.nextval, '������ �߾�', '����ȣ', '�۰�ȣ', 15, '030502', 130, '����� ���� ��� �ִ°� ��ġ���� ��� �;���. ');



-- �� ����

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



-- ���ų���



-- �¼�




-- ����

commit






