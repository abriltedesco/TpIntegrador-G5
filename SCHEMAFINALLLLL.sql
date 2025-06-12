-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema TPintegrador
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TPintegrador
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TPintegrador` DEFAULT CHARACTER SET utf8mb3 ;
USE `TPintegrador` ;

-- -----------------------------------------------------
-- Table `TPintegrador`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`categoria` (
  `idCategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`estado` (
  `idEstado` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`producto` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`usuario` (
  `idUsuario` INT NOT NULL,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  `nivel` VARCHAR(45) NULL DEFAULT NULL,
  `reputacion` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`subasta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`subasta` (
  `idSubasta` INT NOT NULL,
  PRIMARY KEY (`idSubasta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`publicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`publicacion` (
  `idPublicacion` INT NOT NULL,
  `idUsuarioV` INT NULL DEFAULT NULL,
  `idCategoria` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `precio` FLOAT NULL DEFAULT NULL,
  `estaActiva` TINYINT NULL DEFAULT NULL,
  `fechaPublicacion` DATE NULL DEFAULT NULL,
  `idEstado` INT NOT NULL,
  `nivelVistas` VARCHAR(45) NULL DEFAULT NULL,
  `subasta_idSubasta` INT NULL,
  PRIMARY KEY (`idPublicacion`),
  INDEX `fk_publicacion_categoria_idx` (`idCategoria` ASC) VISIBLE,
  INDEX `fk_publicacion_producto1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_publicacion_estado1_idx` (`idEstado` ASC) VISIBLE,
  INDEX `fk_publicacion_usuario_idx` (`idUsuarioV` ASC) VISIBLE,
  INDEX `fk_publicacion_subasta1_idx` (`subasta_idSubasta` ASC) VISIBLE,
  CONSTRAINT `fk_publicacion_categoria`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `TPintegrador`.`categoria` (`idCategoria`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_publicacion_estado1`
    FOREIGN KEY (`idEstado`)
    REFERENCES `TPintegrador`.`estado` (`idEstado`),
  CONSTRAINT `fk_publicacion_producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `TPintegrador`.`producto` (`idProducto`),
  CONSTRAINT `fk_publicacion_usuario`
    FOREIGN KEY (`idUsuarioV`)
    REFERENCES `TPintegrador`.`usuario` (`idUsuario`),
  CONSTRAINT `fk_publicacion_subasta1`
    FOREIGN KEY (`subasta_idSubasta`)
    REFERENCES `TPintegrador`.`subasta` (`idSubasta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`comentario` (
  `idComentario` INT NOT NULL,
  `idPublicacion` INT NOT NULL,
  `pregunta` LONGTEXT NULL DEFAULT NULL,
  `idUsuarioPregunta` INT NULL DEFAULT NULL,
  `respuesta` LONGTEXT NULL DEFAULT NULL,
  `fecha` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idComentario`),
  INDEX `fk_comentario_publicacion1_idx` (`idPublicacion` ASC) VISIBLE,
  INDEX `fk_comentario_usuario_idx` (`idUsuarioPregunta` ASC) VISIBLE,
  CONSTRAINT `fk_comentario_publicacion1`
    FOREIGN KEY (`idPublicacion`)
    REFERENCES `TPintegrador`.`publicacion` (`idPublicacion`),
  CONSTRAINT `fk_comentario_usuario`
    FOREIGN KEY (`idUsuarioPregunta`)
    REFERENCES `TPintegrador`.`usuario` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`metodoEnvio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`metodoEnvio` (
  `idMetodoEnvio` INT NOT NULL,
  `empresa` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idMetodoEnvio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`metodoPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`metodoPago` (
  `idMetodoPago` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idMetodoPago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`ventaDirecta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`ventaDirecta` (
  `idVentaDirecta` INT NOT NULL,
  `idMetodoPago` INT NOT NULL,
  `idMetodoEnvio` INT NOT NULL,
  PRIMARY KEY (`idVentaDirecta`),
  INDEX `fk_ventaDirecta_metodoPago1_idx` (`idMetodoPago` ASC) VISIBLE,
  INDEX `fk_ventaDirecta_metodoEnvio1_idx` (`idMetodoEnvio` ASC) VISIBLE,
  CONSTRAINT `fk_ventaDirecta_metodoEnvio1`
    FOREIGN KEY (`idMetodoEnvio`)
    REFERENCES `TPintegrador`.`metodoEnvio` (`idMetodoEnvio`),
  CONSTRAINT `fk_ventaDirecta_metodoPago1`
    FOREIGN KEY (`idMetodoPago`)
    REFERENCES `TPintegrador`.`metodoPago` (`idMetodoPago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`compra` (
  `idPublicacion` INT NOT NULL,
  `idVentaDirecta` INT NOT NULL,
  `idComprador` INT NOT NULL,
  `satisfaccionC` INT NULL DEFAULT NULL,
  `satisfaccionV` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idPublicacion`),
  INDEX `fk_usuario_has_publicacion_publicacion1_idx` (`idPublicacion` ASC) VISIBLE,
  INDEX `fk_usuario_has_publicacion_usuario1_idx` (`idComprador` ASC) VISIBLE,
  INDEX `fk_compra_ventaDirecta1_idx` (`idVentaDirecta` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_publicacion_publicacion1`
    FOREIGN KEY (`idPublicacion`)
    REFERENCES `TPintegrador`.`publicacion` (`idPublicacion`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_usuario_has_publicacion_usuario1`
    FOREIGN KEY (`idComprador`)
    REFERENCES `TPintegrador`.`usuario` (`idUsuario`),
  CONSTRAINT `fk_compra_ventaDirecta1`
    FOREIGN KEY (`idVentaDirecta`)
    REFERENCES `TPintegrador`.`ventaDirecta` (`idVentaDirecta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPintegrador`.`historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPintegrador`.`historial` (
  `idHistorial` INT NOT NULL,
  `montoOfertado` FLOAT NULL,
  `idOfertante` INT NULL,
  `fecha` DATE NULL,
  `idSubasta` INT NOT NULL,
  PRIMARY KEY (`idHistorial`),
  INDEX `fk_historial_subasta1_idx` (`idSubasta` ASC) VISIBLE,
  CONSTRAINT `fk_historial_subasta1`
    FOREIGN KEY (`idSubasta`)
    REFERENCES `TPintegrador`.`subasta` (`idSubasta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historial_usuario`
    FOREIGN KEY (`idOfertante`)
    REFERENCES `TPintegrador`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
