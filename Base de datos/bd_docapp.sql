-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema docapp
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `docapp` ;

-- -----------------------------------------------------
-- Schema docapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `docapp` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `docapp` ;

-- -----------------------------------------------------
-- Table `docapp`.`Especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `docapp`.`Especialidad` ;

CREATE TABLE IF NOT EXISTS `docapp`.`Especialidad` (
  `idEspecialidad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idEspecialidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `docapp`.`Medico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `docapp`.`Medico` ;

CREATE TABLE IF NOT EXISTS `docapp`.`Medico` (
  `codigoMedico` INT NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(60) NOT NULL,
  `Especialidad_idEspecialidad` INT NOT NULL,
  PRIMARY KEY (`codigoMedico`))
ENGINE = InnoDB;

CREATE INDEX `fk_Medico_Especialidad1_idx` ON `docapp`.`Medico` (`Especialidad_idEspecialidad` ASC);


-- -----------------------------------------------------
-- Table `docapp`.`Disponibilidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `docapp`.`Disponibilidad` ;

CREATE TABLE IF NOT EXISTS `docapp`.`Disponibilidad` (
  `idDisponibilidad` INT NOT NULL,
  `hora_ini` TIME(6) NOT NULL,
  `hora_fin` TIME(6) NOT NULL,
  `capacidad` INT NOT NULL,
  PRIMARY KEY (`idDisponibilidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `docapp`.`Disponibilidad_has_Medico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `docapp`.`Disponibilidad_has_Medico` ;

CREATE TABLE IF NOT EXISTS `docapp`.`Disponibilidad_has_Medico` (
  `Disponibilidad_idDisponibilidad` INT NOT NULL,
  `Medico_codigoMedico` INT NOT NULL,
  `dia` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`Disponibilidad_idDisponibilidad`, `Medico_codigoMedico`))
ENGINE = InnoDB;

CREATE INDEX `fk_Disponibilidad_has_Medico_Medico1_idx` ON `docapp`.`Disponibilidad_has_Medico` (`Medico_codigoMedico` ASC);

CREATE INDEX `fk_Disponibilidad_has_Medico_Disponibilidad_idx` ON `docapp`.`Disponibilidad_has_Medico` (`Disponibilidad_idDisponibilidad` ASC);


-- -----------------------------------------------------
-- Table `docapp`.`Paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `docapp`.`Paciente` ;

CREATE TABLE IF NOT EXISTS `docapp`.`Paciente` (
  `dni` INT(8) NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `edad` INT NOT NULL,
  `sexo` VARCHAR(1) NOT NULL,
  `estado_civil` VARCHAR(1) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `lugar_nac` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(80) NOT NULL,
  `celular` VARCHAR(45) NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `docapp`.`Cita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `docapp`.`Cita` ;

CREATE TABLE IF NOT EXISTS `docapp`.`Cita` (
  `fecha_prog` DATE NOT NULL,
  `Medico_codigoMedico` INT NOT NULL,
  `Paciente_dni` INT(8) NOT NULL,
  `num_turno` INT NOT NULL,
  `receta` VARCHAR(400) NULL,
  `diagnostico` VARCHAR(200) NULL,
  PRIMARY KEY (`fecha_prog`, `Medico_codigoMedico`, `Paciente_dni`))
ENGINE = InnoDB;

CREATE INDEX `fk_Medico_has_Paciente_Paciente1_idx` ON `docapp`.`Cita` (`Paciente_dni` ASC);

CREATE INDEX `fk_Medico_has_Paciente_Medico1_idx` ON `docapp`.`Cita` (`Medico_codigoMedico` ASC);


-- -----------------------------------------------------
-- Table `docapp`.`HistoriaClinica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `docapp`.`HistoriaClinica` ;

CREATE TABLE IF NOT EXISTS `docapp`.`HistoriaClinica` (
  `num_historia` INT NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `alergias` VARCHAR(200) NULL,
  `Paciente_dni` INT(8) NOT NULL,
  PRIMARY KEY (`num_historia`, `Paciente_dni`))
ENGINE = InnoDB;

CREATE INDEX `fk_HistoriaClinica_Paciente1_idx` ON `docapp`.`HistoriaClinica` (`Paciente_dni` ASC);


-- -----------------------------------------------------
-- Table `docapp`.`ExamenMedico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `docapp`.`ExamenMedico` ;

CREATE TABLE IF NOT EXISTS `docapp`.`ExamenMedico` (
  `codigo_examen` INT NOT NULL,
  `tipo_analisis` VARCHAR(60) NOT NULL,
  `estado` VARCHAR(10) NOT NULL,
  `costo` DOUBLE NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `path_descarga` VARCHAR(200) NOT NULL,
  `fecha_prog` DATE NOT NULL,
  `HistoriaClinica_num_historia` INT NOT NULL,
  `HistoriaClinica_Paciente_dni` INT(8) NOT NULL,
  PRIMARY KEY (`codigo_examen`, `HistoriaClinica_num_historia`, `HistoriaClinica_Paciente_dni`))
ENGINE = InnoDB;

CREATE INDEX `fk_ExamenMedico_HistoriaClinica1_idx` ON `docapp`.`ExamenMedico` (`HistoriaClinica_num_historia` ASC, `HistoriaClinica_Paciente_dni` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
