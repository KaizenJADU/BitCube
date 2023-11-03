drop database if exists Bitcube;

create database Bitcube;

use Bitcube;

#Tabla TipoUsuario

create table
    TipoUsuario(
        idTipoUsuario int primary key,
        nombreUsuario varchar (20)
    );

INSERT INTO
    TipoUsuario(idTipoUsuario, nombreUsuario)
VALUES (1, 'Administrador'), (2, 'Usuario');

#Tabla Interes

create table
    Interes(
        idInteres int auto_increment primary key,
        tipoInteres varchar (20)
    );

#Tabla Infante

create table
    Infante(
        idInfante int auto_increment primary key,
        idInteres int,
        nombreInfante varchar (50),
        apePatInfante varchar(50),
        apeMatInfante varchar(50),
        edadInfante int,
        foreign key(idInteres) references Interes(idInteres)
    );

#Tabla Usuario

create table
    Usuario(
        IdUsuario int primary key auto_increment,
        idTipoUsuario int,
        idInfante int,
        nombreUsuario varchar(20),
        apePatUsuario varchar(20),
        apeMatUsuario varchar(20),
        correoUsuario varchar(20),
        telUsuario varchar(15),
        contrasena VARCHAR(100),
        direccionTutor varchar(20),
        RFC varchar(20),
        CURP varchar (50),
        codigo int,
        foreign key(idTipoUsuario) references TipoUsuario(idTipoUsuario),
        foreign key(idInfante) references Infante(idInfante)
    );

#Tabla Calendario

create table
    Calendario(
        idCalendario int primary key auto_increment,
        idUsuario int,
        fechaCal date,
        actividad varchar (100),
        foreign key(idUsuario) references Usuario(idUsuario)
    );

#Tabla Imagen Pictograma

create table
    ImagenPictograma(
        idImagen int primary key auto_increment,
        imagen varbinary(50) NOT NULL,
        significado varchar (50)
    );

#Tabla Tipo Pictogrma

create table
    TipoPictograma(
        idTipoPictograma int primary key auto_increment,
        idImagen int,
        foreign key(idImagen) references ImagenPictograma(idImagen)
    );

#Tabla Pictograma

create table
    Pictograma(
        idPictograma int primary key auto_increment,
        idUsuario int,
        idTipoPictograma int,
        foreign key(idUsuario) references Usuario(idUsuario),
        foreign key(idTipoPictograma) references TipoPictograma(idTipoPictograma)
    );

#Tabla Comentario

create table
    Comentario(
        idComentario int auto_increment primary key,
        fechaComen datetime,
        texto varchar(500)
    );

#Tabla RelUsuComent

create table
    RelUsuComent(
        idRelUsuComent int primary key auto_increment,
        idUsuario int,
        idComentario int,
        foreign key(idUsuario) references Usuario(idUsuario),
        foreign key(idComentario) references Comentario(idComentario)
    );

select * from TipoUsuario;

select * from Interes;

select * from Infante;

select * from Usuario;

select * from Calendario;

select * from ImagenPictograma;

select * from TipoPictograma;

select * from Pictograma;

select * from RelUsuComent;