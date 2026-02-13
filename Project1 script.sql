-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Project1_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Project1_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project1_db` DEFAULT CHARACTER SET utf8 ;
USE `Project1_db` ;

-- -----------------------------------------------------
-- Table `Project1_db`.`Dealers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project1_db`.`Dealers` (
  `dealerID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`dealerID`))
ENGINE = InnoDB;

INSERT INTO Dealers (name,email,phone) 
VALUES  ("Abu","Abu@gmail.com","718-111-0001"),
        ("Ancient Library","ancient.library@gmail.com","718-111-0002"),
        ("Classic Reads","classic.reads@gmail.com","718-111-0003"),
        ("Old Pages store","oldpages.store@gmail.com","718-111-0004"),
        ("Rare Finds","rare.finds@gmail.com","718-111-0005");
SELECT * FROM Dealers;


-- -----------------------------------------------------
-- Table `Project1_db`.`Books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project1_db`.`Books` (
  `bookID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `publicationYear` YEAR NOT NULL,
  `genre` VARCHAR(40) NOT NULL,
  `condition_n` VARCHAR(40) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  `dealerID` INT NOT NULL,
  PRIMARY KEY (`bookID`),
  INDEX `books_dealers_fk_idx` (`dealerID` ASC) VISIBLE,
  CONSTRAINT `books_dealers_fk`
    FOREIGN KEY (`dealerID`)
    REFERENCES `Project1_db`.`Dealers` (`dealerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Books (title,author,publicationYear,genre,condition_n,price,dealerID) 
VALUES  ("Database Basics","John Purple",1981,"Education","Good",59.99,1),
		("Network Security","Alice Security",1999,"Technology","New",75.50,2),
		("Linux Essentials","Mark Brown",1995,"Technology","New",65.00,3),
        ("Cyber Defense","Sarah two",2004,"Technology","Fair",48.99,4),
        ("Old History","James Histoire",1970,"History","Used",2999.25,5);
SELECT * FROM Books;

SELECT * FROM Books
INNER JOIN Dealers
ON Books.dealerID = Dealers.dealerID;

-- -----------------------------------------------------
-- Table `Project1_db`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project1_db`.`Customers` (
  `customerID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(40) NOT NULL,
  `lastName` VARCHAR(40) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;

INSERT INTO Customers (firstName,lastName,email,phone) 
VALUES  ("Mike","Reads","mike.reads@gmail.com",'347-222-0001'),
		("Sara","Ali","sara.ali@gmail.com","347-222-0002"),
		("David","Lion","david.lion@gmail.com","347-222-0003"),
		("Fatima","Khan","fatima.khan@gmail.com","347-222-0004"),
        ("Chris","Young","chris.young@gmail.com","347-222-0005");
SELECT * FROM Customers;


-- -----------------------------------------------------
-- Table `Project1_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project1_db`.`Orders` (
  `orderID` INT NOT NULL AUTO_INCREMENT,
  `orderDate` DATE NOT NULL,
  `totalAmount` DECIMAL(10,2) NOT NULL,
  `customerID` INT NOT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `orders_customers_fk_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `orders_customers_fk`
    FOREIGN KEY (`customerID`)
    REFERENCES `Project1_db`.`Customers` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Orders (orderDate,totalAmount,customerID) 
VALUES  ("2025-02-01",59.99,1),
        ("2024-03-02",75.50,2),
		("2023-04-03",65.00,3),
        ("2022-05-04",48.99,4),
        ("2020-06-05",2999.25,5);
SELECT * FROM Orders;

SELECT * FROM Orders
INNER JOIN Customers
ON Orders.customerID = Customers.customerID;

-- -----------------------------------------------------
-- Table `Project1_db`.`Order_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project1_db`.`Order_Items` (
  `orderItemID` INT NOT NULL AUTO_INCREMENT,
  `orderID` INT NOT NULL,
  `bookID` INT NOT NULL,
  `quantity` INT NOT NULL,
  `itemPrice` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`orderItemID`),
  INDEX `orderitems_orders_fk_idx` (`orderID` ASC) VISIBLE,
  INDEX `orderitems_books_fk_idx` (`bookID` ASC) VISIBLE,
  CONSTRAINT `orderitems_orders_fk`
    FOREIGN KEY (`orderID`)
    REFERENCES `Project1_db`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderitems_books_fk`
    FOREIGN KEY (`bookID`)
    REFERENCES `Project1_db`.`Books` (`bookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Order_Items (orderID,bookID,quantity,itemPrice) 
VALUES (1,21,1,59.99),
	   (2,22,1,75.50),
       (3,23,1,65.00),
       (4,24,1,48.99),
       (5,25,1,2999.25);

SELECT * FROM Order_Items;

SELECT * FROM Order_Items
INNER JOIN Orders
ON Order_Items.orderID = Orders.orderID;

SELECT * FROM Order_Items
INNER JOIN Books
ON Order_Items.bookID = Books.bookID;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
