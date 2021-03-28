-- MySQL Script generated by MySQL Workbench
-- Fri 26 Mar 2021 08:35:08 PM EAT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rent_ms
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rent_ms
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rent_ms` ;
USE `rent_ms` ;

-- -----------------------------------------------------
-- Table `rent_ms`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_ms`.`Room` (
  `RoomId` INT NOT NULL AUTO_INCREMENT,
  `RoomName` VARCHAR(20) NOT NULL,
  `Rent` DECIMAL(12,2) NOT NULL,
  `Deposit` DECIMAL(12,2) NULL,
  `Status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`RoomId`, `RoomName`),
  UNIQUE INDEX `RoomName_UNIQUE` (`RoomName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_ms`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_ms`.`Payment` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `RoomName` VARCHAR(20) NOT NULL,
  `Amount` DECIMAL(12,2) NOT NULL,
  `TransactionCode` VARCHAR(20) NOT NULL,
  `TransactionPhone` VARCHAR(20) NOT NULL,
  `TransactionDate` DATE NOT NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `index` (`TransactionCode` ASC, `TransactionPhone` ASC, `RoomName` ASC) VISIBLE,
  INDEX `Room_idx` (`RoomName` ASC) VISIBLE,
  CONSTRAINT `Room`
    FOREIGN KEY (`RoomName`)
    REFERENCES `rent_ms`.`Room` (`RoomName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_ms`.`Tenant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_ms`.`Tenant` (
  `TenantId` INT NOT NULL AUTO_INCREMENT,
  `TenatName` VARCHAR(45) NOT NULL,
  `TenantPhone` VARCHAR(20) NOT NULL,
  `Occupation` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`TenantId`, `TenantPhone`),
  UNIQUE INDEX `TenentPhone_UNIQUE` (`TenantPhone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_ms`.`Rent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_ms`.`Rent` (
  `RentId` INT NOT NULL AUTO_INCREMENT,
  `Room` INT NOT NULL,
  `Tenant` INT NOT NULL,
  PRIMARY KEY (`RentId`, `Room`, `Tenant`),
  UNIQUE INDEX `Room_UNIQUE` (`Room` ASC) VISIBLE,
  UNIQUE INDEX `Tenant_UNIQUE` (`Tenant` ASC) VISIBLE,
  CONSTRAINT `Room`
    FOREIGN KEY (`Room`)
    REFERENCES `rent_ms`.`Room` (`RoomId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Tenant`
    FOREIGN KEY (`Tenant`)
    REFERENCES `rent_ms`.`Tenant` (`TenantId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
