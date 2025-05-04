CREATE DATABASE IF NOT EXISTS GrupoColitas;
USE GrupoColitas;

-- Usuarios
CREATE TABLE IF NOT EXISTS UsuarioColitas (
    IdUsuario INT AUTO_INCREMENT PRIMARY KEY, 
    DniUsuario CHAR(8) UNIQUE NOT NULL,   
    NombreUsuario VARCHAR(100) NOT NULL,  
    ContraseñaUsuario VARCHAR(255) NOT NULL
);

-- Perros
CREATE TABLE IF NOT EXISTS Perros (
    IdPerro INT AUTO_INCREMENT PRIMARY KEY,
    NombrePerro VARCHAR(30) NOT NULL,
    EdadPerro INT NOT NULL,
    SexoPerro ENUM ("Hembra", "Macho"),
    RazaPerro VARCHAR(30),
    EstadoPerro BOOLEAN DEFAULT 1,
    PelajePerro ENUM ("Corto", "Largo"),
    EstaturaPerro ENUM ("Pequeño", "Mediano", "Grande"),
    ActividadPerro ENUM ("Moderado", "Activo"),
    FotografíaPrincipalPerro MEDIUMBLOB NOT NULL,
    DescripcionPerro TEXT NOT NULL,
    FechaIngresoPerro DATE NOT NULL
);

-- Fotos detalladas de cada perro
CREATE TABLE IF NOT EXISTS FotografiasDetalladasPerros (
    IdFoto INT AUTO_INCREMENT PRIMARY KEY,
    IdPerro INT NOT NULL,
    DescripcionFoto VARCHAR(255),
    Fotografía MEDIUMBLOB NOT NULL,
    FOREIGN KEY (IdPerro) REFERENCES Perros(IdPerro) ON UPDATE CASCADE
);

-- Campaña de firmas
CREATE TABLE IF NOT EXISTS CampañaFirmas (
    IdFirma INT AUTO_INCREMENT PRIMARY KEY,
    DniFirma CHAR(8) UNIQUE NOT NULL,
    NombreFirma VARCHAR(100) NOT NULL,
    MotivoFirma TEXT NOT NULL,
    ImagenFirma LONGBLOB NOT NULL
);

-- Solicitud de una donacion
CREATE TABLE IF NOT EXISTS SolicitudDonaciones (
    IdSolicitudDonacion INT AUTO_INCREMENT PRIMARY KEY,
    NombreSolicitanteDonacion VARCHAR(30) NOT NULL,
    CorreoElectronico VARCHAR(30) NOT NULL,
    NumeroDeContactoDonacion CHAR(9) NOT NULL,
    TipoDonacion ENUM("Monetaria", "Comida", "Ropa", "Otro") NOT NULL,
    CantidadComidaDonacion INT,
    DescripcionComidaDonacion TEXT,
    CantidadMonetariaDonacion DECIMAL(10, 2),
    CantidadRopaDonacion INT,
    DescripcionRopaDonacion TEXT,
    DescripcionOtroDonacion TEXT,
    FechaSolicitudDonacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    EstadoSolicitud ENUM("Pendiente", "Aprobada", "No Culminada") DEFAULT "Pendiente"
);

-- Registro de la donacion
CREATE TABLE IF NOT EXISTS Donaciones (
    IdDonacion INT AUTO_INCREMENT PRIMARY KEY,
    IdSolicitudDonacion INT NOT NULL,
    DniUsuario CHAR(8) NOT NULL,
    FechaConcretacionDonacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IdSolicitudDonacion) REFERENCES SolicitudDonaciones(IdSolicitudDonacion) ON UPDATE CASCADE,
    FOREIGN KEY (DniUsuario) REFERENCES UsuarioColitas(DniUsuario) ON UPDATE CASCADE
);

-- Solicitud de adopcion
CREATE TABLE IF NOT EXISTS SolicitudAdopciones (
    IdPerro INT NOT NULL,
    IdSolicitudAdopcion INT AUTO_INCREMENT PRIMARY KEY,
    NombreSolicitanteAdopcion VARCHAR(30) NOT NULL,
    CorreoElectronico VARCHAR(30) NOT NULL,
    NumeroDeContactoAdopcion CHAR(9) NOT NULL,
    MotivoAdopcion TEXT NOT NULL,
    FechaSolicitudAdopcion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    EstadoSolicitud ENUM("Pendiente", "Aprobada", "No Culminada") DEFAULT "Pendiente",
    FOREIGN KEY (IdPerro) REFERENCES Perros(IdPerro) ON UPDATE CASCADE
);

-- Registro de la adopcion
CREATE TABLE IF NOT EXISTS Adopciones (
    IdAdopcion INT AUTO_INCREMENT PRIMARY KEY,
    IdSolicitudAdopcion INT NOT NULL,
    DniUsuario CHAR(8) NOT NULL,
    FotoDocumentoAdopcion MEDIUMBLOB,
    FechaConcretacionAdopcion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IdSolicitudAdopcion) REFERENCES SolicitudAdopciones(IdSolicitudAdopcion) ON UPDATE CASCADE,
    FOREIGN KEY (DniUsuario) REFERENCES UsuarioColitas(DniUsuario) ON UPDATE CASCADE
);

-- Solicitud de voluntariado
CREATE TABLE IF NOT EXISTS SolicitudVoluntariados (
    IdPerro INT NOT NULL,
    IdSolicitudVoluntariado INT AUTO_INCREMENT PRIMARY KEY,
    NombreSolicitanteVoluntariado VARCHAR(30) NOT NULL,
    CorreoElectronico VARCHAR(30) NOT NULL,
    NumeroDeContactoVoluntariado CHAR(9) NOT NULL,
    DescripcionVoluntariado TEXT NOT NULL,
    HorarioDisponibleVoluntariado JSON NOT NULL,
    FechaSolicitudVoluntariado TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    EstadoSolicitud ENUM("Pendiente", "Aprobada", "No Culminada") DEFAULT "Pendiente",
    FOREIGN KEY (IdPerro) REFERENCES Perros(IdPerro) ON UPDATE CASCADE
);

-- Registro deL voluntariado
CREATE TABLE IF NOT EXISTS Voluntariados (
    IdVoluntariado INT AUTO_INCREMENT PRIMARY KEY,
    IdSolicitudVoluntariado INT NOT NULL,
    DniUsuario CHAR(8) NOT NULL,
    FechaConcretacionVoluntariado TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IdSolicitudVoluntariado) REFERENCES SolicitudVoluntariados(IdSolicitudVoluntariado) ON UPDATE CASCADE,
    FOREIGN KEY (DniUsuario) REFERENCES UsuarioColitas(DniUsuario) ON UPDATE CASCADE
);