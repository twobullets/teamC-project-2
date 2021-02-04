-- Ʈ���̳� ȸ��
CREATE TABLE `trainer` (
	`t_no`     INT auto_increment NOT NULL, 	   -- Ʈ���̳ʹ�ȣ
	`t_id`           VARCHAR(20)  NOT NULL UNIQUE, -- ���̵�
	`t_nick`         VARCHAR(20)  NOT NULL UNIQUE, -- �г���
	`t_pw`           VARCHAR(200) NOT NULL, 	   -- ��й�ȣ
	`t_email`        VARCHAR(100) NULL, 		   -- �̸���
	`t_emailhash`    VARCHAR(64)  NULL,     	   -- �̸����ؽ�
	`t_emailchecked` BOOLEAN      NULL,     	   -- �̸���Ȯ��
	`t_phone`        VARCHAR(20)  NOT NULL, 	   -- �޴�����ȣ
	`t_joindate`     DATE         NOT NULL, 	   -- ������
	`t_major`        VARCHAR(50)  NOT NULL, 	   -- �����о�
	`t_addr1`        VARCHAR(255) NOT NULL, 	   -- �ּ�
	`t_addr2`        VARCHAR(255) NOT NULL, 	   -- ���ּ�
	`t_originP`  	 VARCHAR(200) NULL,   		   -- ��������
	`t_realP`	 	 VARCHAR(200) NULL,            -- ��������
	`t_etc`          TEXT         NULL,		 	   -- �ڱ�Ұ�
	`t_cost1`        VARCHAR(100) NULL,     	   -- ����1
	`t_cost2`        VARCHAR(100) NULL,     	   -- ����2
	`t_cost3`        VARCHAR(100) NULL,     	   -- ����3
	`t_state`		 VARCHAR(2)	  NULL,     	   -- Ż�𿩺�
	primary key (t_no)
);

-- �Ϲ�ȸ��
CREATE TABLE `user` (
	`u_no` 	   INT auto_increment NOT NULL, 	   -- ����ڹ�ȣ
	`u_id`           VARCHAR(20)  NOT NULL UNIQUE, -- ���̵�
	`u_nick`         VARCHAR(20)  NOT NULL UNIQUE, -- �г���
	`u_pw`           VARCHAR(200) NOT NULL, 	   -- ��й�ȣ
	`u_email`        VARCHAR(100) NULL,			   -- �̸���
	`u_emailhash`    VARCHAR(64)  NULL,    		   -- �̸����ؽ�
	`u_emailchecked` BOOLEAN      NULL,    		   -- �̸���Ȯ��
	`u_phone`        VARCHAR(20)  NOT NULL, 	   -- �޴�����ȣ
	`u_joindate`     DATE         NOT NULL, 	   -- ������
	`u_check`        VARCHAR(2)   NOT NULL, 	   -- �����ڿ���
	`u_gender`       VARCHAR(2)   NULL,     	   -- ����
	`u_state`        VARCHAR(2)   NULL,     	   -- Ż�𿩺�
	primary key (u_no)
);

-- Ʈ���̳��� ȸ��
CREATE TABLE `pt` (
	`p_no` 	    INT auto_increment NOT NULL, -- ȸ��������ȣ
	`t_no`      INT    			   NOT NULL, -- Ʈ���̳ʹ�ȣ
	`u_no`      INT 			   NOT NULL, -- ����ڹ�ȣ
	`p_try`		INT				   NOT NULL, -- ��ûȸ��
	`p_state`   CHAR 			   NOT NULL, -- ȸ����������
	`p_send`    DATE 			   NULL,     -- ������û����
	`p_ok`      DATE 			   NULL,     -- ������������
	`p_end`     DATE 			   NULL,     -- PT�Ϸ�����
	`p_cnt`     INT    			   NOT NULL, -- PT��ȸ��
	`p_score`   INT  			   NULL,     -- ������
	`p_comment` TEXT   			   NULL,     -- ��Ÿ����
	primary key (p_no)
);

-- select avg(p_score) as p_score from pt where t_no = 1
-- where p_state = 'b' or p_stat = 'c'

-- select avg(p_score) as p_score from pt where t_no = 1
-- where p_state in ('b','c')

-- select ifnull(avg(p_score),0) as p_score from pt where t_no = 1

-- select t_no,ifnull(avg(p_score),0) as p_score from pt
-- group by t_no 

-- PTȸ��
CREATE TABLE `round` (
	`r_no` 	 INT auto_increment NOT NULL, -- ȸ��������ȣ
	`t_no`   INT                NOT NULL, -- Ʈ���̳ʹ�ȣ
	`u_no`   INT                NOT NULL, -- ����ڹ�ȣ
	`p_try`	 INT				NOT NULL, -- ��ûȸ��
	`r_ct`   INT				NOT NULL, -- ȸ����ȣ
	`r_date` DATE               NOT NULL, -- PT��¥
	primary key (r_no)
);
drop table exercise;
-- ����
CREATE TABLE `exercise` (
	`e_no`   INT auto_increment NOT NULL, -- �������ȣ
	`t_no`   INT                NOT NULL, -- Ʈ���̳ʹ�ȣ
	`u_no`   INT                NOT NULL, -- ����ڹ�ȣ
	`p_try`	 INT				NOT NULL, -- ��ûȸ��
	`r_ct`   INT				NOT NULL, -- ȸ����ȣ
	`e_name` VARCHAR(100)       NOT NULL, -- ���
	`e_set`  INT  default 0          NULL,     -- ��Ʈ
	`e_cnt`  INT  default 0              NULL,     -- Ƚ��
	`e_kg`   INT  default 0              NULL,     -- ����
	`e_time` INT  default 0              NULL,     -- �ҿ�ð�
	`e_part` VARCHAR(50)        NULL,     -- �ڱغ���
	`e_rest` INT   default 0             NULL,     -- ��Ʈ���޽�
	primary key (e_no)
);