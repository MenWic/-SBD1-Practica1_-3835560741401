-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `caso1` ;

-- -----------------------------------------------------
-- Schema caso1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso1` DEFAULT CHARACTER SET utf8 ;
USE `caso1` ;

-- -----------------------------------------------------
-- Table `caso1`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Categoria` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Producto_Inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Producto_Inventario` (
  `id` INT NOT NULL,
  `sku` VARCHAR(13) NOT NULL,
  `fecha_entrada` DATE NOT NULL,
  `precio_unit` DOUBLE NOT NULL,
  `cantidad_stock` INT NOT NULL,
  `Categoria_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idInventario_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `inv_sku_UNIQUE` (`sku` ASC) VISIBLE,
  INDEX `fk_Inventario_Producto_Categoria1_idx` (`Categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Inventario_Producto_Categoria1`
    FOREIGN KEY (`Categoria_id`)
    REFERENCES `caso1`.`Categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Tipo_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Tipo_Pedido` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tp_descripcion_UNIQUE` (`descripcion` ASC) VISIBLE,
  UNIQUE INDEX `tp_id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Departamento` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dep_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `dep_descripcion_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Tipo_Tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Tipo_Tienda` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tt_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `tt_descripcion_UNIQUE` (`descripcion` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Tienda` (
  `id` INT NOT NULL,
  `telefono` VARCHAR(8) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `descriptores` VARCHAR(45) NULL,
  `Departamento_id` INT NOT NULL,
  `Tipo_Tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tie_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `tie_descripcion_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `fk_Tienda_Departamento1_idx` (`Departamento_id` ASC) VISIBLE,
  INDEX `fk_Tienda_Tipo_Tienda1_idx` (`Tipo_Tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_Tienda_Departamento1`
    FOREIGN KEY (`Departamento_id`)
    REFERENCES `caso1`.`Departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tienda_Tipo_Tienda1`
    FOREIGN KEY (`Tipo_Tienda_id`)
    REFERENCES `caso1`.`Tipo_Tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Pedido` (
  `id` INT NOT NULL,
  `fecha_entrega` DATETIME NOT NULL,
  `monto_total` VARCHAR(45) NOT NULL,
  `muelle_carga` VARCHAR(45) NOT NULL,
  `Tienda_id` INT NOT NULL,
  `Tipo_Pedido_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idPedidos_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Pedido_Tipo_Pedido1_idx` (`Tipo_Pedido_id` ASC) VISIBLE,
  INDEX `fk_Pedido_Tienda1_idx` (`Tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Tipo_Pedido1`
    FOREIGN KEY (`Tipo_Pedido_id`)
    REFERENCES `caso1`.`Tipo_Pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Tienda1`
    FOREIGN KEY (`Tienda_id`)
    REFERENCES `caso1`.`Tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Asginacion_Espacio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Asginacion_Espacio` (
  `id` INT NOT NULL,
  `linea` VARCHAR(45) NOT NULL,
  `estanteria` VARCHAR(45) NOT NULL,
  `nivel` VARCHAR(45) NOT NULL,
  `descriptores` VARCHAR(45) NOT NULL,
  `Tienda_id` INT NOT NULL,
  `Producto_Inventario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ae_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Asginacion_Espacio_Tienda1_idx` (`Tienda_id` ASC) VISIBLE,
  INDEX `fk_Asginacion_Espacio_Producto_Inventario1_idx` (`Producto_Inventario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Asginacion_Espacio_Tienda1`
    FOREIGN KEY (`Tienda_id`)
    REFERENCES `caso1`.`Tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asginacion_Espacio_Producto_Inventario1`
    FOREIGN KEY (`Producto_Inventario_id`)
    REFERENCES `caso1`.`Producto_Inventario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Devolucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Devolucion` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `Pedido_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dev_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Devolucion_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
  CONSTRAINT `fk_Devolucion_Pedido1`
    FOREIGN KEY (`Pedido_id`)
    REFERENCES `caso1`.`Pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Empresa` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(8) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Proveedor` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `Empresa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Proveedor_Empresa1_idx` (`Empresa_id` ASC) VISIBLE,
  CONSTRAINT `fk_Proveedor_Empresa1`
    FOREIGN KEY (`Empresa_id`)
    REFERENCES `caso1`.`Empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Producto` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `precio_unit` DOUBLE NOT NULL,
  `Categoria_id` INT NOT NULL,
  `Proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Producto_Categoria1_idx` (`Categoria_id` ASC) VISIBLE,
  INDEX `fk_Producto_Proveedor1_idx` (`Proveedor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_id`)
    REFERENCES `caso1`.`Categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Proveedor1`
    FOREIGN KEY (`Proveedor_id`)
    REFERENCES `caso1`.`Proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Detalle_Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Detalle_Pedidos` (
  `id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `Pedido_id` INT NOT NULL,
  `Producto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dp_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Detalle_Pedidos_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
  INDEX `fk_Detalle_Pedidos_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Detalle_Pedidos_Pedido1`
    FOREIGN KEY (`Pedido_id`)
    REFERENCES `caso1`.`Pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_Pedidos_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `caso1`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Rol` (
  `id` INT NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `rol_UNIQUE` (`rol` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Area_Trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Area_Trabajo` (
  `id` INT NOT NULL,
  `area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `area_UNIQUE` (`area` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Jornada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Jornada` (
  `id` INT NOT NULL,
  `jornada` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `jornada_UNIQUE` (`jornada` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Seccion_Area_Trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Seccion_Area_Trabajo` (
  `id` INT NOT NULL,
  `seccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `seccion_UNIQUE` (`seccion` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Empleado` (
  `id` INT NOT NULL,
  `numero_empleado` VARCHAR(7) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sueldo` DOUBLE NOT NULL,
  `rendimiento` VARCHAR(10) NULL,
  `telefono` VARCHAR(8) NULL,
  `email` VARCHAR(45) NULL,
  `numero_igss` VARCHAR(12) NULL,
  `Tienda_id` INT NOT NULL,
  `Rol_id` INT NOT NULL,
  `Area_Trabajo_id` INT NOT NULL,
  `Seccion_Area_Trabajo_id` INT NOT NULL,
  `Jornada_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `dpi_UNIQUE` (`numero_empleado` ASC) VISIBLE,
  INDEX `fk_Empñeado_Rol1_idx` (`Rol_id` ASC) VISIBLE,
  INDEX `fk_Empleado_Tienda1_idx` (`Tienda_id` ASC) VISIBLE,
  INDEX `fk_Empleado_Area_Trabajo1_idx` (`Area_Trabajo_id` ASC) VISIBLE,
  INDEX `fk_Empleado_Jornada1_idx` (`Jornada_id` ASC) VISIBLE,
  INDEX `fk_Empleado_Seccion_Area_Trabajo1_idx` (`Seccion_Area_Trabajo_id` ASC) VISIBLE,
  CONSTRAINT `fk_Empñeado_Rol1`
    FOREIGN KEY (`Rol_id`)
    REFERENCES `caso1`.`Rol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Tienda1`
    FOREIGN KEY (`Tienda_id`)
    REFERENCES `caso1`.`Tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Area_Trabajo1`
    FOREIGN KEY (`Area_Trabajo_id`)
    REFERENCES `caso1`.`Area_Trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Jornada1`
    FOREIGN KEY (`Jornada_id`)
    REFERENCES `caso1`.`Jornada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Seccion_Area_Trabajo1`
    FOREIGN KEY (`Seccion_Area_Trabajo_id`)
    REFERENCES `caso1`.`Seccion_Area_Trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Capacitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Capacitacion` (
  `id` INT NOT NULL,
  `tema` VARCHAR(45) NOT NULL,
  `encargado` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `lugar` VARCHAR(45) NOT NULL,
  `certificado` TINYINT NOT NULL,
  `Area_Trabajo_id` INT NOT NULL,
  `Seccion_Area_Trabajo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Capacitacion_Area_Trabajo1_idx` (`Area_Trabajo_id` ASC) VISIBLE,
  INDEX `fk_Capacitacion_Seccion_Area_Trabajo1_idx` (`Seccion_Area_Trabajo_id` ASC) VISIBLE,
  CONSTRAINT `fk_Capacitacion_Area_Trabajo1`
    FOREIGN KEY (`Area_Trabajo_id`)
    REFERENCES `caso1`.`Area_Trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Capacitacion_Seccion_Area_Trabajo1`
    FOREIGN KEY (`Seccion_Area_Trabajo_id`)
    REFERENCES `caso1`.`Seccion_Area_Trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Empleado_Capacitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Empleado_Capacitacion` (
  `id` INT NOT NULL,
  `fecha_hora` DATE NOT NULL,
  `Capacitacion_id` INT NOT NULL,
  `Empleado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Empleado_Capacitacion_Capacitacion1_idx` (`Capacitacion_id` ASC) VISIBLE,
  INDEX `fk_Empleado_Capacitacion_Empleado1_idx` (`Empleado_id` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Capacitacion_Capacitacion1`
    FOREIGN KEY (`Capacitacion_id`)
    REFERENCES `caso1`.`Capacitacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Capacitacion_Empleado1`
    FOREIGN KEY (`Empleado_id`)
    REFERENCES `caso1`.`Empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Transporte` (
  `id` INT NOT NULL,
  `tipo_transporte` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `Tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Transporte_Tienda1_idx` (`Tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_Transporte_Tienda1`
    FOREIGN KEY (`Tienda_id`)
    REFERENCES `caso1`.`Tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Ruta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Ruta` (
  `id` INT NOT NULL,
  `ruta_ensamblaje` VARCHAR(45) NULL,
  `Tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Ruta_Tienda1_idx` (`Tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ruta_Tienda1`
    FOREIGN KEY (`Tienda_id`)
    REFERENCES `caso1`.`Tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Itinerario_Ruta_Transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Itinerario_Ruta_Transporte` (
  `id` INT NOT NULL,
  `hora_inicio` DATETIME NOT NULL,
  `hora_fin` DATETIME NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Ruta_id` INT NOT NULL,
  `Empleado_id` INT NOT NULL,
  `Transporte_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Vehiculo_y_Ruta_Empleado_Empleado1_idx` (`Empleado_id` ASC) VISIBLE,
  INDEX `fk_Itinerario_Transporte_Transporte1_idx` (`Transporte_id` ASC) VISIBLE,
  INDEX `fk_Itinerario_Transporte_Ruta1_idx` (`Ruta_id` ASC) VISIBLE,
  CONSTRAINT `fk_Vehiculo_y_Ruta_Empleado_Empleado1`
    FOREIGN KEY (`Empleado_id`)
    REFERENCES `caso1`.`Empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Itinerario_Transporte_Transporte1`
    FOREIGN KEY (`Transporte_id`)
    REFERENCES `caso1`.`Transporte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Itinerario_Transporte_Ruta1`
    FOREIGN KEY (`Ruta_id`)
    REFERENCES `caso1`.`Ruta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Maquinaria_Equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Maquinaria_Equipo` (
  `id` INT NOT NULL,
  `item` VARCHAR(45) NOT NULL,
  `fecha_ult_mantenimiento` DATE NULL,
  `Tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Maquinaria_y_Equipo_Tienda1_idx` (`Tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_Maquinaria_y_Equipo_Tienda1`
    FOREIGN KEY (`Tienda_id`)
    REFERENCES `caso1`.`Tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso1`.`Maquinaria_Equipo_Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso1`.`Maquinaria_Equipo_Empleado` (
  `id` INT NOT NULL,
  `fecha` DATE NULL,
  `Maquinaria_Equipo_id` INT NOT NULL,
  `Empleado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Maquinaria_y_Equipo_Empleado_Maquinaria_y_Equipo1_idx` (`Maquinaria_Equipo_id` ASC) VISIBLE,
  INDEX `fk_Maquinaria_y_Equipo_Empleado_Empleado1_idx` (`Empleado_id` ASC) VISIBLE,
  CONSTRAINT `fk_Maquinaria_y_Equipo_Empleado_Maquinaria_y_Equipo1`
    FOREIGN KEY (`Maquinaria_Equipo_id`)
    REFERENCES `caso1`.`Maquinaria_Equipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Maquinaria_y_Equipo_Empleado_Empleado1`
    FOREIGN KEY (`Empleado_id`)
    REFERENCES `caso1`.`Empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
