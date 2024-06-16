-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso4
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `caso4` ;

-- -----------------------------------------------------
-- Schema caso4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso4` DEFAULT CHARACTER SET utf8mb3 ;
USE `caso4` ;

-- -----------------------------------------------------
-- Table `caso4`.`Puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Puesto` (
  `id` INT NOT NULL,
  `puesto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `puesto_UNIQUE` (`puesto` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso4`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_puesto` INT NOT NULL,
  `cui` VARCHAR(14) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `edad` INT NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `fecha_contratacion` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cui` (`cui` ASC) VISIBLE,
  UNIQUE INDEX `correo` (`correo` ASC) VISIBLE,
  INDEX `fk_empleado_Puesto1_idx` (`id_puesto` ASC) VISIBLE,
  UNIQUE INDEX `id_empleado_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_Puesto1`
    FOREIGN KEY (`id_puesto`)
    REFERENCES `caso4`.`Puesto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`MotivoInasistencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`MotivoInasistencia` (
  `id_motivo` INT NOT NULL AUTO_INCREMENT,
  `motivo` TEXT NOT NULL,
  PRIMARY KEY (`id_motivo`),
  UNIQUE INDEX `id_motivo_UNIQUE` (`id_motivo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`Asistencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Asistencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_empleado` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora_entrada` TIME NOT NULL,
  `hora_salida` TIME NOT NULL,
  `asistio` TINYINT NOT NULL,
  `id_motivo` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_empleado` (`id_empleado` ASC) VISIBLE,
  INDEX `id_motivo` (`id_motivo` ASC) VISIBLE,
  UNIQUE INDEX `id_asistencia_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `asistencia_ibfk_1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `caso4`.`Empleado` (`id`),
  CONSTRAINT `asistencia_ibfk_2`
    FOREIGN KEY (`id_motivo`)
    REFERENCES `caso4`.`MotivoInasistencia` (`id_motivo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`Avion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Avion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(50) NOT NULL,
  `modelo` VARCHAR(50) NOT NULL,
  `num_asientos_primera_clase` INT NOT NULL,
  `num_asientos_economica` INT NOT NULL,
  `num_asientos_ejecutiva` INT NOT NULL,
  `fecha_ultimo_mantenimiento` DATE NOT NULL,
  `fecha_proximo_mantenimiento` DATE NOT NULL,
  `fecha_hora_despegue_ultimo_vuelo` DATETIME NULL DEFAULT NULL,
  `fecha_hora_aterrizaje_ultimo_vuelo` DATETIME NULL DEFAULT NULL,
  `galones_gasolina` FLOAT NOT NULL,
  `distancia_maxima` FLOAT NOT NULL,
  `altura_maxima` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `matricula` (`matricula` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cui` VARCHAR(14) NULL,
  `numero_pasaporte` VARCHAR(50) NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `edad` INT NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `codigo_postal` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cui` (`cui` ASC) VISIBLE,
  UNIQUE INDEX `correo` (`correo` ASC) VISIBLE,
  UNIQUE INDEX `numero_pasaporte` (`numero_pasaporte` ASC) VISIBLE,
  UNIQUE INDEX `id_cliente_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_pais`),
  UNIQUE INDEX `id_pais_UNIQUE` (`id_pais` ASC) VISIBLE,
  UNIQUE INDEX `nombre_pais_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`ciudad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_pais` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_pais` (`id_pais` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `ciudad_ibfk_1`
    FOREIGN KEY (`id_pais`)
    REFERENCES `caso4`.`Pais` (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`ClaseViaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`ClaseViaje` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `clase` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `clase_UNIQUE` (`clase` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`FormaPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`FormaPago` (
  `id` INT NOT NULL,
  `forma` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `FormaPagocol_UNIQUE` (`forma` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso4`.`boleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`boleto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_lugar_destino` INT NOT NULL,
  `id_clase_viaje` INT NOT NULL,
  `id_lugar_origen` INT NOT NULL,
  `id_forma_pago` INT NOT NULL,
  `numero_vuelo` VARCHAR(50) NOT NULL,
  `fecha_regreso` DATE NULL,
  `peso_equipaje_permitido` FLOAT NOT NULL DEFAULT '50',
  `restricciones_cambios_reembolsos` TEXT NOT NULL,
  `fecha_validez` DATE NOT NULL,
  `vuelo_directo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_cliente` (`id_cliente` ASC) VISIBLE,
  INDEX `id_lugar_origen` (`id_lugar_origen` ASC) VISIBLE,
  INDEX `id_lugar_destino` (`id_lugar_destino` ASC) VISIBLE,
  INDEX `id_clase_viaje` (`id_clase_viaje` ASC) VISIBLE,
  UNIQUE INDEX `id_boleto_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_boleto_FormaPago1_idx` (`id_forma_pago` ASC) VISIBLE,
  CONSTRAINT `boleto_ibfk_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `caso4`.`cliente` (`id`),
  CONSTRAINT `boleto_ibfk_3`
    FOREIGN KEY (`id_lugar_origen`)
    REFERENCES `caso4`.`ciudad` (`id`),
  CONSTRAINT `boleto_ibfk_4`
    FOREIGN KEY (`id_lugar_destino`)
    REFERENCES `caso4`.`ciudad` (`id`),
  CONSTRAINT `boleto_ibfk_5`
    FOREIGN KEY (`id_clase_viaje`)
    REFERENCES `caso4`.`ClaseViaje` (`id`),
  CONSTRAINT `fk_boleto_FormaPago1`
    FOREIGN KEY (`id_forma_pago`)
    REFERENCES `caso4`.`FormaPago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`HstorialDespido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`HstorialDespido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_empleado` INT NOT NULL,
  `fecha_despido` DATE NOT NULL,
  `razon_despido` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_empleado` (`id_empleado` ASC) VISIBLE,
  UNIQUE INDEX `id_historial_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `historial_despido_ibfk_1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `caso4`.`Empleado` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`Idioma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Idioma` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idioma` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `idioma_UNIQUE` (`idioma` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`JornadaLaboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`JornadaLaboral` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `jornada` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `jornada_UNIQUE` (`jornada` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`TipoMantenimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`TipoMantenimiento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_tipo_mantenimiento_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`Mantenimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Mantenimiento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_avion` INT NOT NULL,
  `id_tipo_mantenimiento` INT NOT NULL,
  `fecha_hora_mantenimiento` DATETIME NOT NULL,
  `observaciones` TEXT NOT NULL,
  `problema_detectado` TINYINT(1) NOT NULL,
  INDEX `id_avion` (`id_avion` ASC) VISIBLE,
  INDEX `id_tipo_mantenimiento` (`id_tipo_mantenimiento` ASC) VISIBLE,
  UNIQUE INDEX `id_mantenimiento_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `mantenimiento_ibfk_1`
    FOREIGN KEY (`id_avion`)
    REFERENCES `caso4`.`Avion` (`id`),
  CONSTRAINT `mantenimiento_ibfk_2`
    FOREIGN KEY (`id_tipo_mantenimiento`)
    REFERENCES `caso4`.`TipoMantenimiento` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Mecanico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_mecanico_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`MantenimientoMecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`MantenimientoMecanico` (
  `id` VARCHAR(45) NOT NULL,
  `id_mantenimiento` INT NOT NULL,
  `id_mecanico` INT NOT NULL,
  INDEX `id_mecanico` (`id_mecanico` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `mantenimiento_mecanico_ibfk_1`
    FOREIGN KEY (`id_mantenimiento`)
    REFERENCES `caso4`.`Mantenimiento` (`id`),
  CONSTRAINT `mantenimiento_mecanico_ibfk_2`
    FOREIGN KEY (`id_mecanico`)
    REFERENCES `caso4`.`Mecanico` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`pago` (
  `id_pago` INT NOT NULL AUTO_INCREMENT,
  `numero_tarjeta` VARCHAR(50) NULL DEFAULT NULL,
  `tipo_tarjeta` VARCHAR(50) NULL DEFAULT NULL,
  `monto_total` FLOAT NULL DEFAULT NULL,
  `id_boleto` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_pago`),
  INDEX `id_boleto` (`id_boleto` ASC) VISIBLE,
  CONSTRAINT `pago_ibfk_1`
    FOREIGN KEY (`id_boleto`)
    REFERENCES `caso4`.`boleto` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`Viaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Viaje` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_ciudad_despegue` INT NOT NULL,
  `id_ciudad_aterrizaje` INT NOT NULL,
  `numero_vuelo` VARCHAR(50) NOT NULL,
  `num_pasajeros` INT NOT NULL,
  `fecha_hora_despegue` DATETIME NOT NULL,
  `fecha_hora_aterrizaje` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_ciudad_despegue` (`id_ciudad_despegue` ASC) VISIBLE,
  INDEX `id_ciudad_aterrizaje` (`id_ciudad_aterrizaje` ASC) VISIBLE,
  UNIQUE INDEX `id_viaje_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `numero_vuelo_UNIQUE` (`numero_vuelo` ASC) VISIBLE,
  CONSTRAINT `viaje_ibfk_1`
    FOREIGN KEY (`id_ciudad_despegue`)
    REFERENCES `caso4`.`ciudad` (`id`),
  CONSTRAINT `viaje_ibfk_3`
    FOREIGN KEY (`id_ciudad_aterrizaje`)
    REFERENCES `caso4`.`ciudad` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`Tripulacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Tripulacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_viaje` INT NOT NULL,
  `id_empleado` INT NOT NULL,
  `horas_acumuladas_vuelo` INT NULL,
  `anotacion` TEXT NULL,
  `hora_inicio_turno` VARCHAR(45) NOT NULL,
  `hora_fin_turno` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `id_empleado` (`id_empleado` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_tripulacion_viaje1_idx` (`id_viaje` ASC) VISIBLE,
  CONSTRAINT `tripulacion_ibfk_1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `caso4`.`Empleado` (`id`),
  CONSTRAINT `fk_tripulacion_viaje1`
    FOREIGN KEY (`id_viaje`)
    REFERENCES `caso4`.`Viaje` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `caso4`.`TipoTarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`TipoTarjeta` (
  `id` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso4`.`Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`Tarjeta` (
  `id` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_tipo_tarjeta` INT NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `nombre_titular` VARCHAR(45) NOT NULL,
  `banco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Tarjeta_cliente1_idx` (`id_cliente` ASC) VISIBLE,
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_Tarjeta_TipoTarjeta1_idx` (`id_tipo_tarjeta` ASC) VISIBLE,
  CONSTRAINT `fk_Tarjeta_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `caso4`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarjeta_TipoTarjeta1`
    FOREIGN KEY (`id_tipo_tarjeta`)
    REFERENCES `caso4`.`TipoTarjeta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso4`.`EmpleadoIdioma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`EmpleadoIdioma` (
  `id` INT NOT NULL,
  `id_empleado` INT NOT NULL,
  `id_idioma` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_EmpleadoIdioma_empleado1_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `fk_EmpleadoIdioma_idioma1_idx` (`id_idioma` ASC) VISIBLE,
  CONSTRAINT `fk_EmpleadoIdioma_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `caso4`.`Empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EmpleadoIdioma_idioma1`
    FOREIGN KEY (`id_idioma`)
    REFERENCES `caso4`.`Idioma` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso4`.`EmpleadoJornada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`EmpleadoJornada` (
  `id` INT NOT NULL,
  `empleado_id` INT NOT NULL,
  `JornadaLaboral_id` INT NOT NULL,
  `anotacion` TEXT NULL,
  `hora_inicio_turno` VARCHAR(45) NOT NULL,
  `hora_final_turno` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_EmpleadoJornada_empleado1_idx` (`empleado_id` ASC) VISIBLE,
  INDEX `fk_EmpleadoJornada_JornadaLaboral1_idx` (`JornadaLaboral_id` ASC) VISIBLE,
  CONSTRAINT `fk_EmpleadoJornada_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `caso4`.`Empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EmpleadoJornada_JornadaLaboral1`
    FOREIGN KEY (`JornadaLaboral_id`)
    REFERENCES `caso4`.`JornadaLaboral` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso4`.`PagoBoleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`PagoBoleto` (
  `id` INT NOT NULL,
  `id_boleto` INT NOT NULL,
  `cantidad` DECIMAL(5,2) NOT NULL,
  `hora_fecha_pago` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_PagoBoleto_boleto1_idx` (`id_boleto` ASC) VISIBLE,
  CONSTRAINT `fk_PagoBoleto_boleto1`
    FOREIGN KEY (`id_boleto`)
    REFERENCES `caso4`.`boleto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso4`.`PagoTarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`PagoTarjeta` (
  `id` INT NOT NULL,
  `anotacion` VARCHAR(45) NULL,
  `PagoBoleto_id` INT NOT NULL,
  `Tarjeta_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PagoTarjeta_PagoBoleto1_idx` (`PagoBoleto_id` ASC) VISIBLE,
  INDEX `fk_PagoTarjeta_Tarjeta1_idx` (`Tarjeta_id` ASC) VISIBLE,
  CONSTRAINT `fk_PagoTarjeta_PagoBoleto1`
    FOREIGN KEY (`PagoBoleto_id`)
    REFERENCES `caso4`.`PagoBoleto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PagoTarjeta_Tarjeta1`
    FOREIGN KEY (`Tarjeta_id`)
    REFERENCES `caso4`.`Tarjeta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso4`.`PagoEfectivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso4`.`PagoEfectivo` (
  `id` INT NOT NULL,
  `anotacion` VARCHAR(45) NULL,
  `PagoBoleto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PagoEfectivo_PagoBoleto1_idx` (`PagoBoleto_id` ASC) VISIBLE,
  CONSTRAINT `fk_PagoEfectivo_PagoBoleto1`
    FOREIGN KEY (`PagoBoleto_id`)
    REFERENCES `caso4`.`PagoBoleto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
