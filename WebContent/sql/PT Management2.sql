-- 트레이너 회원
CREATE TABLE `trainer` (
	`t_no`     INT auto_increment NOT NULL, 	   -- 트레이너번호
	`t_id`           VARCHAR(20)  NOT NULL UNIQUE, -- 아이디
	`t_nick`         VARCHAR(20)  NOT NULL UNIQUE, -- 닉네임
	`t_pw`           VARCHAR(200) NOT NULL, 	   -- 비밀번호
	`t_email`        VARCHAR(100) NULL, 		   -- 이메일
	`t_emailhash`    VARCHAR(64)  NULL,     	   -- 이메일해시
	`t_emailchecked` BOOLEAN      NULL,     	   -- 이메일확인
	`t_phone`        VARCHAR(20)  NOT NULL, 	   -- 휴대폰번호
	`t_joindate`     DATE         NOT NULL, 	   -- 가입일
	`t_major`        VARCHAR(50)  NOT NULL, 	   -- 전문분야
	`t_addr1`        VARCHAR(255) NOT NULL, 	   -- 주소
	`t_addr2`        VARCHAR(255) NOT NULL, 	   -- 상세주소
	`t_originP`  	 VARCHAR(200) NULL,   		   -- 원본파일
	`t_realP`	 	 VARCHAR(200) NULL,            -- 실제파일
	`t_etc`          TEXT         NULL,		 	   -- 자기소개
	`t_cost1`        VARCHAR(100) NULL,     	   -- 가격1
	`t_cost2`        VARCHAR(100) NULL,     	   -- 가격2
	`t_cost3`        VARCHAR(100) NULL,     	   -- 가격3
	`t_state`		 VARCHAR(2)	  NULL,     	   -- 탈퇴여부
	primary key (t_no)
);

-- 일반회원
CREATE TABLE `user` (
	`u_no` 	   INT auto_increment NOT NULL, 	   -- 사용자번호
	`u_id`           VARCHAR(20)  NOT NULL UNIQUE, -- 아이디
	`u_nick`         VARCHAR(20)  NOT NULL UNIQUE, -- 닉네임
	`u_pw`           VARCHAR(200) NOT NULL, 	   -- 비밀번호
	`u_email`        VARCHAR(100) NULL,			   -- 이메일
	`u_emailhash`    VARCHAR(64)  NULL,    		   -- 이메일해시
	`u_emailchecked` BOOLEAN      NULL,    		   -- 이메일확인
	`u_phone`        VARCHAR(20)  NOT NULL, 	   -- 휴대폰번호
	`u_joindate`     DATE         NOT NULL, 	   -- 가입일
	`u_check`        VARCHAR(2)   NOT NULL, 	   -- 관리자여부
	`u_gender`       VARCHAR(2)   NULL,     	   -- 성별
	`u_state`        VARCHAR(2)   NULL,     	   -- 탈퇴여부
	primary key (u_no)
);

-- 트레이너의 회원
CREATE TABLE `pt` (
	`p_no` 	    INT auto_increment NOT NULL, -- 회원관리번호
	`t_no`      INT    			   NOT NULL, -- 트레이너번호
	`u_no`      INT 			   NOT NULL, -- 사용자번호
	`p_try`		INT				   NOT NULL, -- 신청회차
	`p_state`   CHAR 			   NOT NULL, -- 회원관리상태
	`p_send`    DATE 			   NULL,     -- 수락신청일자
	`p_ok`      DATE 			   NULL,     -- 수락승인일자
	`p_end`     DATE 			   NULL,     -- PT완료일자
	`p_cnt`     INT    			   NOT NULL, -- PT총회차
	`p_score`   INT  			   NULL,     -- 만족도
	`p_comment` TEXT   			   NULL,     -- 기타사항
	primary key (p_no)
);

-- select avg(p_score) as p_score from pt where t_no = 1
-- where p_state = 'b' or p_stat = 'c'

-- select avg(p_score) as p_score from pt where t_no = 1
-- where p_state in ('b','c')

-- select ifnull(avg(p_score),0) as p_score from pt where t_no = 1

-- select t_no,ifnull(avg(p_score),0) as p_score from pt
-- group by t_no 

-- PT회차
CREATE TABLE `round` (
	`r_no` 	 INT auto_increment NOT NULL, -- 회차관리번호
	`t_no`   INT                NOT NULL, -- 트레이너번호
	`u_no`   INT                NOT NULL, -- 사용자번호
	`p_try`	 INT				NOT NULL, -- 신청회차
	`r_ct`   INT				NOT NULL, -- 회차번호
	`r_date` DATE               NOT NULL, -- PT날짜
	primary key (r_no)
);
drop table exercise;
-- 운동기록
CREATE TABLE `exercise` (
	`e_no`   INT auto_increment NOT NULL, -- 운동관리번호
	`t_no`   INT                NOT NULL, -- 트레이너번호
	`u_no`   INT                NOT NULL, -- 사용자번호
	`p_try`	 INT				NOT NULL, -- 신청회차
	`r_ct`   INT				NOT NULL, -- 회차번호
	`e_name` VARCHAR(100)       NOT NULL, -- 운동명
	`e_set`  INT  default 0          NULL,     -- 세트
	`e_cnt`  INT  default 0              NULL,     -- 횟수
	`e_kg`   INT  default 0              NULL,     -- 무게
	`e_time` INT  default 0              NULL,     -- 소요시간
	`e_part` VARCHAR(50)        NULL,     -- 자극부위
	`e_rest` INT   default 0             NULL,     -- 세트간휴식
	primary key (e_no)
);