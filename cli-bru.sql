CREATE SCHEMA CliBru2;
USE CliBru2;

-- CRIANDO AS TABELAS

CREATE TABLE Medico(
	idMedico INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    crm VARCHAR(45) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL
);

CREATE TABLE Especialidade(
	idEspecialidade INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Atendente(
	idAtendente INT  NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    matricula VARCHAR(45) NOT NULL
);

CREATE TABLE Paciente(
	idPaciente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cpf VARCHAR(45) NOT NULL,
    nascimento DATE NOT NULL
);

CREATE TABLE Endereco(
	idEndereco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(45) NOT NULL,
    numero VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL, 
    cidade VARCHAR(45) NOT NULL,
    cep VARCHAR(45) NOT NULL
);

CREATE TABLE Convenio(
	idConvenio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NULL
);

CREATE TABLE Medico_Especialidade(
    idMedico INT NOT NULL,
    idEspecialidade INT NOT NULL,
    FOREIGN KEY (idMedico) REFERENCES Medico(idMedico),
    FOREIGN KEY (idEspecialidade) REFERENCES Especialidade(idEspecialidade)
);

CREATE TABLE Consulta(
	dataMarcada datetime not null,
    aconteceu tinyint not null,
    idMedico INT NOT NULL,
    FOREIGN KEY (idMedico) REFERENCES Medico(idMedico),
    idPaciente INT NOT NULL,
    FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente),
    idAtendente INT NOT NULL, 
    FOREIGN KEY (idAtendente) REFERENCES Atendente(idAtendente)
);

CREATE TABLE Paciente_Convenio(
	idPaciente INT NOT NULL,
    idConvenio INT NOT NULL,
    FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente),
    FOREIGN KEY (idConvenio) REFERENCES Convenio(idConvenio)
);


-- INNSERINDO OS DADOS 

INSERT INTO Medico
VALUES(10, 'AB45', 'Déborah Letícia', 'Santos'),
(11, 'BC54', 'José Vitor', 'Moreira'),
(12, 'CX231', 'Maria Quiteria', 'Santos'),
(13, 'de4fR', 'Gonçalo', 'Ribeiro'),
(14, 'vgt6', 'Ana Júlia', 'Dias'),
(15, 'bbb7h', 'Maria', 'Silva');

INSERT INTO Especialidade
VALUES (100, 'Cardiologia'),
(101, 'Geral'),
(102, 'Cirurgia Plástica'),
(103, 'Neurologia'),
(104, 'Ultassonografia'),
(105, 'Obstetrícia'),
(106, 'Pediatria');

INSERT INTO Atendente
VALUES (200, 'Mario', 'de321'),
(201, 'Ana', 'qw23e'),
(202, 'Caio', 'kkki90');

INSERT INTO Paciente 
VALUES (300, 'Fernanda', '1234544', '2000-09-08'),
(301, 'Rose', '123321', '1999-09-08'),
(302, 'Vitoria', '543211', '2002-09-12'),
(303, 'Gleyse', '789009', '2022-09-17'),
(304, 'Joana', '123667', '2021-10-10'),
(305, 'Emilly', '525525', '2010-05-10'),
(306, 'Juliana', '14256', '2015-10-19'),
(307, 'João', '17288', '2020-07-13'),
(308, 'Caio', '129200', '1999-09-09'),
(309, 'Larissa', '903030', '2017-04-15'),
(310, 'Marcos', '12789', '2022-09-20');

INSERT INTO Endereco
VALUES (400, 'AAAAA', 12, 'centro', 'dom basilio', '123321'),
(401, 'BBBB', 99, 'santa luzia', 'livramento', '121212'),
(402, 'CCCC', 120, 'bairro leite', 'são paulo', '098777'),
(403, 'BAAAA', 18, 'centro', 'brumado', '1238921'),
(404, 'AAAHA', 120, 'centro', 'joao pessoa', '03321'),
(405, 'HHAA', 29, 'centro', 'salavdor', '121');

INSERT INTO Convenio
VALUES (500, 'paz nacional'),
(501, 'guerra nacional'),
(502, 'santa aliança');

INSERT INTO Medico_Especialidade
VALUES (10, 100),
(11, 102),
(12, 101),
(13, 105),
(14, 106),
(15, 104);

INSERT INTO Consulta 
VALUES ('2022-08-23 16:18:02', true, 10, 300, 200),
('2022-08-23 10:18:02', true, 10, 301, 202),
('2022-08-27 16:18:02', false, 11, 302, 201),
('2022-08-28 16:18:02', true, 12, 303, 201),
('2022-08-30 16:18:02', true, 13, 304, 202),
('2022-08-27 16:19:02', true, 15, 310, 200);


INSERT INTO Paciente_Convenio 
VALUES (300, 500),
(302, 501),
(301, 502);


-- SELECT COM INNER JOIN

SELECT P.nome AS NomePaciente, C.aconteceu 
FROM Paciente P
INNER JOIN Consulta C
ON P.idPaciente = C.idPaciente;

SELECT C.aconteceu, M.nome AS NomeMedico, M.crm AS CRM, P.nome AS NomePaciente
FROM Medico M
INNER JOIN Consulta C
ON M.idMedico = C.idMedico
INNER JOIN Paciente P 
ON P.idPaciente = C.idPaciente;

SELECT E.nome AS NomeEspecialidade, M.nome AS NomeMedico, C.datamarcada AS DataConsulta, A.nome AS NomeAtendente, P.nome AS NomePaciente, CV.nome AS NomeConvenio
FROM Especialidade E 
INNER JOIN Medico_Especialidade ME 
ON E.idEspecialidade = ME.idEspecialidade
INNER JOIN Medico M 
ON M.idMedico = ME.idMedico
INNER JOIN Consulta C
ON C.idMedico = M.idMedico
INNER JOIN Atendente A 
ON A.idAtendente = C.idAtendente 
INNER JOIN Paciente P
ON P.idPaciente = C.idPaciente 
INNER JOIN Paciente_Convenio PC 
ON PC.idPaciente = P.idPaciente 
INNER JOIN Convenio CV
ON CV.idConvenio = PC.idConvenio;




