-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tienda
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tienda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tienda` DEFAULT CHARACTER SET utf8 ;
USE `tienda` ;

-- -----------------------------------------------------
-- Table `tienda`.`TIENDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`TIENDA` (
  `ciudad` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ciudad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`CATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`CATEGORIA` (
  `cod_categoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `subcategoria_de` INT NULL,
  PRIMARY KEY (`cod_categoria`),
  INDEX `fk_CATEGORIA_CATEGORIA1_idx` (`subcategoria_de` ASC)  ,
  CONSTRAINT `fk_CATEGORIA_CATEGORIA1`
    FOREIGN KEY (`subcategoria_de`)
    REFERENCES `tienda`.`CATEGORIA` (`cod_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`PRODUCTO` (
  `num_producto` INT NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NULL,
  `precio` DECIMAL(5,2) NOT NULL,
  `tipo_piel_cabello` VARCHAR(50) NULL,
  `cod_categoria` INT NOT NULL,
  PRIMARY KEY (`num_producto`, `cod_categoria`),
  INDEX `fk_PRODUCTO_CATEGORIA1_idx` (`cod_categoria` ASC)  ,
  CONSTRAINT `fk_PRODUCTO_CATEGORIA1`
    FOREIGN KEY (`cod_categoria`)
    REFERENCES `tienda`.`CATEGORIA` (`cod_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`EMPLEADO` (
  `num_empleado` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `edad` INT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `supervisa_a` INT NULL,
  PRIMARY KEY (`num_empleado`, `ciudad`),
  INDEX `fk_EMPLEADO_TIENDA1_idx` (`ciudad` ASC)  ,
  INDEX `fk_EMPLEADO_EMPLEADO1_idx` (`supervisa_a` ASC)  ,
  CONSTRAINT `fk_EMPLEADO_TIENDA1`
    FOREIGN KEY (`ciudad`)
    REFERENCES `tienda`.`TIENDA` (`ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_EMPLEADO1`
    FOREIGN KEY (`supervisa_a`)
    REFERENCES `tienda`.`EMPLEADO` (`num_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`VENDEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`VENDEDOR` (
  `num_empleado` INT NOT NULL,
  PRIMARY KEY (`num_empleado`),
  CONSTRAINT `fk_VENDEDOR_EMPLEADO1`
    FOREIGN KEY (`num_empleado`)
    REFERENCES `tienda`.`EMPLEADO` (`num_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`CURSO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`CURSO` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`MAQUILLADOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`MAQUILLADOR` (
  `num_empleado` INT NOT NULL,
  `codigo` INT NOT NULL,
  PRIMARY KEY (`num_empleado`, `codigo`),
  INDEX `fk_MAQUILLADOR_CURSO1_idx` (`codigo` ASC)  ,
  CONSTRAINT `fk_MAQUILLADOR_EMPLEADO1`
    FOREIGN KEY (`num_empleado`)
    REFERENCES `tienda`.`EMPLEADO` (`num_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MAQUILLADOR_CURSO1`
    FOREIGN KEY (`codigo`)
    REFERENCES `tienda`.`CURSO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`ENCARGADO_INVENTARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`ENCARGADO_INVENTARIO` (
  `num_empleado` INT NOT NULL,
  PRIMARY KEY (`num_empleado`),
  CONSTRAINT `fk_ENCARGADO INVENTARIO_EMPLEADO1`
    FOREIGN KEY (`num_empleado`)
    REFERENCES `tienda`.`EMPLEADO` (`num_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`VENDE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`VENDE` (
  `num_empleado` INT NOT NULL,
  `num_producto` INT NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`num_empleado`, `num_producto`, `ciudad`),
  INDEX `fk_VENDEDOR_has_PRODUCTO_PRODUCTO1_idx` (`num_producto` ASC)  ,
  INDEX `fk_VENDEDOR_has_PRODUCTO_VENDEDOR1_idx` (`num_empleado` ASC)  ,
  INDEX `fk_VENDE_TIENDA1_idx` (`ciudad` ASC)  ,
  CONSTRAINT `fk_VENDEDOR_has_PRODUCTO_VENDEDOR1`
    FOREIGN KEY (`num_empleado`)
    REFERENCES `tienda`.`VENDEDOR` (`num_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENDEDOR_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`num_producto`)
    REFERENCES `tienda`.`PRODUCTO` (`num_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENDE_TIENDA1`
    FOREIGN KEY (`ciudad`)
    REFERENCES `tienda`.`TIENDA` (`ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`PROVEEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`PROVEEDOR` (
  `cod_proveedor` INT NOT NULL,
  `nombre_empresa` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`DISTRIBUYE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`DISTRIBUYE` (
  `cod_proveedor` INT NOT NULL,
  `num_producto` INT NOT NULL,
  PRIMARY KEY (`cod_proveedor`, `num_producto`),
  INDEX `fk_PROVEEDOR_has_PRODUCTO_PRODUCTO1_idx` (`num_producto` ASC)  ,
  INDEX `fk_PROVEEDOR_has_PRODUCTO_PROVEEDOR1_idx` (`cod_proveedor` ASC)  ,
  CONSTRAINT `fk_PROVEEDOR_has_PRODUCTO_PROVEEDOR1`
    FOREIGN KEY (`cod_proveedor`)
    REFERENCES `tienda`.`PROVEEDOR` (`cod_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROVEEDOR_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`num_producto`)
    REFERENCES `tienda`.`PRODUCTO` (`num_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`VERSION_ESPECIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`VERSION_ESPECIAL` (
  `num_serie` VARCHAR(45) NOT NULL,
  `nombre_especial` VARCHAR(45) NULL,
  `num_producto` INT NULL,
  PRIMARY KEY (`num_serie`),
  INDEX `fk_VERSION_ESPECIAL_PRODUCTO1_idx` (`num_producto` ASC)  ,
  CONSTRAINT `fk_VERSION_ESPECIAL_PRODUCTO1`
    FOREIGN KEY (`num_producto`)
    REFERENCES `tienda`.`PRODUCTO` (`num_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`PROFESIONAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`PROFESIONAL` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`CLIENTE` (
  `DNI` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `tipo_piel_cabello` VARCHAR(70) NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`RECOMIENDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`RECOMIENDA` (
  `codigo` INT NOT NULL,
  `num_producto` INT NOT NULL,
  `DNI` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`, `num_producto`, `DNI`),
  INDEX `fk_PROFESIONAL_has_PRODUCTO_PRODUCTO1_idx` (`num_producto` ASC)  ,
  INDEX `fk_PROFESIONAL_has_PRODUCTO_PROFESIONAL1_idx` (`codigo` ASC)  ,
  INDEX `fk_RECOMIENDA_CLIENTE1_idx` (`DNI` ASC)  ,
  CONSTRAINT `fk_PROFESIONAL_has_PRODUCTO_PROFESIONAL1`
    FOREIGN KEY (`codigo`)
    REFERENCES `tienda`.`PROFESIONAL` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROFESIONAL_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`num_producto`)
    REFERENCES `tienda`.`PRODUCTO` (`num_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECOMIENDA_CLIENTE1`
    FOREIGN KEY (`DNI`)
    REFERENCES `tienda`.`CLIENTE` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`KIT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`KIT` (
  `cod_kit` INT NOT NULL,
  `nombre_kit` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_kit`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`CONTIENE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`CONTIENE` (
  `num_producto` INT NOT NULL,
  `cod_kit` INT NOT NULL,
  PRIMARY KEY (`num_producto`, `cod_kit`),
  INDEX `fk_PRODUCTO_has_KIT MAQUILLAJE_KIT MAQUILLAJE1_idx` (`cod_kit` ASC)  ,
  INDEX `fk_PRODUCTO_has_KIT MAQUILLAJE_PRODUCTO1_idx` (`num_producto` ASC)  ,
  CONSTRAINT `fk_PRODUCTO_has_KIT MAQUILLAJE_PRODUCTO1`
    FOREIGN KEY (`num_producto`)
    REFERENCES `tienda`.`PRODUCTO` (`num_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTO_has_KIT MAQUILLAJE_KIT MAQUILLAJE1`
    FOREIGN KEY (`cod_kit`)
    REFERENCES `tienda`.`KIT` (`cod_kit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`PUNTUA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`PUNTUA` (
  `num_producto` INT NULL,
  `nota` INT NULL,
  `comentario` VARCHAR(100) NULL,
  `DNI` VARCHAR(45) NULL,
  PRIMARY KEY (`num_producto`, `DNI`),
  INDEX `fk_CLIENTE_has_PRODUCTO_PRODUCTO1_idx` (`num_producto` ASC)  ,
  INDEX `fk_PUNTUA_CLIENTE2_idx` (`DNI` ASC)  ,
  CONSTRAINT `fk_CLIENTE_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`num_producto`)
    REFERENCES `tienda`.`PRODUCTO` (`num_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PUNTUA_CLIENTE2`
    FOREIGN KEY (`DNI`)
    REFERENCES `tienda`.`CLIENTE` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`COMPRA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`COMPRA` (
  `DNI` VARCHAR(45) NOT NULL,
  `num_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`DNI`, `num_producto`),
  INDEX `fk_CLIENTE_has_PRODUCTO_PRODUCTO2_idx` (`num_producto` ASC)  ,
  INDEX `fk_CLIENTE_has_PRODUCTO_CLIENTE2_idx` (`DNI` ASC)  ,
  CONSTRAINT `fk_CLIENTE_has_PRODUCTO_CLIENTE2`
    FOREIGN KEY (`DNI`)
    REFERENCES `tienda`.`CLIENTE` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CLIENTE_has_PRODUCTO_PRODUCTO2`
    FOREIGN KEY (`num_producto`)
    REFERENCES `tienda`.`PRODUCTO` (`num_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`VIP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`VIP` (
  `DNI` VARCHAR(45) NOT NULL,
  `promociones` VARCHAR(100) NULL,
  PRIMARY KEY (`DNI`),
  CONSTRAINT `fk_VIP_CLIENTE1`
    FOREIGN KEY (`DNI`)
    REFERENCES `tienda`.`CLIENTE` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`PREMIUM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`PREMIUM` (
  `DNI` VARCHAR(45) NOT NULL,
  `descuento` VARCHAR(100) NULL,
  PRIMARY KEY (`DNI`),
  CONSTRAINT `fk_PREMIUM_CLIENTE1`
    FOREIGN KEY (`DNI`)
    REFERENCES `tienda`.`CLIENTE` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`PAGO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`PAGO` (
  `num_transaccion` VARCHAR(50) NOT NULL,
  `forma_pago` VARCHAR(45) NOT NULL,
  `fecha_pago` DATE NOT NULL,
  `DNI` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`num_transaccion`, `DNI`),
  INDEX `fk_PAGO_CLIENTE1_idx` (`DNI` ASC)  ,
  CONSTRAINT `fk_PAGO_CLIENTE1`
    FOREIGN KEY (`DNI`)
    REFERENCES `tienda`.`CLIENTE` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`MAQUILLA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`MAQUILLA` (
  `num_empleado` INT NOT NULL,
  `DNI` VARCHAR(45) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `precio` DECIMAL(5,2) NOT NULL,
  `duracion` TIME NULL,
  PRIMARY KEY (`num_empleado`, `DNI`),
  INDEX `fk_MAQUILLADOR_has_CLIENTE_CLIENTE1_idx` (`DNI` ASC)  ,
  INDEX `fk_MAQUILLADOR_has_CLIENTE_MAQUILLADOR1_idx` (`num_empleado` ASC)  ,
  CONSTRAINT `fk_MAQUILLADOR_has_CLIENTE_MAQUILLADOR1`
    FOREIGN KEY (`num_empleado`)
    REFERENCES `tienda`.`MAQUILLADOR` (`num_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MAQUILLADOR_has_CLIENTE_CLIENTE1`
    FOREIGN KEY (`DNI`)
    REFERENCES `tienda`.`CLIENTE` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`PIDE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`PIDE` (
  `num_empleado` INT NOT NULL,
  `num_producto` INT NOT NULL,
  `cod_proveedor` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha` DATE NULL,
  PRIMARY KEY (`num_empleado`, `num_producto`, `cod_proveedor`),
  INDEX `fk_ENCARGADO_INVENTARIO_has_PRODUCTO_PRODUCTO1_idx` (`num_producto` ASC)  ,
  INDEX `fk_ENCARGADO_INVENTARIO_has_PRODUCTO_ENCARGADO_INVENTARIO1_idx` (`num_empleado` ASC)  ,
  INDEX `fk_PIDE_PROVEEDOR1_idx` (`cod_proveedor` ASC)  ,
  CONSTRAINT `fk_ENCARGADO_INVENTARIO_has_PRODUCTO_ENCARGADO_INVENTARIO1`
    FOREIGN KEY (`num_empleado`)
    REFERENCES `tienda`.`ENCARGADO_INVENTARIO` (`num_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENCARGADO_INVENTARIO_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`num_producto`)
    REFERENCES `tienda`.`PRODUCTO` (`num_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PIDE_PROVEEDOR1`
    FOREIGN KEY (`cod_proveedor`)
    REFERENCES `tienda`.`PROVEEDOR` (`cod_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
