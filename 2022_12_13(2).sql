/*

*/
CREATE TABLE freeboard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT fb_name_nn NOT NULL,
    subject VARCHAR2(4000) CONSTRAINT fb_subject_nn NOT NULL,
    content CLOB CONSTRAINT fb_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT fb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER default 0,
    CONSTRAINT db_no_pk PRIMARY KEY(no)
);

DESC freeboard;

-- ������ �߰�
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(1,'ȫ�浿','CURD����','CURD����...','1234');
COMMIT;
SELECT * FROM freeboard;

INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(2,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(3,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(4,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(5,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(6,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(7,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(8,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(9,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(10,'ȫ�浿','CURD����','CURD����...','1234');
INSERT INTO freeboard(no,name,subject,content,pwd) VALUES(11,'ȫ�浿','CURD����','CURD����...','1234');

DESC zipcode;