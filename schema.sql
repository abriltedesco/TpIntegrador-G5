-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TPintegrador
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TPintegrador
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TPintegrador` DEFAULT CHARACTER SET utf8 ;
USE `TPintegrador` ;

-- -----------------------------------------------------
-- Table `TPintegrador`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`usuario` (
  `idUsuario` INT NOT NULL,
  `username` VARCHAR(45) NULL,
  `nivel` VARCHAR(45) NULL,
  `reputacion` INT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ``.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`categoria` (
  `idCategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPintegrador`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`producto` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPintegrador`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`estado` (
  `idEstado` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPintegrador`.`publicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`publicacion` (
  `idPublicacion` INT NOT NULL,
  `idUsuarioV` INT NULL,
  `idCategoria` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `precio` FLOAT NULL,
  `estaActiva` TINYINT NULL,
  `vistas` INT NULL,
  `fechaPublicacion` DATE NULL,
  `idEstado` INT NOT NULL,
  PRIMARY KEY (`idPublicacion`),
  INDEX `fk_publicacion_categoria_idx` (`idCategoria` ASC) VISIBLE,
  INDEX `fk_publicacion_producto1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_publicacion_estado1_idx` (`idEstado` ASC) VISIBLE,
  INDEX `fk_publicacion_usuario_idx` (`idUsuarioV` ASC) VISIBLE,
  CONSTRAINT `fk_publicacion_categoria`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `TPintegrador`.`categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicacion_producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `TPintegrador`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicacion_estado1`
    FOREIGN KEY (`idEstado`)
    REFERENCES `TPintegrador`.`estado` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicacion_usuario`
    FOREIGN KEY (`idUsuarioV`)
    REFERENCES `TPintegrador`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPintegrador`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`compra` (
  `id_Publicacion` INT NOT NULL,
  `idComprador` INT NOT NULL,
  `satisfaccionC` INT NULL,
  `idVendedor` INT NULL,
  INDEX `fk_usuario_has_publicacion_publicacion1_idx` (`id_Publicacion` ASC) VISIBLE,
  INDEX `fk_usuario_has_publicacion_usuario1_idx` (`idComprador` ASC) VISIBLE,
  PRIMARY KEY (`id_Publicacion`),
  CONSTRAINT `fk_usuario_has_publicacion_usuario1`
    FOREIGN KEY (`idComprador`)
    REFERENCES `TPintegrador`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_publicacion_publicacion1`
    FOREIGN KEY (`id_Publicacion`)
    REFERENCES `TPintegrador`.`publicacion` (`idPublicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPintegrador`.`metodoPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`metodoPago` (
  `idMetodoPago` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idMetodoPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPintegrador`.`metodoEnvio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`metodoEnvio` (
  `idMetodoEnvio` INT NOT NULL,
  `empresa` VARCHAR(45) NULL,
  PRIMARY KEY (`idMetodoEnvio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPintegrador`.`ventaDirecta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`ventaDirecta` (
  `idVentaDirecta` INT NOT NULL,
  `idMetodoPago` INT NOT NULL,
  `idMetodoEnvio` INT NOT NULL,
  `idPublicacion` INT NOT NULL,
  PRIMARY KEY (`idVentaDirecta`),
  INDEX `fk_ventaDirecta_metodoPago1_idx` (`idMetodoPago` ASC) VISIBLE,
  INDEX `fk_ventaDirecta_metodoEnvio1_idx` (`idMetodoEnvio` ASC) VISIBLE,
  INDEX `fk_ventaDirecta_publicacion1_idx` (`idPublicacion` ASC) VISIBLE,
  CONSTRAINT `fk_ventaDirecta_metodoPago1`
    FOREIGN KEY (`idMetodoPago`)
    REFERENCES `TPintegrador`.`metodoPago` (`idMetodoPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventaDirecta_metodoEnvio1`
    FOREIGN KEY (`idMetodoEnvio`)
    REFERENCES `TPintegrador`.`metodoEnvio` (`idMetodoEnvio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventaDirecta_publicacion1`
    FOREIGN KEY (`idPublicacion`)
    REFERENCES `TPintegrador`.`publicacion` (`idPublicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPintegrador`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`comentario` (
  `idComentario` INT NOT NULL,
  `pregunta` LONGTEXT NULL,
  `idUsuarioPregunta` INT NULL,
  `respuesta` LONGTEXT NULL,
  `idPublicacion` INT NOT NULL,
  PRIMARY KEY (`idComentario`),
  INDEX `fk_comentario_publicacion1_idx` (`idPublicacion` ASC) VISIBLE,
  CONSTRAINT `fk_comentario_publicacion1`
    FOREIGN KEY (`idPublicacion`)
    REFERENCES `TPintegrador`.`publicacion` (`idPublicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

