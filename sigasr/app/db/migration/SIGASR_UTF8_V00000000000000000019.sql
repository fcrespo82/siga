-- OSI_FS0008 - Adicionando campo descrição na designação
ALTER SESSION SET CURRENT_SCHEMA = CORPORATIVO;
ALTER TABLE CORPORATIVO.CP_CONFIGURACAO ADD DESCR_CONFIGURACAO VARCHAR2(255);