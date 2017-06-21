create table t_board(
no number(5) primary key,
title varchar2(200) not null
, writer varchar2(200) not null
, content varchar2(2000)
, view_cnt number(5) default 0
, reg_date date default sysdate
);

select * from t_board

create sequence seq_t_board_no;

insert into t_board (no, title, writer, content) values
(seq_t_board_no.nextval, '����', 'ȫ�浿', '����');

insert into t_board (no, title, writer, content) values
(seq_t_board_no.nextval, '����2', '�ƹ���', '����2');

create table t_member(
id varchar2(20) primary key,
name varchar2(20) not null,
password varchar2(20) not null,
email_id varchar2(30),
email_domain varchar2(20),
tel1 char(3),
tel2 char(4),
tel3 char(4),
post char(7),
basic_addr varchar2(200),
detail_addr varchar2(200),
type char(1) default 'U',
reg_date date default sysdate
);

update t_member set email_domain='naver.com' where name='fff' 

select * from t_member

<!-- ������ ĳ�� ���ּ� �Ϸ� ���������� 20���� �����ϴ°� ���� -->
alter sequence seq_t_board_no nocache;

update t_member set name='�̸�1' where id='id1'
update t_member set name='�̸�12', tel1='010', tel2='2222', tel3='1111'  where id='id1'

insert into t_member (id, name, password, type) values ('admin', 'admin', 'admin', 'S')
insert into t_member (id, name, password, type) values ('user', 'user', 'user', 'U')


select * from (select * from t_board order by reg_date desc) where rownum>=1 and rownum<=3

create sequence seq_t_board_file_no;

create table t_board_file(
	no      		number(10) primary key,
	board_no		number(5) not null,
	file_ori_name 	varchar2(100),
	file_save_name	varchar2(100),
	file_size		number(10),
	constraint t_board_file_no_fk foreign key(board_no)
	references t_board(no) on delete cascade
);

-- �������� ����
-- on delete / on update �ΰ��� ����
-- cascade / set null / noaction ������ ����
alter table t_board_file
add constraint t_board_file_no_fk foreign key(board_no)
references t_board(no) on delete cascade;

-- �������� ����
alter table t_board_file
drop constraint t_board_file_no_fk

select * from t_board_file



select *
from (
	select rownum r, s.title, s.writer, s.content, s.view_cnt, s.reg_date
	from 
		(select *
		from t_board
		order by reg_date desc) s 
	where rownum<6) a
where a.r>3





select *  from (select rownum r, s.title, s.writer, s.content, s.view_cnt, s.reg_date         from (select * from t_board order by reg_date desc) s         where rownum<=6) a  where a.r>3

