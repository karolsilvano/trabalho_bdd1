CREATE DATABASE trabalho_bdd1;
USE trabalho_bdd1;

CREATE TABLE pessoa (
	cpf_pessoa CHAR(11),
	nome VARCHAR(100),
	rg CHAR(9),
	data_nasc DATE,
	genero VARCHAR(50),
	LGBTQIA ENUM("Sim", "Não"),
	cor_raca VARCHAR(30),
	nacionalidade VARCHAR(40),
	naturalidade VARCHAR(40),
	whatsapp VARCHAR(11),
	escolaridade VARCHAR(50),
	profissao VARCHAR(50),
	situacao_emprego ENUM("Empregado", "Autônomo", "Desempregado"),
	estado_civil ENUM("Solteiro", "Casado", "Viúvo", "Separado", "Divorciado"),
	total_familia INT,
    violencia_domestica ENUM("Sim", "Não"),
	tem_filhos BOOLEAN,
	possui_beneficio BOOLEAN,
	possui_renda BOOLEAN,
	fez_tratamento BOOLEAN,
	possui_investimento BOOLEAN,
	possui_casa_propria BOOLEAN,
	possui_apto BOOLEAN,
	possui_terreno BOOLEAN,
	possui_imovel_comercial BOOLEAN,
	possui_automovel BOOLEAN,
    
    PRIMARY KEY (cpf_pessoa)
);

-- ENTIDADES QUE SAO OPCIONAIS (SE A PESSOA TIVER FILHOS (POR EXEMPLO) ENTRA NESSAS ABAIXO, POR ISSO O BOOLEAN (TRUE OU FALSE)
CREATE TABLE filhos (
    id_filhos INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    quantos_filhos INT,
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE beneficio (
    id_beneficio INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_beneficio DECIMAL(5, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE renda (
    id_renda INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_renda DECIMAL(5, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE tratamento (
    id_tratamento INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_tratamento DECIMAL(6, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE investimento (
    id_investimento INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_investimento DECIMAL(6, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE casa (
    id_casa INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_casa DECIMAL(15, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE apto (
    id_apto INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_apto DECIMAL(15, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE terreno (
    id_terreno INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_terreno DECIMAL(15, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE imovel_comercial (
    id_imovel_comercial INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_imovel_comercial DECIMAL(15, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

CREATE TABLE automovel (
    id_automovel INT AUTO_INCREMENT PRIMARY KEY,
    FK_cpf_pessoa CHAR(11),
    valor_automovel DECIMAL(6, 2),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa) 
);

-- -------------------------

-- ENTIDADES FRACAS
CREATE TABLE endereco_pessoa (
	FK_cpf_pessoa CHAR(11),
	cep CHAR(9),
	rua VARCHAR(100),
	bairro VARCHAR(50),
	cidade VARCHAR(50),
	uf CHAR(2),
    PRIMARY KEY (cep, FK_cpf_pessoa),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa)
);

CREATE TABLE email_pessoa (
    FK_cpf_pessoa CHAR(11),
    email_pessoa VARCHAR(70) UNIQUE,
    PRIMARY KEY (FK_cpf_pessoa, email_pessoa),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa)
);

CREATE TABLE tel_pessoa (
	FK_cpf_pessoa CHAR(11),
	telefone_pessoa VARCHAR(11),
    PRIMARY KEY (FK_cpf_pessoa, telefone_pessoa),
    FOREIGN KEY (FK_cpf_pessoa) REFERENCES pessoa(cpf_pessoa)
);

-- -----------------

CREATE TABLE atendimento (
	cod_atendimento INT AUTO_INCREMENT,
	nome_atendente VARCHAR(50),
	data_atendimento DATE,
	hora_chegada TIME,
	hora_atendimento TIME,
	info_servico VARCHAR(100),
	pessoa_pf_pj ENUM("PJ", "PF"),
	resumo_caso VARCHAR(500),
	materia_relacionada ENUM("Cível", "Família e Sucessões", "Trabalhista", "Penal", "Previdenciário", "Outro"),
	violencia_domestica ENUM("Sim", "Não"),
	pessoa_enquadrada ENUM("Sim", "Não")
);

CREATE TABLE estagiario (
	cod_estagiario INT AUTO_INCREMENT,
	nome VARCHAR(100),
	tipo_estagiario ENUM("P", "A", "V"),
    
    PRIMARY KEY(cod_estagiario)
);

CREATE TABLE tel_estagiario (
    FK_cod_estagiario INT,
    tel_estagiario CHAR(11),
    PRIMARY KEY (FK_cod_estagiario, tel_estagiario),
    FOREIGN KEY (FK_cod_estagiario) REFERENCES estagiario(cod_estagiario)
);

CREATE TABLE email_estagiario (
    FK_cod_estagiario INT,
    email_estagiario VARCHAR(70) UNIQUE,
    PRIMARY KEY (FK_cod_estagiario, email_estagiario),
    FOREIGN KEY (FK_cod_estagiario) REFERENCES estagiario(cod_estagiario)
);


CREATE TABLE processo (
	cod_processo INT AUTO_INCREMENT,
	tema VARCHAR(100),
	cpf_pessoa CHAR(11),
	polo ENUM("reclamante/reclamado", "exequente/executado"),
	prox_data_controle DATE,
	prox_atividade DATE,
	deferido_prazo_dobro ENUM("Sim", "Não"),
	obs_prazo VARCHAR(100),
	marcada_audiencia VARCHAR(100),
	dados_audiencia VARCHAR(300),
	data_prazo_simples DATE,
	data_prazo_dobro DATE,
	registro_movi_processual VARCHAR(100),
	qntd_dias_prox_controle INT,
	data_proposicao_acao DATE,
	data_protocolo_judicial DATE
);

CREATE TABLE atribuicao (
	data_atribuicao DATE,
	hora_atribuicao TIME,
	tipo_estagiario ENUM("P", "A", "V")
);

CREATE TABLE advogado (
	oab_adv CHAR(15),
	nome_adv VARCHAR(100),
	especialidade VARCHAR(100),
	cpf_adv CHAR(11),
	ano_ingresso CHAR(4),
    
    PRIMARY KEY(oab_adv)
);

CREATE TABLE tel_adv (
    FK_oab_adv CHAR(15),
    tel_adv CHAR(11),
    PRIMARY KEY (FK_oab_adv, tel_adv),
    FOREIGN KEY (FK_oab_adv) REFERENCES advogado(oab_adv)
);

CREATE TABLE email_adv (
    FK_oab_adv CHAR(15),
    email_adv VARCHAR(70),
    PRIMARY KEY (FK_oab_adv, email_adv),
    FOREIGN KEY (FK_oab_adv) REFERENCES advogado(oab_adv)
);

/* CREATE TABLE disponibilidade_adv (
	oab_adv CHAR(15),
	dia_semana VARCHAR(15),
	hora_inicio TIME,
	hora_fim TIME,
	formato ENUM("R", "P")
); */

CREATE TABLE disponibilidade_adv (
    FK_oab_adv CHAR(15),
    dia_semana VARCHAR(15),
    hora_inicio TIME,
    hora_fim TIME,
    formato ENUM("R", "P"),
    PRIMARY KEY (FK_oab_adv, dia_semana, hora_inicio, hora_fim),
    FOREIGN KEY (FK_oab_adv) REFERENCES advogado(oab_adv)
);


CREATE TABLE agendamento (
	cod_estag INT AUTO_INCREMENT,
	oab_adv CHAR(15),
	prazo_judicial VARCHAR(100),
	motivo_consulta VARCHAR(100),
	num_autos INT,
	data_atendimento DATE,
	hora_atendimento TIME,
	identificacao_adv_registrada VARCHAR(100),
	data_inscricao DATE,
	area_direito ENUM("Cível", "Família e Sucessões", "Trabalhista", "Penal", "Previdenciário", "Outro"),
	tipo_orientacao VARCHAR(100),
	cod_agendamento INT
);


