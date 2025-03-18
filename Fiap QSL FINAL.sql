CREATE SEQUENCE sequencia_gastos
 START WITH 1
 INCREMENT by 1
 MAXVALUE 999999
 NOCACHE
 NOCYCLE;

CREATE TABLE gastos (
 cd_gastos NUMBER(6)
 DEFAULT sequencia_gastos.nextval NOT NULL,
 usuario_cd_usuario NUMBER(6) NOT NULL,
 vl_gasto NUMBER(7, 2) NOT NULL,
 dt_gasto DATE NOT NULL,
 ds_gasto VARCHAR2(30)
);
ALTER TABLE gastos ADD CONSTRAINT gastos_pk PRIMARY KEY ( cd_gastos );
CREATE SEQUENCE sequencia_investimentos
 START WITH 1
 INCREMENT by 1
 MAXVALUE 999999
 NOCACHE
 NOCYCLE;
CREATE TABLE investimento (
 cd_investimento NUMBER(6)
 DEFAULT sequencia_investimentos.nextval NOT NULL,
 tipo_investimento VARCHAR2(12) NOT NULL,
 nm_aplicacao VARCHAR2(40) NOT NULL,
 nm_banco VARCHAR2(40) NOT NULL,
 vl_investimento NUMBER(7, 2) NOT NULL,
 dt_realizacao_invest DATE NOT NULL,
 dt_vencimento DATE
);
ALTER TABLE investimento ADD CONSTRAINT investimento_pk PRIMARY KEY ( cd_investimento
);

CREATE SEQUENCE sequencia_meta
 START WITH 1
 INCREMENT by 1
 MAXVALUE 999999
 NOCACHE
 NOCYCLE;

CREATE TABLE obj_financeiro (
 cd_obj_fin NUMBER(6) DEFAULT sequencia_meta.nextval NOT NULL,
 usuario_cd_usuario NUMBER(6) NOT NULL,
 nm_objetivo VARCHAR2(20) NOT NULL,
 dt_atingir_obj DATE NOT NULL,
 vl_objetivo NUMBER(7, 2) NOT NULL,
 ds_objetivo VARCHAR2(30)
);
ALTER TABLE obj_financeiro ADD CONSTRAINT obj_financeiro_pk PRIMARY KEY ( cd_obj_fin );
CREATE SEQUENCE sequencia_participacao
 START WITH 1
 INCREMENT by 1
 MAXVALUE 999999
 NOCACHE
 NOCYCLE;
CREATE TABLE participacao (
 cd_participacao NUMBER(6)
 DEFAULT sequencia_participacao.nextval NOT NULL,
 investimento_cd_investimento NUMBER(6) NOT NULL,
 usuario_cd_usuario NUMBER(6) NOT NULL
);
ALTER TABLE participacao ADD CONSTRAINT participacao_pk PRIMARY KEY ( cd_participacao );
CREATE SEQUENCE sequencia_recebimentos
 START WITH 1
 INCREMENT by 1
 MAXVALUE 999999
 NOCACHE
 NOCYCLE;

CREATE TABLE recebimentos (
 cd_recebimento NUMBER(6)
 DEFAULT sequencia_recebimentos.nextval NOT NULL,
 usuario_cd_usuario NUMBER(6) NOT NULL,
 vl_recebimento NUMBER(7, 2) NOT NULL,
 dt_recebimento DATE NOT NULL,
 ds_recebimento VARCHAR2(30)
);
ALTER TABLE recebimentos ADD CONSTRAINT recebimentos_pk PRIMARY KEY ( cd_recebimento
);
CREATE SEQUENCE sequencia_usuario
 START WITH 1
 INCREMENT by 1
 MAXVALUE 999999
 NOCACHE
 NOCYCLE;
CREATE TABLE usuario (
 cd_usuario NUMBER(6)
 DEFAULT sequencia_usuario.nextval NOT NULL,
 nm_usuario VARCHAR2(40) NOT NULL,
 email_ususario VARCHAR2(40) NOT NULL,
 senha_usuario VARCHAR2(100) NOT NULL,
 genero VARCHAR2(9) NOT NULL,
 dt_nascimento DATE NOT NULL
);
ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( cd_usuario );
ALTER TABLE gastos
 ADD CONSTRAINT gastos_usuario_fk FOREIGN KEY ( usuario_cd_usuario )
 REFERENCES usuario ( cd_usuario );
ALTER TABLE obj_financeiro
 ADD CONSTRAINT obj_financeiro_usuario_fk FOREIGN KEY ( usuario_cd_usuario )
 REFERENCES usuario ( cd_usuario );
ALTER TABLE participacao
 ADD CONSTRAINT participacao_investimento_fk FOREIGN KEY (
investimento_cd_investimento )
 REFERENCES investimento ( cd_investimento );
ALTER TABLE participacao
 ADD CONSTRAINT participacao_usuario_fk FOREIGN KEY ( usuario_cd_usuario )
 REFERENCES usuario ( cd_usuario );
ALTER TABLE recebimentos
 ADD CONSTRAINT recebimentos_usuario_fk FOREIGN KEY ( usuario_cd_usuario )
 REFERENCES usuario ( cd_usuario );
INSERT INTO usuario
(cd_usuario,nm_usuario,email_ususario,senha_usuario,genero,dt_nascimento)
 VALUES(sequencia_usuario.nextval,'Nathan de Mello
Dias','nathan@hotmail.com','222222','masculino',
 TO_DATE('20/03/2006','DD/MM/YYYY'));

UPDATE usuario
 SET nm_usuario = 'Roberta Magalhaes',
 email_ususario = 'Robertinha@gmail.com',
 senha_usuario = '444087',
 genero = 'feminino',
 dt_nascimento = TO_DATE('21/09/2004','DD/MM/YYYY')
 WHERE cd_usuario = 1;
INSERT INTO recebimentos (cd_recebimento, usuario_cd_usuario, vl_recebimento,
dt_recebimento, ds_recebimento)
VALUES (sequencia_recebimentos.nextval, 1, 1000.00,
TO_DATE('12/03/2024','DD/MM/YYYY'), 'Sal?rio');
UPDATE recebimentos
 SET vl_recebimento = 2000.00,
 dt_recebimento = TO_DATE ('15/04/2024','DD/MM/YYYY'),
 ds_recebimento='freelance'
 where cd_recebimento=1;
INSERT INTO gastos (cd_gastos, usuario_cd_usuario, vl_gasto, dt_gasto, ds_gasto)
VALUES (sequencia_gastos.nextval, 1, 300, TO_DATE('24/09/2024', 'DD/MM/YYYY'), 'Compra de materiais');


UPDATE gastos
SET vl_gasto = 500.00,
 ds_gasto = 'Aluguel',
 dt_gasto = to_date ('20/06/2024','DD/MM/YYYY')
 WHERE cd_gastos = 1;
INSERT INTO participacao (cd_participacao, usuario_cd_usuario,
investimento_cd_investimento)
VALUES (sequencia_participacao.nextval, 1, 1);

INSERT INTO investimento (cd_investimento, tipo_investimento,
 nm_aplicacao, nm_banco, vl_investimento, dt_realizacao_invest,
 dt_vencimento)
VALUES (sequencia_investimentos.nextval, 'Renda Fixa',
 'Poupan?a', 'Banco do Brasil',
 1000.00, TO_DATE('01/09/2024', 'DD/MM/YYYY'),
 TO_DATE('01/09/2025', 'DD/MM/YYYY'));



UPDATE investimento
SET tipo_investimento = 'CDB',
 nm_aplicacao = 'Fundo de A??es',
 nm_banco = 'Bradesco',
 vl_investimento = 8000.00,
 dt_realizacao_invest = TO_DATE('25/09/2024', 'DD/MM/YYYY'),
 dt_vencimento = TO_DATE('25/09/2025', 'DD/MM/YYYY')
WHERE cd_investimento = 1;
SELECT *FROM usuario WHERE cd_usuario = 1;
SELECT *FROM gastos WHERE usuario_cd_usuario =1
AND cd_gastos = 1;
SELECT *FROM gastos WHERE usuario_cd_usuario = 1
ORDER BY dt_gasto DESC;
SELECT i.*FROM investimento i
JOIN participacao p ON i.cd_investimento = p.investimento_cd_investimento
WHERE p.usuario_cd_usuario = 1 AND i.cd_investimento = 1;
SELECT
 i.cd_investimento,
 i.nm_aplicacao,
 i.nm_banco,
 i.vl_investimento,
 i.dt_realizacao_invest,
 i.dt_vencimento
FROM
 investimento i
JOIN
 participacao p ON i.cd_investimento = p.investimento_cd_investimento
WHERE
 p.usuario_cd_usuario = 1
ORDER BY
 i.dt_realizacao_invest DESC;
SELECT
 u.cd_usuario,
 u.nm_usuario,
 u.email_ususario,
 u.genero,
 u.dt_nascimento,
 i.nm_aplicacao AS ultimo_investimento,
 i.dt_realizacao_invest AS data_ultimo_investimento,
 g.ds_gasto AS ultima_despesa,
 g.dt_gasto AS data_ultima_despesa
FROM usuario u LEFT JOIN (
 SELECT
 i.*,
 p.usuario_cd_usuario
 FROM
 investimento i
 JOIN
 participacao p ON i.cd_investimento = p.investimento_cd_investimento
 WHERE
 p.usuario_cd_usuario = 1
 ORDER BY
 i.dt_realizacao_invest DESC
) i ON u.cd_usuario = i.usuario_cd_usuario AND ROWNUM = 1
LEFT JOIN (
 SELECT
 cd_gastos,
 usuario_cd_usuario,
 ds_gasto,
 dt_gasto
 FROM
 gastos
 WHERE
 usuario_cd_usuario = 1
 ORDER BY
 dt_gasto DESC
) g ON u.cd_usuario = g.usuario_cd_usuario AND ROWNUM = 1
WHERE
 u.cd_usuario = 1;
 
Select * from investimento
commit
