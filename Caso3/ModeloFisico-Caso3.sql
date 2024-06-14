-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso3
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `caso3` ;

-- -----------------------------------------------------
-- Schema caso3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso3` DEFAULT CHARACTER SET utf8 ;
USE `caso3` ;

-- -----------------------------------------------------
-- Table `caso3`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Pais` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Compania`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Compania` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `Pais_id` INT NOT NULL,
  INDEX `fk_Compania_Pais_idx` (`Pais_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Compania_Pais`
    FOREIGN KEY (`Pais_id`)
    REFERENCES `caso3`.`Pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Proveedor` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(11) NOT NULL,
  `Compania_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Proveedor_Compania1_idx` (`Compania_id` ASC) VISIBLE,
  CONSTRAINT `fk_Proveedor_Compania1`
    FOREIGN KEY (`Compania_id`)
    REFERENCES `caso3`.`Compania` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`TipoComponente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`TipoComponente` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_receta_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Componente` (
  `id` INT NOT NULL,
  `nombre_modelo` VARCHAR(45) NOT NULL,
  `dimensiones` VARCHAR(45) NOT NULL,
  `revisado` TINYINT NOT NULL,
  `valor` DECIMAL(5,2) NOT NULL,
  `TipoComponente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Componente_TipoComponente1_idx` (`TipoComponente_id` ASC) VISIBLE,
  CONSTRAINT `fk_Componente_TipoComponente1`
    FOREIGN KEY (`TipoComponente_id`)
    REFERENCES `caso3`.`TipoComponente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`TipoParte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`TipoParte` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `tipo_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Parte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Parte` (
  `id` INT NOT NULL,
  `nombre_modelo` VARCHAR(45) NOT NULL,
  `dimensiones` VARCHAR(45) NOT NULL,
  `revisado` TINYINT NOT NULL,
  `valor` DECIMAL(5,2) NOT NULL,
  `TipoParte_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Parte_TipoParte1_idx` (`TipoParte_id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre_modelo` ASC) VISIBLE,
  CONSTRAINT `fk_Parte_TipoParte1`
    FOREIGN KEY (`TipoParte_id`)
    REFERENCES `caso3`.`TipoParte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Componente-Parte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Componente-Parte` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `costo_ensamble` DECIMAL(5,2) NULL,
  `Componente_id` INT NOT NULL,
  `Parte_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Componente-Parte_Componente1_idx` (`Componente_id` ASC) VISIBLE,
  INDEX `fk_Componente-Parte_Parte1_idx` (`Parte_id` ASC) VISIBLE,
  CONSTRAINT `fk_Componente-Parte_Componente1`
    FOREIGN KEY (`Componente_id`)
    REFERENCES `caso3`.`Componente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Componente-Parte_Parte1`
    FOREIGN KEY (`Parte_id`)
    REFERENCES `caso3`.`Parte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Planta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Planta` (
  `id` INT NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`LineaEnsamblaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`LineaEnsamblaje` (
  `id` INT NOT NULL,
  `fecha_creac` DATE NOT NULL,
  `linea` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Planta_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_LineaEnsamblaje_Planta1_idx` (`Planta_id` ASC) VISIBLE,
  UNIQUE INDEX `linea_UNIQUE` (`linea` ASC) VISIBLE,
  CONSTRAINT `fk_LineaEnsamblaje_Planta1`
    FOREIGN KEY (`Planta_id`)
    REFERENCES `caso3`.`Planta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`ArmadoProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`ArmadoProducto` (
  `id` INT NOT NULL,
  `revisado` TINYINT NOT NULL,
  `costo` DECIMAL(5,2) NOT NULL,
  `fecha_hora_final` DATETIME NULL,
  `descripcion` VARCHAR(45) NULL,
  `LineaEnsamblaje_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_ArmadoProducto_LineaEnsamblaje1_idx` (`LineaEnsamblaje_id` ASC) VISIBLE,
  CONSTRAINT `fk_ArmadoProducto_LineaEnsamblaje1`
    FOREIGN KEY (`LineaEnsamblaje_id`)
    REFERENCES `caso3`.`LineaEnsamblaje` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`ArmadoProd-Parte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`ArmadoProd-Parte` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `costo_ensamble` DECIMAL(5,2) NULL,
  `Parte_id` INT NOT NULL,
  `ArmadoProducto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_RecetaProd-Parte_Parte1_idx` (`Parte_id` ASC) VISIBLE,
  INDEX `fk_ArmadoProd-Parte_ArmadoProducto1_idx` (`ArmadoProducto_id` ASC) VISIBLE,
  CONSTRAINT `fk_RecetaProd-Parte_Parte1`
    FOREIGN KEY (`Parte_id`)
    REFERENCES `caso3`.`Parte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ArmadoProd-Parte_ArmadoProducto1`
    FOREIGN KEY (`ArmadoProducto_id`)
    REFERENCES `caso3`.`ArmadoProducto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Marca` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Producto` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `valor` DECIMAL(5,2) NOT NULL,
  `hora_fecha_fin` VARCHAR(45) NOT NULL,
  `ArmadoProducto_id1` INT NOT NULL,
  `Marca_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Producto_ArmadoProducto1_idx` (`ArmadoProducto_id1` ASC) VISIBLE,
  INDEX `fk_Producto_Marca1_idx` (`Marca_id` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_ArmadoProducto1`
    FOREIGN KEY (`ArmadoProducto_id1`)
    REFERENCES `caso3`.`ArmadoProducto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Marca1`
    FOREIGN KEY (`Marca_id`)
    REFERENCES `caso3`.`Marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`EtapaArmado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`EtapaArmado` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`EtapaArmado-ArmadoProd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`EtapaArmado-ArmadoProd` (
  `id` INT NOT NULL,
  `fecha_hora_inicio` DATETIME NOT NULL,
  `fecha_hora_fin` DATETIME NULL,
  `descripcion` VARCHAR(45) NULL,
  `costo_etapa` DECIMAL(5,2) NULL,
  `ArmadoProducto_id` INT NOT NULL,
  `EtapaArmado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_EtapaArmado-ArmadoProd_EtapaArmado1_idx` (`EtapaArmado_id` ASC) VISIBLE,
  INDEX `fk_EtapaArmado-ArmadoProd_ArmadoProducto1_idx` (`ArmadoProducto_id` ASC) VISIBLE,
  CONSTRAINT `fk_EtapaArmado-ArmadoProd_EtapaArmado1`
    FOREIGN KEY (`EtapaArmado_id`)
    REFERENCES `caso3`.`EtapaArmado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EtapaArmado-ArmadoProd_ArmadoProducto1`
    FOREIGN KEY (`ArmadoProducto_id`)
    REFERENCES `caso3`.`ArmadoProducto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Especializacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Especializacion` (
  `id` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Factura` (
  `id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `costo_total` DECIMAL(7,2) NULL,
  `descripcion` VARCHAR(45) NULL,
  `Proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Factura_Proveedor1_idx` (`Proveedor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Factura_Proveedor1`
    FOREIGN KEY (`Proveedor_id`)
    REFERENCES `caso3`.`Proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Profesion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Profesion` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `sueldo_hr` DECIMAL(5,2) NOT NULL,
  `sueldo_jornada` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipo_UNIQUE` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Empleado` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(11) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `Profesion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `fk_Empleado_Profesion1_idx` (`Profesion_id` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Profesion1`
    FOREIGN KEY (`Profesion_id`)
    REFERENCES `caso3`.`Profesion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Jefe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Jefe` (
  `id` INT NOT NULL,
  `fecha_ascenso` DATE NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `sueldo_extra` DECIMAL(5,2) NOT NULL,
  `Empleado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Jefe_Empleado1_idx` (`Empleado_id` ASC) VISIBLE,
  CONSTRAINT `fk_Jefe_Empleado1`
    FOREIGN KEY (`Empleado_id`)
    REFERENCES `caso3`.`Empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`LineaEnsamblaje-Jefe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`LineaEnsamblaje-Jefe` (
  `id` INT NOT NULL,
  `hora_fecha_asign` DATETIME NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `LineaEnsamblaje_id` INT NOT NULL,
  `Jefe_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_LineaEnsamblaje-Jefe_LineaEnsamblaje1_idx` (`LineaEnsamblaje_id` ASC) VISIBLE,
  INDEX `fk_LineaEnsamblaje-Jefe_Jefe1_idx` (`Jefe_id` ASC) VISIBLE,
  CONSTRAINT `fk_LineaEnsamblaje-Jefe_LineaEnsamblaje1`
    FOREIGN KEY (`LineaEnsamblaje_id`)
    REFERENCES `caso3`.`LineaEnsamblaje` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LineaEnsamblaje-Jefe_Jefe1`
    FOREIGN KEY (`Jefe_id`)
    REFERENCES `caso3`.`Jefe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`PuestoTrabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`PuestoTrabajo` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `Profesion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `puesto_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_PuestoTrabajo_Profesion1_idx` (`Profesion_id` ASC) VISIBLE,
  CONSTRAINT `fk_PuestoTrabajo_Profesion1`
    FOREIGN KEY (`Profesion_id`)
    REFERENCES `caso3`.`Profesion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`LineaEnsam-PuestoTrab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`LineaEnsam-PuestoTrab` (
  `id` INT NOT NULL,
  `hora_fecha_creac` DATETIME NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `LineaEnsamblaje_id` INT NOT NULL,
  `PuestoTrabajo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_LineaEnsam-PuestoTrabajo_LineaEnsamblaje1_idx` (`LineaEnsamblaje_id` ASC) VISIBLE,
  INDEX `fk_LineaEnsam-PuestoTrabajo_PuestoTrabajo1_idx` (`PuestoTrabajo_id` ASC) VISIBLE,
  CONSTRAINT `fk_LineaEnsam-PuestoTrabajo_LineaEnsamblaje1`
    FOREIGN KEY (`LineaEnsamblaje_id`)
    REFERENCES `caso3`.`LineaEnsamblaje` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LineaEnsam-PuestoTrabajo_PuestoTrabajo1`
    FOREIGN KEY (`PuestoTrabajo_id`)
    REFERENCES `caso3`.`PuestoTrabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`LineaEnsam-Especializ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`LineaEnsam-Especializ` (
  `id` INT NOT NULL,
  `fecha_hora_espec` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `LineaEnsamblaje_id` INT NOT NULL,
  `Especializacion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_TipoLinea-LineaEnsam_LineaEnsamblaje1_idx` (`LineaEnsamblaje_id` ASC) VISIBLE,
  INDEX `fk_TipoLinea-LineaEnsam_Especializacion1_idx` (`Especializacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_TipoLinea-LineaEnsam_LineaEnsamblaje1`
    FOREIGN KEY (`LineaEnsamblaje_id`)
    REFERENCES `caso3`.`LineaEnsamblaje` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TipoLinea-LineaEnsam_Especializacion1`
    FOREIGN KEY (`Especializacion_id`)
    REFERENCES `caso3`.`Especializacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`TipoBodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`TipoBodega` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Bodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Bodega` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `cantidad_max` INT NOT NULL,
  `encargado` VARCHAR(45) NOT NULL,
  `telefono_encargado` VARCHAR(11) NOT NULL,
  `TipoBodega_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_Bodega_TipoBodega1_idx` (`TipoBodega_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bodega_TipoBodega1`
    FOREIGN KEY (`TipoBodega_id`)
    REFERENCES `caso3`.`TipoBodega` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`DetFactura-Componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`DetFactura-Componente` (
  `id` INT NOT NULL,
  `costo_unit_envio` DECIMAL(5,2) NULL,
  `Factura_id` INT NOT NULL,
  `Componente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Factura-Componente_Factura1_idx` (`Factura_id` ASC) VISIBLE,
  INDEX `fk_Factura-Componente_Componente1_idx` (`Componente_id` ASC) VISIBLE,
  CONSTRAINT `fk_Factura-Componente_Factura1`
    FOREIGN KEY (`Factura_id`)
    REFERENCES `caso3`.`Factura` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura-Componente_Componente1`
    FOREIGN KEY (`Componente_id`)
    REFERENCES `caso3`.`Componente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`PuestoTrab-Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`PuestoTrab-Empleado` (
  `id` INT NOT NULL,
  `fecha_hora_inicio` DATETIME NOT NULL,
  `fecha_hora_fin` DATETIME NULL,
  `descripcion` VARCHAR(45) NULL,
  `PuestoTrabajo_id` INT NOT NULL,
  `Empleado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PuestoTrab-Empleado_PuestoTrabajo1_idx` (`PuestoTrabajo_id` ASC) VISIBLE,
  INDEX `fk_PuestoTrab-Empleado_Empleado1_idx` (`Empleado_id` ASC) VISIBLE,
  CONSTRAINT `fk_PuestoTrab-Empleado_PuestoTrabajo1`
    FOREIGN KEY (`PuestoTrabajo_id`)
    REFERENCES `caso3`.`PuestoTrabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PuestoTrab-Empleado_Empleado1`
    FOREIGN KEY (`Empleado_id`)
    REFERENCES `caso3`.`Empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Bodega-Parte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Bodega-Parte` (
  `id` INT NOT NULL,
  `fecha_almacenam` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Bodega_id` INT NOT NULL,
  `Parte_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Bodega-Parte_Bodega1_idx` (`Bodega_id` ASC) VISIBLE,
  INDEX `fk_Bodega-Parte_Parte1_idx` (`Parte_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bodega-Parte_Bodega1`
    FOREIGN KEY (`Bodega_id`)
    REFERENCES `caso3`.`Bodega` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bodega-Parte_Parte1`
    FOREIGN KEY (`Parte_id`)
    REFERENCES `caso3`.`Parte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Bodega-Componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Bodega-Componente` (
  `id` INT NOT NULL,
  `fecha_almacenam` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Bodega_id` INT NOT NULL,
  `Componente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Bodega-Parte_Bodega1_idx` (`Bodega_id` ASC) VISIBLE,
  INDEX `fk_Bodega-Componente_Componente1_idx` (`Componente_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bodega-Parte_Bodega10`
    FOREIGN KEY (`Bodega_id`)
    REFERENCES `caso3`.`Bodega` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bodega-Componente_Componente1`
    FOREIGN KEY (`Componente_id`)
    REFERENCES `caso3`.`Componente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Bodega-Armado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Bodega-Armado` (
  `id` INT NOT NULL,
  `fecha_almacenam` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Bodega_id` INT NOT NULL,
  `ArmadoProducto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Bodega-Parte_Bodega1_idx` (`Bodega_id` ASC) VISIBLE,
  INDEX `fk_Bodega-Armado_ArmadoProducto1_idx` (`ArmadoProducto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bodega-Parte_Bodega100`
    FOREIGN KEY (`Bodega_id`)
    REFERENCES `caso3`.`Bodega` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bodega-Armado_ArmadoProducto1`
    FOREIGN KEY (`ArmadoProducto_id`)
    REFERENCES `caso3`.`ArmadoProducto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso3`.`Reclamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso3`.`Reclamo` (
  `id` INT NOT NULL,
  `fecha` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `DetFactura-Componente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Reclamo_DetFactura-Componente1_idx` (`DetFactura-Componente_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reclamo_DetFactura-Componente1`
    FOREIGN KEY (`DetFactura-Componente_id`)
    REFERENCES `caso3`.`DetFactura-Componente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
