-- MySQL Script generated by MySQL Workbench
-- Thu Feb 24 17:46:41 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema picoles
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema picoles
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `picoles` DEFAULT CHARACTER SET utf8 ;
USE `picoles` ;

-- -----------------------------------------------------
-- Table `picoles`.`sabores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`sabores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`tipos_embalagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`tipos_embalagem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`tipos_picole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`tipos_picole` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`ingredientes` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`picoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`picoles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `preco` DECIMAL(8,2) NOT NULL,
  `id_sabor` INT NOT NULL,
  `id_tipo_embalagem` INT NOT NULL,
  `id_tipo_picole` INT NOT NULL,
  `id_ingrediente` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_picoles_1_idx` (`id_sabor` ASC) VISIBLE,
  INDEX `fk_picoles_2_idx` (`id_tipo_embalagem` ASC) VISIBLE,
  INDEX `fk_picoles_3_idx` (`id_tipo_picole` ASC) VISIBLE,
  INDEX `fk_picoles_4_idx` (`id_ingrediente` ASC) VISIBLE,
  CONSTRAINT `fk_picoles_1`
    FOREIGN KEY (`id_sabor`)
    REFERENCES `picoles`.`sabores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picoles_2`
    FOREIGN KEY (`id_tipo_embalagem`)
    REFERENCES `picoles`.`tipos_embalagem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picoles_3`
    FOREIGN KEY (`id_tipo_picole`)
    REFERENCES `picoles`.`tipos_picole` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picoles_4`
    FOREIGN KEY (`id_ingrediente`)
    REFERENCES `picoles`.`ingredientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`ingredientes_picole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`ingredientes_picole` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_ingrediente` INT NOT NULL,
  `id_picole` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ingredientes_picole_1_idx` (`id_ingrediente` ASC) VISIBLE,
  INDEX `fk_ingredienteS_picole_2_idx` (`id_picole` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_picole_1`
    FOREIGN KEY (`id_ingrediente`)
    REFERENCES `picoles`.`ingredientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredienteS_picole_2`
    FOREIGN KEY (`id_picole`)
    REFERENCES `picoles`.`picoles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`aditivos_nutritivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`aditivos_nutritivos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `formula_quimica` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`conservantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`conservantes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`aditivos_nutritivos_picole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`aditivos_nutritivos_picole` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_aditivos_nutritivos` INT NOT NULL,
  `id_picole` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_aditivos_nutritivos_picole_1_idx` (`id_picole` ASC) VISIBLE,
  INDEX `fk_aditivos_nutritivos_picoles_2_idx` (`id_aditivos_nutritivos` ASC) VISIBLE,
  CONSTRAINT `fk_aditivos_nutritivos_picole_1`
    FOREIGN KEY (`id_picole`)
    REFERENCES `picoles`.`picoles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aditivos_nutritivos_picoles_2`
    FOREIGN KEY (`id_aditivos_nutritivos`)
    REFERENCES `picoles`.`aditivos_nutritivos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`conservantes_picole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`conservantes_picole` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_conservantes` INT NOT NULL,
  `id_picole` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conservantes_picole_2_idx` (`id_picole` ASC) VISIBLE,
  INDEX `fk_conservantes_picole_1_idx` (`id_conservantes` ASC) VISIBLE,
  CONSTRAINT `fk_conservantes_picole_1`
    FOREIGN KEY (`id_conservantes`)
    REFERENCES `picoles`.`conservantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conservantes_picole_2`
    FOREIGN KEY (`id_picole`)
    REFERENCES `picoles`.`picoles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`lotes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`lotes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_tipo_picole` INT NOT NULL,
  `quantidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lotes_1_idx` (`id_tipo_picole` ASC) VISIBLE,
  CONSTRAINT `fk_lotes_1`
    FOREIGN KEY (`id_tipo_picole`)
    REFERENCES `picoles`.`aditivos_nutritivos_picole` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`revendedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`revendedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(45) NOT NULL,
  `razao_social` VARCHAR(100) NOT NULL,
  `contato` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`notas_fiscais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`notas_fiscais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `numero_serie` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(200) NOT NULL,
  `id_revendedor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_notas_fiscais_1_idx` (`id_revendedor` ASC) VISIBLE,
  CONSTRAINT `fk_notas_fiscais_1`
    FOREIGN KEY (`id_revendedor`)
    REFERENCES `picoles`.`revendedores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `picoles`.`lotes_nota_fiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `picoles`.`lotes_nota_fiscal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_lote` INT NOT NULL,
  `id_nota_fiscal` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lotes_nota_fiscal_1_idx` (`id_lote` ASC) VISIBLE,
  INDEX `fk_lotes_nota_fiscal_2_idx` (`id_nota_fiscal` ASC) VISIBLE,
  CONSTRAINT `fk_lotes_nota_fiscal_1`
    FOREIGN KEY (`id_lote`)
    REFERENCES `picoles`.`lotes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lotes_nota_fiscal_2`
    FOREIGN KEY (`id_nota_fiscal`)
    REFERENCES `picoles`.`notas_fiscais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
