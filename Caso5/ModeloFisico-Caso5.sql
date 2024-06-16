-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso5
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `caso5` ;

-- -----------------------------------------------------
-- Schema caso5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `caso5` ;

-- -----------------------------------------------------
-- Table `caso5`.`Area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Area` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Ciudad` (
  `ciudad_id` INT NOT NULL AUTO_INCREMENT,
  `pais_id` INT NOT NULL,
  `nombre` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ciudad_id`),
  INDEX `pais_id` (`pais_id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `ciudad_id_UNIQUE` (`ciudad_id` ASC) VISIBLE,
  CONSTRAINT `ciudad_ibfk_1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `caso5`.`Pais` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`cliente` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `cui` VARCHAR(13) NOT NULL,
  `nombres` VARCHAR(255) NOT NULL,
  `apellidos` VARCHAR(255) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `correo` VARCHAR(255) NOT NULL,
  `edad` INT NOT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE INDEX `CUI` (`cui` ASC) VISIBLE,
  UNIQUE INDEX `cliente_id_UNIQUE` (`cliente_id` ASC) VISIBLE,
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Departamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `area_id` INT NOT NULL,
  `nombre` VARCHAR(255) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `area_id` (`area_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `departamento_ibfk_1`
    FOREIGN KEY (`area_id`)
    REFERENCES `caso5`.`Area` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`FrecuenciaPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`FrecuenciaPago` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frecuencia` VARCHAR(255) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `frecuencia_UNIQUE` (`frecuencia` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Funcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Funcion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `departamento_id` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripciones` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `departamento_id` (`departamento_id` ASC) VISIBLE,
  UNIQUE INDEX `funcion_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC) VISIBLE,
  CONSTRAINT `funcion_ibfk_1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `caso5`.`Departamento` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`puesto` (
  `puesto_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`puesto_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Personal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `departamento_id` INT NOT NULL,
  `puesto_id` INT NOT NULL,
  `dpi` VARCHAR(13) NOT NULL,
  `nombres` VARCHAR(255) NOT NULL,
  `apellidos` VARCHAR(255) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `edad` INT NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `salario` DECIMAL(6,2) NOT NULL,
  `fecha_contratacion` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `DPI` (`dpi` ASC) VISIBLE,
  INDEX `puesto_id` (`puesto_id` ASC) VISIBLE,
  INDEX `departamento_id` (`departamento_id` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  CONSTRAINT `personal_ibfk_1`
    FOREIGN KEY (`puesto_id`)
    REFERENCES `caso5`.`puesto` (`puesto_id`),
  CONSTRAINT `personal_ibfk_2`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `caso5`.`Departamento` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`TipoSeguro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`TipoSeguro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Seguro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Seguro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_seguro_id` INT NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `tipo_seguro_id` (`tipo_seguro_id` ASC) VISIBLE,
  UNIQUE INDEX `seguro_id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `seguro_ibfk_1`
    FOREIGN KEY (`tipo_seguro_id`)
    REFERENCES `caso5`.`TipoSeguro` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Llamada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Llamada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `personal_id` INT NOT NULL,
  `seguro_id_informacion` INT NOT NULL,
  `nombre_llamante` VARCHAR(255) NOT NULL,
  `telefono_llamante` VARCHAR(15) NOT NULL,
  `fecha` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `duracion` TIME NULL,
  PRIMARY KEY (`id`),
  INDEX `empleado_id` (`personal_id` ASC) VISIBLE,
  INDEX `seguro_id` (`seguro_id_informacion` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `llamada_ibfk_1`
    FOREIGN KEY (`personal_id`)
    REFERENCES `caso5`.`Personal` (`id`),
  CONSTRAINT `llamada_ibfk_2`
    FOREIGN KEY (`seguro_id_informacion`)
    REFERENCES `caso5`.`Seguro` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Poliza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Poliza` (
  `idd` INT NOT NULL AUTO_INCREMENT,
  `personal_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  `seguro_id` INT NOT NULL,
  `frecuencia_pago_id` INT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_final` DATE NOT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `anotacion` TEXT NULL,
  PRIMARY KEY (`idd`),
  INDEX `empleado_id` (`personal_id` ASC) VISIBLE,
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  INDEX `seguro_id` (`seguro_id` ASC) VISIBLE,
  INDEX `frecuencia_pago_id` (`frecuencia_pago_id` ASC) VISIBLE,
  UNIQUE INDEX `idd_UNIQUE` (`idd` ASC) VISIBLE,
  CONSTRAINT `poliza_ibfk_1`
    FOREIGN KEY (`personal_id`)
    REFERENCES `caso5`.`Personal` (`id`),
  CONSTRAINT `poliza_ibfk_2`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `caso5`.`cliente` (`cliente_id`),
  CONSTRAINT `poliza_ibfk_3`
    FOREIGN KEY (`seguro_id`)
    REFERENCES `caso5`.`Seguro` (`id`),
  CONSTRAINT `poliza_ibfk_4`
    FOREIGN KEY (`frecuencia_pago_id`)
    REFERENCES `caso5`.`FrecuenciaPago` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`TipoPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`TipoPago` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(255) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Pago` (
  `pago_id` INT NOT NULL AUTO_INCREMENT,
  `poliza_id` INT NOT NULL,
  `tipo_pago_id` INT NOT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `fecha_hora_pago` DATETIME NOT NULL,
  `anotacion` TEXT NULL,
  `Personal_id` INT NOT NULL,
  PRIMARY KEY (`pago_id`),
  INDEX `poliza_id` (`poliza_id` ASC) VISIBLE,
  INDEX `tipo_pago_id` (`tipo_pago_id` ASC) VISIBLE,
  UNIQUE INDEX `pago_id_UNIQUE` (`pago_id` ASC) VISIBLE,
  INDEX `fk_Pago_Personal1_idx` (`Personal_id` ASC) VISIBLE,
  CONSTRAINT `pago_ibfk_1`
    FOREIGN KEY (`poliza_id`)
    REFERENCES `caso5`.`Poliza` (`idd`),
  CONSTRAINT `pago_ibfk_2`
    FOREIGN KEY (`tipo_pago_id`)
    REFERENCES `caso5`.`TipoPago` (`id`),
  CONSTRAINT `fk_Pago_Personal1`
    FOREIGN KEY (`Personal_id`)
    REFERENCES `caso5`.`Personal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`Papeleria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Papeleria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`PapeleriaSeguro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`PapeleriaSeguro` (
  `id` INT NOT NULL,
  `seguro_id` INT NOT NULL,
  `papeleria_id` INT NOT NULL,
  `anotacion` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `papeleria_id` (`papeleria_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `seguro_papeleria_ibfk_1`
    FOREIGN KEY (`seguro_id`)
    REFERENCES `caso5`.`Seguro` (`id`),
  CONSTRAINT `seguro_papeleria_ibfk_2`
    FOREIGN KEY (`papeleria_id`)
    REFERENCES `caso5`.`Papeleria` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `caso5`.`TipoTarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`TipoTarjeta` (
  `id` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idTipoTarjeta_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso5`.`Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`Tarjeta` (
  `id` INT NOT NULL,
  `TipoTarjeta_id` INT NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `titular` VARCHAR(45) NOT NULL,
  `fecha_vencimiento` DATE NOT NULL,
  `vencida` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_Tarjeta_TipoTarjeta1_idx` (`TipoTarjeta_id` ASC) VISIBLE,
  CONSTRAINT `fk_Tarjeta_TipoTarjeta1`
    FOREIGN KEY (`TipoTarjeta_id`)
    REFERENCES `caso5`.`TipoTarjeta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso5`.`PagoTarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`PagoTarjeta` (
  `id` INT NOT NULL,
  `tipo_pago_id` INT NOT NULL,
  `tarjeta_id` INT NOT NULL,
  `anotacion` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_PagoTarjeta_tipopago1_idx` (`tipo_pago_id` ASC) VISIBLE,
  INDEX `fk_PagoTarjeta_Tarjeta1_idx` (`tarjeta_id` ASC) VISIBLE,
  CONSTRAINT `fk_PagoTarjeta_tipopago1`
    FOREIGN KEY (`tipo_pago_id`)
    REFERENCES `caso5`.`TipoPago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PagoTarjeta_Tarjeta1`
    FOREIGN KEY (`tarjeta_id`)
    REFERENCES `caso5`.`Tarjeta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso5`.`PagoEfectivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`PagoEfectivo` (
  `id` INT NOT NULL,
  `tipo_pago_id` INT NOT NULL,
  `anotacion` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_PagoEfectivo_tipopago1_idx` (`tipo_pago_id` ASC) VISIBLE,
  CONSTRAINT `fk_PagoEfectivo_tipopago1`
    FOREIGN KEY (`tipo_pago_id`)
    REFERENCES `caso5`.`TipoPago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso5`.`PagoCheque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso5`.`PagoCheque` (
  `id` INT NOT NULL,
  `numero_cheque` VARCHAR(45) NOT NULL,
  `numero_cuenta` VARCHAR(45) NOT NULL,
  `titular_cheque` VARCHAR(255) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `cantidad` DECIMAL(9,2) NOT NULL,
  `inconveniente` TINYINT NOT NULL,
  `anotacion` TEXT NULL,
  `tipopago_tipo_pago_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `numero_UNIQUE` (`numero_cheque` ASC) VISIBLE,
  UNIQUE INDEX `numero_cuenta_UNIQUE` (`numero_cuenta` ASC) VISIBLE,
  INDEX `fk_PagoCheque_tipopago1_idx` (`tipopago_tipo_pago_id` ASC) VISIBLE,
  CONSTRAINT `fk_PagoCheque_tipopago1`
    FOREIGN KEY (`tipopago_tipo_pago_id`)
    REFERENCES `caso5`.`TipoPago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
