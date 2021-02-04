-- ����� ���̺�
create table User
(
	u_no       		int auto_increment				comment '����ڹ�ȣ', -- ����ڹ�ȣ
	u_id       		varchar(20) not null unique		comment '���̵�',    -- ���̵�
	u_nick     		varchar(20) not null unique		comment '�г���',    -- �г���
	u_pw       		varchar(200)not null 			comment '��й�ȣ',   -- ��й�ȣ
	u_email    		varchar(100)not null unique		comment '�̸���',    -- �̸���
	u_emailhash		varchar(64)						comment '�̸����ؽ�',  -- �̸����ؽ�
	u_emailchecked	boolean							comment '�̸���Ȯ��',  -- �̸���Ȯ��
	u_phone    		varchar(20) not null unique		comment '�޴�����ȣ',  -- �޴�����ȣ
	u_joindate 		date        not null			comment '������',    -- ������
	u_check    		int         not null			comment 'ȸ������',   -- ȸ������
	u_gender   		varchar(2)	not null			comment '����',     -- ����
	u_state    		varchar(2)						comment '��������',   -- �������� Ż�� 
	primary key (u_no)
);

-- Ʈ���̳� ���̺�
create table Trainer
(
	t_no    int	auto_increment		comment 'Ʈ���̳ʹ�ȣ', -- Ʈ���̳ʹ�ȣ
	u_no	int,
	t_major varchar(50)  not null	comment '�����о�',    -- �����о�
	t_addr1 varchar(50)  not null	comment '������ȣ',    -- ������ȣ
	t_addr2 varchar(255) not null	comment '�ּ�',       -- �ּ�
	t_addr3 varchar(255) not null	comment '���ּ�',    -- ���ּ�
	t_photo varchar(200) not null	comment '÷�λ���',    -- ÷�λ���
	t_score double					comment '���������',   -- ���������
	t_etc   text		 not null	comment 'Ʈ���̳� ��Ÿ����', -- Ʈ���̳� ��Ÿ����
	t_cost1 int						comment '����1',      -- ����1
	t_cost2 int						comment '����2',      -- ����2
	t_cost3 int						comment '����3',      -- ����3
	primary key (t_no),
	foreign key (u_no) references User (u_no)
);

-- ȸ�� ���̺�
create table Members
(
	m_no int auto_increment	comment 'ȸ����ȣ', -- ȸ����ȣ
	u_no int ,
	primary key(m_no),
	foreign key (u_no) references User (u_no)
);

-- ȸ������ ���̺�
create table PT
(
	p_no      int  auto_increment	comment 'ȸ��������ȣ', -- ȸ��������ȣ
	t_no      int,
	m_no	  int,
	p_state   char	not null		comment 'ȸ����������', -- ȸ����������
	p_send    date					comment '������û����', -- ������û����
	p_ok   	  date					comment '������������', -- ������������
	p_end	  date					comment 'PT�Ϸ�����',  -- PT�Ϸ�����
	p_cnt	  int   not null		comment 'PT��ȸ��',    -- PT��ȸ��
	p_score   double				comment '������',     -- ������
	p_comment text					comment 'ȸ�����λ���', -- ȸ�����λ���
	primary key (p_no),
	foreign key (t_no) references Trainer (t_no),
	foreign key (m_no) references Members (m_no)
);

-- PTȸ�� ���̺�
create table Count
(
	c_no   int  auto_increment	comment 'PTȸ����ȣ', -- PTȸ����ȣ
	p_no   int ,
	t_no   int ,
	c_date date not null		comment 'PT��¥',    -- PT��¥
	primary key (c_no),
	foreign key (p_no) references PT (p_no),
	foreign key (t_no) references Trainer (t_no)
);

-- ���� ���̺�
create table Exercise
(
	e_no   int auto_increment		comment '�������ȣ', -- �������ȣ
	p_no   int ,
	c_no   int ,
	t_no   int ,
	e_name varchar(100)	not null	comment '���',	 -- ���
	e_set  int						comment '��Ʈ',    -- ��Ʈ
	e_cnt  int						comment 'Ƚ��',    -- Ƚ��
	e_kg   int						comment '����',    -- ����
	e_time int						comment '�ҿ�ð�',  -- �ҿ�ð�
	e_part varchar(50)				comment '�ڱغ���',  -- �ڱغ���
	e_rest int						comment '��Ʈ���޽�', -- ��Ʈ���޽�
	primary key (e_no),
	foreign key (p_no) references PT (p_no),
	foreign key (c_no) references Count (c_no),
	foreign key (t_no) references Trainer (t_no)
);