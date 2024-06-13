-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `caso2` ;

-- -----------------------------------------------------
-- Schema caso2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso2` DEFAULT CHARACTER SET utf8 ;
USE `caso2` ;

-- -----------------------------------------------------
-- Table `caso2`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Marca` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Modelo` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `Marca_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Modelo_Marca1_idx` (`Marca_id` ASC) VISIBLE,
  CONSTRAINT `fk_Modelo_Marca1`
    FOREIGN KEY (`Marca_id`)
    REFERENCES `caso2`.`Marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Departamento` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Municipio` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `Departamento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Municipio_Departamento_idx` (`Departamento_id` ASC) VISIBLE,
  CONSTRAINT `fk_Municipio_Departamento`
    FOREIGN KEY (`Departamento_id`)
    REFERENCES `caso2`.`Departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Sucursal` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(8) NOT NULL,
  `website` VARCHAR(45) NULL,
  `cant_max_vehiculos` INT NOT NULL,
  `Municipio_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Sucursal_Municipio1_idx` (`Municipio_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Sucursal_Municipio1`
    FOREIGN KEY (`Municipio_id`)
    REFERENCES `caso2`.`Municipio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Vehiculo` (
  `id` INT NOT NULL,
  `placa` VARCHAR(12) NOT NULL,
  `color` VARCHAR(20) NOT NULL,
  `anio` YEAR NOT NULL,
  `kilometraje` DOUBLE NOT NULL,
  `num_puertas` INT NOT NULL,
  `transmision_mecanica` TINYINT NOT NULL,
  `estado_nuevo` TINYINT NOT NULL,
  `Modelo_id` INT NOT NULL,
  `Sucursal_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Vehiculo_Modelo1_idx` (`Modelo_id` ASC) VISIBLE,
  INDEX `fk_Vehiculo_Sucursal1_idx` (`Sucursal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Vehiculo_Modelo1`
    FOREIGN KEY (`Modelo_id`)
    REFERENCES `caso2`.`Modelo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehiculo_Sucursal1`
    FOREIGN KEY (`Sucursal_id`)
    REFERENCES `caso2`.`Sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Empresa` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Proveedor` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(8) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `Empresa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Proveedor_Empresa1_idx` (`Empresa_id` ASC) VISIBLE,
  CONSTRAINT `fk_Proveedor_Empresa1`
    FOREIGN KEY (`Empresa_id`)
    REFERENCES `caso2`.`Empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Empleado` (
  `id` INT NOT NULL,
  `dpi` VARCHAR(14) NOT NULL,
  `nit` VARCHAR(9) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `sueldo` DOUBLE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dpi_UNIQUE` (`dpi` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nit_UNIQUE` (`nit` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Empleado_Sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Empleado_Sucursal` (
  `id` INT NOT NULL,
  `fecha_hora_inicio` DATETIME NOT NULL,
  `fecha_hora_fin` DATETIME NOT NULL,
  `Empleado_id` INT NOT NULL,
  `Sucursal_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Empleado_Sucursal_Empleado1_idx` (`Empleado_id` ASC) VISIBLE,
  INDEX `fk_Empleado_Sucursal_Sucursal1_idx` (`Sucursal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Sucursal_Empleado1`
    FOREIGN KEY (`Empleado_id`)
    REFERENCES `caso2`.`Empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Sucursal_Sucursal1`
    FOREIGN KEY (`Sucursal_id`)
    REFERENCES `caso2`.`Sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Compra` (
  `id` INT NOT NULL,
  `precio_total` DOUBLE NOT NULL,
  `fecha_hora_compra` DATETIME NOT NULL,
  `Empleado_Sucursal_id` INT NOT NULL,
  `Vehiculo_id` INT NOT NULL,
  `Proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Compra_Vehiculo1_idx` (`Vehiculo_id` ASC) VISIBLE,
  INDEX `fk_Compra_Proveedor1_idx` (`Proveedor_id` ASC) VISIBLE,
  INDEX `fk_Compra_Empleado_Sucursal1_idx` (`Empleado_Sucursal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Compra_Vehiculo1`
    FOREIGN KEY (`Vehiculo_id`)
    REFERENCES `caso2`.`Vehiculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Proveedor1`
    FOREIGN KEY (`Proveedor_id`)
    REFERENCES `caso2`.`Proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Empleado_Sucursal1`
    FOREIGN KEY (`Empleado_Sucursal_id`)
    REFERENCES `caso2`.`Empleado_Sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Cliente` (
  `id` INT NOT NULL,
  `dpi` VARCHAR(45) NOT NULL,
  `nit` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(8) NOT NULL,
  `telefono_casa` VARCHAR(8) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `dpi_UNIQUE` (`dpi` ASC) VISIBLE,
  UNIQUE INDEX `nit_UNIQUE` (`nit` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Venta` (
  `id` INT NOT NULL,
  `precio_total` DOUBLE NOT NULL,
  `fecha_hora_venta` DATETIME NOT NULL,
  `Empleado_Sucursal_id` INT NOT NULL,
  `Vehiculo_id` INT NOT NULL,
  `Cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Venta_Vehiculo1_idx` (`Vehiculo_id` ASC) VISIBLE,
  INDEX `fk_Venta_Cliente1_idx` (`Cliente_id` ASC) VISIBLE,
  INDEX `fk_Venta_Empleado_Sucursal1_idx` (`Empleado_Sucursal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Venta_Vehiculo1`
    FOREIGN KEY (`Vehiculo_id`)
    REFERENCES `caso2`.`Vehiculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_Cliente1`
    FOREIGN KEY (`Cliente_id`)
    REFERENCES `caso2`.`Cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_Empleado_Sucursal1`
    FOREIGN KEY (`Empleado_Sucursal_id`)
    REFERENCES `caso2`.`Empleado_Sucursal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Tarjeta` (
  `id` INT NOT NULL,
  `numero` VARCHAR(14) NOT NULL,
  `titular` VARCHAR(45) NOT NULL,
  `banco` VARCHAR(45) NOT NULL,
  `Cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Tarjeta_Cliente1_idx` (`Cliente_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Tarjeta_Cliente1`
    FOREIGN KEY (`Cliente_id`)
    REFERENCES `caso2`.`Cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Pago_Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Pago_Tarjeta` (
  `id` INT NOT NULL,
  `cantidad` DOUBLE NOT NULL,
  `fecha_hora_pago` DATETIME NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Tarjeta_id` INT NOT NULL,
  `Venta_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Pago_Tarjeta_Tarjeta1_idx` (`Tarjeta_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Pago_Tarjeta_Venta1_idx` (`Venta_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pago_Tarjeta_Tarjeta1`
    FOREIGN KEY (`Tarjeta_id`)
    REFERENCES `caso2`.`Tarjeta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pago_Tarjeta_Venta1`
    FOREIGN KEY (`Venta_id`)
    REFERENCES `caso2`.`Venta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Pago_Efectivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Pago_Efectivo` (
  `id` INT NOT NULL,
  `cantidad` DOUBLE NOT NULL,
  `fecha_hora_pago` DATETIME NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Venta_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Pago_Efectivo_Venta1_idx` (`Venta_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pago_Efectivo_Venta1`
    FOREIGN KEY (`Venta_id`)
    REFERENCES `caso2`.`Venta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Descuento_Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Descuento_Venta` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `cantidad` DOUBLE NOT NULL,
  `Venta_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Descuento_Venta1_idx` (`Venta_id` ASC) VISIBLE,
  CONSTRAINT `fk_Descuento_Venta1`
    FOREIGN KEY (`Venta_id`)
    REFERENCES `caso2`.`Venta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Pago_Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Pago_Compra` (
  `id` INT NOT NULL,
  `cantidad` DOUBLE NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Compra_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Pago_Compra_Compra1_idx` (`Compra_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Pago_Compra_Compra1`
    FOREIGN KEY (`Compra_id`)
    REFERENCES `caso2`.`Compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Descuento_Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Descuento_Compra` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `cantidad` DOUBLE NOT NULL,
  `Compra_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Descuento__Compra1_idx` (`Compra_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Descuento__Compra1`
    FOREIGN KEY (`Compra_id`)
    REFERENCES `caso2`.`Compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
