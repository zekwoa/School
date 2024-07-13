-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `school` DEFAULT CHARACTER SET utf8 ;
USE `school` ;

-- -----------------------------------------------------
-- Table `school`.`SA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`SA` ;

CREATE TABLE IF NOT EXISTS `school`.`SA` (
  `SA_name` VARCHAR(20) NOT NULL,
  `SA_start` DATE NULL,
  `SA_end` DATE NULL,
  PRIMARY KEY (`SA_name`),
  UNIQUE INDEX `SA_name_UNIQUE` (`SA_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`student` ;

CREATE TABLE IF NOT EXISTS `school`.`student` (
  `s_ssn` INT NOT NULL,
  `s_name` VARCHAR(40) NULL,
  `s_address` VARCHAR(95) NULL,
  `s_Bdate` DATE NULL,
  `s_sex` CHAR NULL,
  `SA_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`s_ssn`),
  INDEX `fk_student_summer_activity1_idx` (`SA_name` ASC),
  UNIQUE INDEX `s_ssn_UNIQUE` (`s_ssn` ASC),
  CONSTRAINT `fk_student_summer_activity1`
    FOREIGN KEY (`SA_name`)
    REFERENCES `school`.`SA` (`SA_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`employee` ;

CREATE TABLE IF NOT EXISTS `school`.`employee` (
  `e_ssn` INT NOT NULL,
  `e_name` VARCHAR(45) NOT NULL,
  `e_address` VARCHAR(75) NULL,
  `e_salary` DECIMAL(10,2) NOT NULL,
  `e_sex` CHAR NULL,
  `e_Bdate` DATE NULL,
  PRIMARY KEY (`e_ssn`),
  UNIQUE INDEX `e_ssn_UNIQUE` (`e_ssn` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`dependent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`dependent` ;

CREATE TABLE IF NOT EXISTS `school`.`dependent` (
  `d_name` VARCHAR(20) NULL,
  `d_sex` CHAR NULL,
  `d_relatioship` VARCHAR(45) NULL,
  `d_Bdate` DATE NULL,
  `employee_ssn` INT NOT NULL,
  PRIMARY KEY (`employee_ssn`),
  INDEX `fk_dependent_employee1_idx` (`employee_ssn` ASC),
  UNIQUE INDEX `employee_ssn_UNIQUE` (`employee_ssn` ASC),
  CONSTRAINT `fk_dependent_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `school`.`employee` (`e_ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`subject` ;

CREATE TABLE IF NOT EXISTS `school`.`subject` (
  `sub_name` VARCHAR(20) NOT NULL,
  `score` INT NULL,
  PRIMARY KEY (`sub_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`teacher` ;

CREATE TABLE IF NOT EXISTS `school`.`teacher` (
  `employee_ssn` INT NOT NULL,
  `years_of_experience` INT NOT NULL,
  `subject_name` VARCHAR(20) NOT NULL,
  INDEX `fk_teacher_employee1_idx` (`employee_ssn` ASC),
  PRIMARY KEY (`employee_ssn`),
  INDEX `fk_teacher_subject1_idx` (`subject_name` ASC),
  UNIQUE INDEX `employee_ssn_UNIQUE` (`employee_ssn` ASC),
  CONSTRAINT `fk_teacher_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `school`.`employee` (`e_ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_teacher_subject1`
    FOREIGN KEY (`subject_name`)
    REFERENCES `school`.`subject` (`sub_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`time_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`time_table` ;

CREATE TABLE IF NOT EXISTS `school`.`time_table` (
  `class` VARCHAR(10) NOT NULL,
  `location` VARCHAR(10) NULL,
  PRIMARY KEY (`class`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`study`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`study` ;

CREATE TABLE IF NOT EXISTS `school`.`study` (
  `student_ssn` INT NOT NULL,
  `subject_name` VARCHAR(20) NOT NULL,
  `oral` INT NULL,
  `midterm` INT NULL,
  `final` INT NULL,
  `total` INT NULL,
  PRIMARY KEY (`student_ssn`, `subject_name`),
  INDEX `fk_student_has_subject_subject1_idx` (`subject_name` ASC),
  INDEX `fk_student_has_subject_student1_idx` (`student_ssn` ASC),
  CONSTRAINT `fk_student_has_subject_student1`
    FOREIGN KEY (`student_ssn`)
    REFERENCES `school`.`student` (`s_ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_has_subject_subject1`
    FOREIGN KEY (`subject_name`)
    REFERENCES `school`.`subject` (`sub_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`secretary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`secretary` ;

CREATE TABLE IF NOT EXISTS `school`.`secretary` (
  `employee_ssn` INT NOT NULL,
  `speed typing` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`employee_ssn`),
  INDEX `fk_secretary_employee1_idx` (`employee_ssn` ASC),
  UNIQUE INDEX `employee_ssn_UNIQUE` (`employee_ssn` ASC),
  CONSTRAINT `fk_secretary_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `school`.`employee` (`e_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`worker` ;

CREATE TABLE IF NOT EXISTS `school`.`worker` (
  `employee_ssn` INT NOT NULL,
  `work_hours` INT NOT NULL,
  PRIMARY KEY (`employee_ssn`),
  INDEX `fk_worker_employee1_idx` (`employee_ssn` ASC),
  UNIQUE INDEX `employee_ssn_UNIQUE` (`employee_ssn` ASC),
  CONSTRAINT `fk_worker_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `school`.`employee` (`e_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`has`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school`.`has` ;

CREATE TABLE IF NOT EXISTS `school`.`has` (
  `class` VARCHAR(10) NOT NULL,
  `sub_name` VARCHAR(20) NOT NULL,
  `day` VARCHAR(15) NOT NULL,
  `from` TIME NOT NULL,
  `to` TIME NOT NULL,
  PRIMARY KEY (`class`, `sub_name`, `day`, `from`, `to`),
  INDEX `fk_time_table_has_subject_subject1_idx` (`sub_name` ASC),
  INDEX `fk_time_table_has_subject_time_table1_idx` (`class` ASC),
  CONSTRAINT `fk_time_table_has_subject_time_table1`
    FOREIGN KEY (`class`)
    REFERENCES `school`.`time_table` (`class`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_time_table_has_subject_subject1`
    FOREIGN KEY (`sub_name`)
    REFERENCES `school`.`subject` (`sub_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `school`.`SA`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Footbal', '2021-02-01', '2021-02-03');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Basketball', '2021-02-04', '2021-02-08');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Pool', '2021-02-09', '2021-02-13');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Volleyball', '2021-02-14', '2021-02-17');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Running', '2021-02-18', '2021-02-22');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Handball', '2021-02-23', '2021-02-26');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Tennis', '2021-02-27', '2021-02-29');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Netball', '2021-02-28', '2021-02-21');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Cycling', '2021-03-01', '2021-03-05');
INSERT INTO `school`.`SA` (`SA_name`, `SA_start`, `SA_end`) VALUES ('Ping Pong', '2021-03-06', '2021-03-10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`student`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566771, 'Ibrahim Mohamed Aly Ibrahim', '1 Talaat Harb Sq., DOWNTOWN,Cairo', '2006-01-01', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566772, 'Ahmed Ahmed Mahmoud Hassan', 'Gamal Abdel Naser St, Off Omar Ibn El Khattab St. El Herafeyeen,Cairo', '2006-01-01', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566773, 'Ahmed Ashraf Hamed Mohamed', '24 Bapars St, AZHAR,Cairo', '2006-01-01', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566774, 'Ahmed Hassan Anwer Mousa', '21 Talaat Harb St, P.O. Box: 12321,Cairo', '2006-01-01', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566775, 'Ahmed Mohamed Hassan Youssef', '25A Hadayek El-Obour St., Nasr City,cairo', '2006-01-02', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566776, 'Ahmed Fat Sayed Ahmed', '147 El-Hegaz St., El-Hegaz Sq,Cairo', '2006-01-02', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566777, 'Ahmed Adel Ahmed Mohamed', '366 El Malek Faisal St., Talbia,Cairo', '2006-01-02', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566778, 'Ahmed Hany Ahmed Ibrahim', '6 Shams El-Din El-Zahaby St., Ard El-Gulf,Cairo', '2006-01-02', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566779, 'Ahmed Ashraf Sayed Mohamed', '14 Maksar El-Khashab St., Mousky,Cairo', '2006-01-03', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566710, 'Ahmed Mohamed Ezat Mustafa', '61 Gameat El Dowal El Arabeya St, MOHANDESEEN,Cairo', '2006-01-03', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566711, 'Ahmed Kamal Mohsen Ibrahim', '1195 Corniche El-Nile, Boulak Abu El-Ela,Cairo', '2006-01-03', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566712, 'Ahmed Maher Saeed Mohamed', '39 Abbas El-Akkad St., off Battrawy Corner,Cairo', '2006-01-03', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566713, 'Ahmed Mohamed Sayed Mohamed', '139 Mogama El Masane St., EL AMIREYA,Cairo', '2006-01-04', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566714, 'Eslam Mohamed Ahmed Ibrahim', ' 8 Tonis St., NEW MAADI,Cairo', '2006-01-04', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566715, 'Eslam Hassan Adly Mohamed', '10 Almamoura Buildings, Zahraa Al Maady,Cairo', '2006-01-04', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566716, 'Eslam Mustafa Mohamed Aly', '27 Dr.Mohamed Kamel Hussein, El-Nozha,Cairo', '2006-01-04', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566717, 'Eslam Mohamed Aly Amin', '28 Adly St., DOWNTOWN,Cairo', '2006-01-05', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566718, 'Eslam Yasser Kassem Mohamed', '13 Ibrahim Naguib St., GARDEN CITY,Cairo', '2006-01-05', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566719, 'Eslam Hatem Mahmoud Ibrahim', '3 Hassan Sadek St., off Mirghany,Cairo', '2006-01-05', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566720, 'Amin El-Sayed Helmy Bakr', '129 Merghani St., Heliopolis,Cairo', '2006-01-05', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566721, 'Amin Khaled Amin Mehdi', '6 Gomhoureya Sq., ABDIN,Cairo', '2006-04-04', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566722, 'Ayman Younes Ahmed Aly', '29 Emad El-Din St., Down Town,Cairo', '2006-04-04', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566723, 'Jasser Ahmed Sayed Mohamed', 'Kanounine Tower Corniche El-Nile; 10th Floor; Off.122, Maadi,Cairo', '2006-04-04', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566724, 'Hazam Ahmed Nabil Sayed', '3 Hafez Ramadan St., Off Makram Ebeid,Cairo', '2006-04-04', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566725, 'Hossam Hassan Kassem Aly', '33 El-Makrezy St., Mansheat El-Bakry,Cairo', '2006-04-04', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566726, 'Hassan Ahmed Hassan Mahmoud', ' 21 Farid Semeka St., El-Hegaz Sq,Cairo', '2006-04-15', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566727, 'Hassan Osama Aly Mohamed', '36 El Salam St. - El Saada City - Shoubra El Khima - Cairo', '2006-04-15', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566728, 'Hussein Nasser Mohamed Qutb', '10 Mokattam High Way Rd., QALAA,Cairo', '2006-04-15', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566729, 'Hussein Ahmed Aly Hassan', '3 Rofael Soliman Off El Mdares St., HADAYEK EL KOBBA,Cairo', '2006-04-15', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566730, 'Hussein Rizk  Fathy Hussein', '31 Losaca St., Off Ahmed Fakhry St,Nasr City,Cairo', '2006-08-22', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566731, 'Helmy Sayed Mohamed Ragheb', ' 9 El-Nashat St., off Abbas El-Akkad St,Nasr City,Cairo', '2006-08-22', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566732, 'Helmy Raghem Mohamed Ward', '18 Abu El-Aatahya St., Ext. of Abbas El-Akkad St,Nasr City,Cairo', '2006-03-02', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566733, 'Hamdy Ahmed Hafith Aly', ' Ind. Zone A1, 10th of RAMADAN,Cairo', '2006-03-02', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566734, 'Khaled Ahmed Mahmoud Ahmed', ' Soliman Alhalaby Street, Ramsis, Downtown,Cairo', '2006-03-02', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566735, 'Khaled  Mohamed  Hanafy  Aly', '1 B Hassan Sabri St., Zamalek,Cairo', '2006-03-02', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566736, 'Reda Hassan Mohamed Mahmoud', ' 2 A Hassan Sabri St., Zamalek,Cairo', '2006-03-02', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566737, 'Ramy Malek Gamal Aly', '33 El-Hegaz St.; Merryland, Heliopolis,Cairo', '2007-04-13', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566738, 'Zeyad Ismail Gamal Mohamed', '20 Ellwaa Mahmoud Sami St., P.O. Box: 11371,Cairo', '2007-04-13', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566739, 'Zeyad Sayed Mahmoud Ahmed', '30 El-Obour Gardens, Salah Salem,Cairo', '2007-04-13', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566740, 'Zayn Mahmoud Aly Yassin', '7 Makram Ebeid, Cairo', '2007-04-13', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566741, 'Sameh Madani Mustafa Mohamed', '10thOf Ramadan A1, Cairo', '2007-08-13', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566742, 'Selim Mohamed Aly Hassan', ' 21 Bldg Nozha St Heliopolis, P.O. Box: 11371,,Cairo', '2007-08-13', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566743, 'Suleiman Aly Mohamed Aly', '105 Omar Ebn El-Khatab St., Almaza,Cairo', '2007-08-13', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566744, 'Sayed Ashraf Sayed Mahmoud', '47 Abass El-Akkad St., NASR CITY,Cairo', '2007-08-13', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566745, 'Sayed Mohamed Sayed Aly', '1 Talaat Harb Sq., DOWNTOWN,Cairo', '2007-08-13', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566746, 'Seif Abdel-Rahman Aly Yassin', '10 Abu El-Magd St., off Shams El-Din El-Zaheby,Cairo', '2007-08-13', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566747, 'Shady Ahmed Mustafa Mohamed', '9 Abu el Mahasen St., Roxy,Cairo', '2007-11-13', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566748, 'Salah Hussien Sahah Ahmed', '10thOf RamadanC2, Cairo', '2007-11-13', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566749, 'Taha Khaled Ahmed Mohamed', ' 20 El Emdad and El Tamween Bldgs., NASR CITY,Cairo', '2007-11-13', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566750, 'Adel Mohamed Adel Eid', '32 Ahmed Fakhry St., NASR CITY,Cairo', '2007-11-13', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566751, 'Atef Eid Atef Mohamed', '34 El Esraa St. Lebanon Sq., MOHANDESEEN,Cairo', '2007-11-13', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566752, 'Abdelrahman Mahmoud Ibrahim Mohamed', ' New Cairo, Industrial Zone,Cairo', '2007-11-13', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566652, 'Abdelrahman Ramdan Gamal Aly', '26 Galal El-Din El-Dessoki St., Almaza,Cairo', '2007-11-13', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566753, 'Abdelrahman Salah Mohamed Aly ', ' Arkidia Moll, BOULAK,Cairo', '2008-12-10', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566754, 'Abdallah Mohamed Ahmed Ismail', '2 El Sobky Street, Dahabi Square,Cairo', '2008-12-10', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566755, 'Aly Hassan Ahmed Hassan', 'Nasr City Elhay Eltamen, P.O. Box: 11817,Cairo', '2008-12-10', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566756, 'Aly Ahmed Atef Mohamed', '18 El Esraa St., MOHANDESEEN,Cairo', '2008-12-11', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566757, 'Aly Ahmed Ibrahim Mohamed', '9 Mohamed Fahmy St., GARDEN CITY,Cairo', '2008-12-11', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566758, 'Omar Ashraf Hussein Aly', ' El Obour, P.O. Box: 10130,Cairo', '2008-12-11', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566759, 'Omar Khaled Badr Ahmed', '22 Ahmed Amin St., Saint Fatima,Cairo', '2008-12-13', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566760, 'Omar Eid Aly Abdelrahman', '6 ) EL Shahed Muhammed Abd EL Hady St. Ard EL Golf, Nasr City,Cairo', '2008-12-11', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566761, 'Omar Hany Aly Mohamed', 'Madinat El-Solb El-Kadima, Tebin,Cairo', '2008-12-13', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566762, 'Omar Mohamed Mahmoud Aly', '35 Hassanaflaton Ard El Golf-Helioplis, P.O. Box: 11717,Cairo', '2008-12-13', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566763, 'Omar Yasser Ahmed Mohamed', '11 Salah El-Din Fadel St., Heliopolis,Cairo', '2008-12-13', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566764, 'Amr Hamada Mohamed Yassin', '393 Port Said St., AZHAR,Cairo', '2008-12-13', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566765, 'Amr Ezat Sayed Hassan', '2A El-Khalifa El-Maamoun St.; Manshiet Bakry, HELIOPOLIS,Cairo', '2008-12-15', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566766, 'Amr Magdy Abdelrahman Aly', 'Baron Center Bldg. 40 Nazih Khalifa St., HELIOPOLIS,Cairo', '2008-12-15', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566767, 'Fares Mohamed Ahmed Aly', '61 El Thawra St., Ard El Golf Heliopolis,Cairo', '2008-12-16', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566768, 'Fahd Ahmed Aly Mahmoud', '29 Ahmed Kassem Gouda St., off Abbas El-Akkad St.,Cairo', '2008-12-16', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566769, 'Karim Ahmed Mohamed Rizk', '29 Ahmed Kassem Gouda St., off Abbas El-Akkad St.,Cairo', '2008-12-16', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566770, 'Karim Ahmed Sayed Ahmed', ' 52, Helopolies,Cairo', '2008-10-22', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566780, 'Mohamed Ibrahim Ismail Mohamed', '49 Street No.15, Sarayat El-Maadi,Cairo', '2008-10-22', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566781, 'Mohamed Ahmed Mahmoud Ismail', '45 Osman Ibn Affan St., HELIOPOLIS,Cairo', '2008-12-16', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566782, 'Mohamed Ashraf Ahmed Aly ', '105 Omar Ibn El-Khattab St., Almaza,Cairo', '2008-10-22', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566783, 'Mohamed Badr Kassem Ahmed', '1 El-Galaa St., Down Town,Cairo', '2008-12-22', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566784, 'Mohamed Bayoumi Aly Amin', '43 Ibrahim Nawar St., NASR CITY,Cairo', '2008-12-22', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566785, 'Mohamed Tamer Ahmed Mohamed', '57 Mostafa El-Nahas St., NASR CITY,Cairo', '2008-12-22', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566786, 'Mohamed Thrwat Mahmoud Aly', 'Alameria, Alzaiton, Cairo', '2008-12-08', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566787, 'Mohamed Gamal Sayed Ahmed ', '130, 26th July St, Zamalek,Cairo', '2008-12-08', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566788, 'Mohamed Hossam Saleh Hussein', '37 Gaza St., MOHANDESEEN,Cairo', '2008-12-07', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566789, 'Mohamed Reda Mohamed AHmed', '18 Mohamed Taymour St., HELIOPOLIS,Cairo', '2008-12-08', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566790, 'Mohamed Ramdan Aly Hassan', '112 26th July St., Zamalek,Cairo', '2008-12-07', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566791, 'Mohamed Raghab Raghab Hussein', '102 Shubra St., SHOUBRA,Cairo', '2008-12-07', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566792, 'Mohamed Samir Ahmed Aly', ' Ind. Zone A1, 10th of RAMADAN,Cairo', '2008-12-07', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566793, 'Mohamed Sayed Ahmed Mustafa', '16 Milssa Building Nasr City, P.O. Box: 115757,Cairo', '2007-11-25', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566794, 'Mohamed Sayed Kassem Youssef', '26 Mohamed El Mahdy St., Ard El Golf,Cairo', '2007-11-25', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566795, 'Mohamed Mohamed Mahmoud Ahmed', '110 El-Merghani St., Heliopolis,Cairo', '2007-11-25', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566796, 'Mohamed Mahmoud Mohamed Sayed', '1 Sidi Said St., Darb El Samakah,Cairo', '2007-11-25', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566797, 'Mohamed Mahmoud Mohamed Hassan', 'Rabaa El-Adawya Project Bldg. 6 Nasr Rd., Nasr City,Cairo', '2007-11-25', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566798, 'Mohamed Masad Sobhy Aly', 'Rabaa El-Adawya Project Bldg. 6 Nasr Rd., Nasr City,Cairo', '2007-11-27', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566799, 'Mohamed Maruf Abdelrahman Ahmed', '151 El-Hegaz St., Heliopolis,Cairo', '2007-11-27', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566100, 'Mohamed Mamdouh Ahmed Eid', '44 Gamal El Din El Shayal St., NASR CITY,Cairo', '2007-11-27', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566101, 'Mohamed Mamdouh Ezat Aly', 'El-zeny tower 25 Misr/Helwan Agri. Rd., MAADI,Cairo', '2007-11-27', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566103, 'Mohamed Hany Gamal Mahmoud', '17 Mahmoud Hassan St., 4th Area,Cairo', '2007-11-27', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566104, 'Mohamed Wael Reda Sayed ', 'Shoubra St., El Mazalat,Cairo', '2007-11-27', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566105, 'Mohamed Wael Mahmoud Ahmed ', 'Court of Cassation Bldg. 26th July St., DOWNTOWN,Cairo', '2007-11-26', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566106, 'Mohamed Waled Sayed Aly', '2 Sabri Abu Alam St., 2nd Floor,Cairo', '2007-11-26', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566107, 'Mohamed Waled Ezat Hassan', '49 Noubar St., Bab El-Louk,Cairo', '2007-11-26', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566108, 'Mohamed Youssef Aly Ahmed', '40 Noubar St., Bab El-Louk,Cairo', '2007-11-26', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566109, 'Mahmoud Ahmed Salem Aly', '18 Ahmed Hosni St., behind Rabaa El-Adawia Mosque,Cairo', '2007-11-26', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566110, 'Mahmoud Hatem Mahmoud Hussein', ' 1st Ind. Zone, OBOUR CITY,Cairo', '2007-11-26', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566111, 'Mahmoud Hassan Ismail Aly', '1333 Cornich El-Nil St., Shubra,Cairo', '2008-10-06', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566112, 'Mahmoud Hussein Ragab Ahmed', 'St. No.75, Villa No.20,Cairo', '2008-10-06', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566113, 'Mahmoud Hamdy Mohamed Aly', '12 Nozha St., Heliopolis,Cairo', '2008-10-06', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566114, 'Mahmoud Sayed Saed Mahmoud', ' 20 Shams El-Din El-Zahaby St., Koleit El-Banat Station,Cairo', '2008-10-06', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566115, 'Mahmoud Emad Mahmoud Mohamed', '53 Beirut St., Heliopolis,Cairo', '2008-10-06', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566116, 'Mohmoud Mohamed Mahmoud Aly', '3 Hassan Sadek St., Orouba,Cairo', '2008-12-29', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566117, 'Mahmoud Mohamed Farouk Mustafa', '32 Ahmed Fakhry St., NASR CITY,Cairo', '2008-12-29', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566118, 'Mahmoud Mohamed Mahmoud Ibrahim', ' 20 El Emdad and El Tamween Bldgs., NASR CITY,Cairo', '2008-12-29', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566119, 'Mahmoud Mustafa Mahmoud Kassem', '10thOf RamadanC2, Cairo', '2008-12-29', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566120, 'Mahmoud Wael Ahmed Aly', '9 Abu el Mahasen St., Roxy,Cairo', '2008-12-29', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566121, 'Mustafa Ibrahim Ismail Aly', '1 Talaat Harb Sq., DOWNTOWN,Cairo', '2008-12-29', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566122, 'Mustafa Ahmed Noah Saed', '36 El Salam St. - El Saada City - Shoubra El Khima - Cairo', '2008-12-26', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566123, 'Mustafa Ashraf Sayed Ibrahim', '10 Mokattam High Way Rd., QALAA,Cairo', '2008-12-26', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566124, 'Mustafa Ashraf Fakhr Emam', '3 Rofael Soliman Off El Mdares St., HADAYEK EL KOBBA,Cairo', '2008-12-26', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566125, 'Mustafa Hamda Mustafa Mohamed', '31 Losaca St., Off Ahmed Fakhry St,Nasr City,Cairo', '2008-12-26', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566126, 'Mustafa Reda Helmy Mohamed', ' 9 El-Nashat St., off Abbas El-Akkad St,Nasr City,Cairo', '2008-12-22', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566127, 'Mustafa Emad Fathy Emam', '18 Abu El-Aatahya St., Ext. of Abbas El-Akkad St,Nasr City,Cairo', '2008-12-22', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566128, 'Mustafa Mohamed Youssef Aly', ' Ind. Zone A1, 10th of RAMADAN,Cairo', '2008-12-15', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566129, 'Mustafa Mahmoud Reda Ahmed', '1 B Hassan Sabri St., Zamalek,Cairo', '2008-12-15', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566130, 'Mustafa Mahmoud Sayed Ahmed', ' 2 A Hassan Sabri St., Zamalek,Cairo', '2008-12-15', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566131, 'Mustafa Ward Kamel Aly', '33 El-Hegaz St.; Merryland, Heliopolis,Cairo', '2008-12-15', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566132, 'Moamen Ibrahim Ahmed Ismail', '20 Ellwaa Mahmoud Sami St., P.O. Box: 11371,Cairo', '2008-12-15', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566133, 'Nour Ahmed Mohamed Mahmoud', '30 El-Obour Gardens, Salah Salem,Cairo', '2008-12-14', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566134, 'Noah Mustafa Sayed Aly', '7 Makram Ebeid, Cairo', '2008-12-14', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566135, 'Naji Sabri Mohamed Ahmed', ' 2 A Hassan Sabri St., Zamalek,Cairo', '2008-12-14', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566136, 'Hashim Yaser Ahmed Hashim', '10thOf Ramadan A1, Cairo', '2008-12-14', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566137, 'Hany Saed Aly Abdelrahman', ' 21 Bldg Nozha St Heliopolis, P.O. Box: 11371,,Cairo', '2008-12-13', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566138, 'Hisham Mohamed Ahmed Mahmoud', '105 Omar Ebn El-Khatab St., Almaza,Cairo', '2008-12-10', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566139, 'Yassin Ezat Aly Hassan', '47 Abass El-Akkad St., NASR CITY,Cairo', '2008-12-10', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566140, 'Yahia Fathy Mustafa Aly', '1 Talaat Harb Sq., DOWNTOWN,Cairo', '2008-12-10', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566141, 'Youssef Ibrahim Saed Aly', '10 Abu El-Magd St., off Shams El-Din El-Zaheby,Cairo', '2008-12-10', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566142, 'Youssef Ahmed Aly Mohamed', '9 Abu el Mahasen St., Roxy,Cairo', '2008-12-10', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566143, 'Youssef Ashraf Gaber Abdo', '10thOf RamadanC2, Cairo', '2006-04-03', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566144, 'Youssef Ehab Sayed Eid', ' 20 El Emdad and El Tamween Bldgs., NASR CITY,Cairo', '2006-04-03', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566145, 'Youssef Sayed Fayeq Radwan', '32 Ahmed Fakhry St., NASR CITY,Cairo', '2006-04-03', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566146, 'Youssef Taha Aly Abdelrahman', '34 El Esraa St. Lebanon Sq., MOHANDESEEN,Cairo', '2006-04-03', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566147, 'Youssef Ezat Ezat Sayed', ' New Cairo, Industrial Zone,Cairo', '2008-04-03', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566148, 'Youssef Essam Ibrahim Ahmed', '26 Galal El-Din El-Dessoki St., Almaza,Cairo', '2008-04-03', 'M', 'Tennis');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566149, 'Youssef Mohamed Mohamed Hussein', ' Arkidia Moll, BOULAK,Cairo', '2008-01-03', 'M', 'Netball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566150, 'Youssef Mohamed Ramdan Ibrahim', '2 El Sobky Street, Dahabi Square,Cairo', '2008-04-03', 'M', 'Football');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566151, 'Youssef Mohamed Ahmed Aly', 'Nasr City Elhay Eltamen, P.O. Box: 11817,Cairo', '2008-04-03', 'M', 'Basketball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566152, 'Youssef Mahmoud Sayed Yassin', '18 El Esraa St., MOHANDESEEN,Cairo', '2008-11-13', 'M', 'Cycling');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566153, 'Youssef Yasser Farid Hafez', '9 Mohamed Fahmy St., GARDEN CITY,Cairo', '2007-11-13', 'M', 'Pool');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566154, 'Yasser Mohamed Sayed Aly', '44 Gamal El Din El Shayal St., NASR CITY,Cairo', '2008-11-13', 'M', 'Ping Pong');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566155, 'Yasser Ahmed Khaled Mahmoud', 'El-zeny tower 25 Misr/Helwan Agri. Rd., MAADI,Cairo', '2006-08-22', 'M', 'Volleyball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566156, 'Younes Ibrahim Aly Ahmed', 'El-zeny tower 25 Misr/Helwan Agri. Rd., MAADI,Cairo', '2006-08-22', 'M', 'Running');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566157, 'Younse Khaled Mahmoud Yassin', ' 1st Ind. Zone, OBOUR CITY,Cairo', '2006-08-22', 'M', 'Handball');
INSERT INTO `school`.`student` (`s_ssn`, `s_name`, `s_address`, `s_Bdate`, `s_sex`, `SA_name`) VALUES (445566158, 'Younes Omar Aly Hassan', '1333 Cornich El-Nil St., Shubra,Cairo', '2006-08-22', 'M', 'Tennis');

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (166010201, 'Tamir Sabet', '14 El Mahrouki St., MOHANDESEEN', 8738, 'M', '1981-10-25');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (168603208, 'Dabbah Kamel', '32 Rabah Al-Estethmary St.;, Nasr City', 6667, 'M', '1988-03-12');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (163511184, 'Khashifa Jalil', '12 Amar Ibn Yasser St., Military Academy', 8385, 'M', '1986-09-25');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (162212160, 'Tasmeekh Hoque', '138 Ramses Ext. 2 Bldg. infront of Back Door showroom, NASR CITY', 4958, 'M', '1995-08-10');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (167003299, 'Hussein Maroun', '34 Obour Bldgs., NASR CITY', 4142, 'M', '1973-01-10');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (164704114, 'Rehan Wakim', '1B, Messaha St.', 9123, 'F', '1967-08-12');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (160709162, 'Azeem Ameen', '69 El-Nabi Daniel St., Ramleh Station', 1278, 'M', '1981-05-07');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (166309275, 'Nafay Younes', '5 Ibn Iyas El-Masri St., GIZA', 2098, 'F', '1986-03-22');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (161104033, 'Qabil Salek', '102 El Hegaz St., HELIOPOLIS', 8262, 'M', '1970-02-20');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (166311285, 'Andalah Nazar', '45 Noubar St., DOWNTOWN', 2956, 'F', '1994-06-15');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (167507066, 'Aman Diab', '4 Behler Passage, off Kasr El-Nile St.', 6542, 'F', '1980-01-03');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (164904222, 'asmaa ashraf ahmed', '16 Rd. 311', 9935, 'F', '1967-03-12');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (168311105, 'asmaa rashwan ali', '6 El-Hasbaa St., El-Merghani', 9760, 'F', '1968-09-20');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (165806050, 'omiana hassan ', '4 Bashir Neama St., HELIOPOLIS', 3063, 'F', '1970-07-14');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (161704052, 'engy ahmed ', '6 ) EL Shahed Muhammed Abd EL Hady St. Ard EL Golf, Nasr City', 4346, 'F', '1982-09-10');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (163209224, 'eman ali', '46 Gharb El Estad St., 6th District.Nasr City', 4850, 'F', '1972-06-02');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (167812200, 'eman mohamed', '1 Misr El Nour Bldg., Sheraton Heliopolis', 8109, 'F', '1985-08-25');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (169011280, 'rehab adel', '21 El Alfy St., DOWNTOWN', 8117, 'F', '1972-05-15');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (165906116, 'rahma hamada', '7/2 El Zhraa Main St. - Nerco Bldgs., NEW MAADI', 6252, 'F', '1977-09-15');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (161207138, 'shimaa mohamed', '56, 58 El Sabteya St. El Sabteya', 6089, 'F', '1984-01-06');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (164507046, 'zeinb ahmed ', '3 Manzarah El-Loaloah St., Faggala', 7340, 'F', '1991-12-24');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (165401275, 'sara mohamed', '14, Mahaad El Sahaary Street; Cairo', 6089, 'F', '1970-03-30');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (164601154, 'karima mahmoud', '32 Ahmed Fakhry St., NASR CITY', 3626, 'F', '1975-10-23');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (166102185, 'shahd ashraf', '4 Aly El Lathy St, P.O. Box: 11341', 4528, 'F', '1976-01-15');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (163610127, 'ahmed ramdan', 'Maadi Grand Mall Bldg. St.No.250, MAADI', 8039, 'M', '1996-10-29');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (165412013, 'ahmed fathy', '2 Mahrouse Abd El Salam St., EL HARAM', 607, 'M', '1983-03-22');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (166009207, 'aslam hassan', '23 Shehab St., MOHANDESEEN', 6468, 'M', '1981-01-25');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (164903110, 'aslam ali', ' Sekkat El-Mankh St., off Abd El-Khalek Sarwat', 6246, 'M', '1995-04-21');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (162208031, 'aslam ai', '4 Wadi El-Nile St., Mohandessin', 4663, 'M', '1967-02-11');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (161409171, 'aslam mostafa elsayed ', '2 El-Boursa El-Gedida St., Kasr El-Nile', 7393, 'M', '1968-03-04');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (169708046, 'elsayed mohamed ', '14B Gomhoureya St., Abdin', 9304, 'M', '1979-11-16');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (168111143, 'ali fathy ', '3 Mossadak St., 1st floor', 9440, 'M', '1986-07-29');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (165811222, 'karem ali', 'Lesa Mosh Fee Adrees, P.O. Box: 202', 6131, 'M', '1985-10-12');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (165210161, 'karem alaa mohamed ', '5 Orabi Sq., El-Manshia', 5970, 'M', '1992-03-27');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (160506177, 'mohamed ayman', '14 Ali El-Gendy St., off Misr & Sudan St', 7824, 'M', '1995-06-07');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (166610114, 'mohamed hamed mo', '391, Ramsses, St', 1088, 'M', '1968-10-12');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (162901292, 'ali mohamed ', '16 El-Zedi St., Sayeda Zeinab', 9612, 'M', '1978-05-17');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (167807013, 'mohamed emad', '57 Moustafa El-Nahas St., 3rd Floor', 6947, 'M', '1988-05-09');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (160511277, 'mohamed abd elaziz', '49 Misr Helwan St, Cairo', 2687, 'M', '1993-06-08');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (164509266, 'mohamed emad ahmed', '34 Al Ahram St., Roxy', 889, 'M', '1987-12-09');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (166812160, 'mohamed walid', 'El Nasr St., MAADI', 5208, 'M', '1981-02-07');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (169409115, 'yasin ezat ', 'Oubayda Ibn El Garrah St., HELIOPOLIS', 5144, 'M', '1965-06-26');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (169108174, 'mahmoud mohamed', 'Akhbar Est. Bldg. 6 El-Sahafa St., 2nd Floor', 824, 'M', '1968-08-30');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (160109230, 'mohamed abd elsalam', '11 El Andalos St., HELIOPOLIS', 1749, 'M', '1983-12-28');
INSERT INTO `school`.`employee` (`e_ssn`, `e_name`, `e_address`, `e_salary`, `e_sex`, `e_Bdate`) VALUES (161409046, 'aza samir', '5 El Boustan El Saiedy St., DOWNTOWN', 4904, 'F', '1989-03-07');

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`dependent`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('fatma hassan', 'F', 'sister', '1988-06-16', 161409084);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('fatma fathy ', 'F', 'mother', '1981-06-19', 161409046);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('malak hany', 'F', 'mother', '1975-04-05', 169409115);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mayada magdy', 'F', 'sister', '1992-01-15', 160511277);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('norhan ali ', 'F', 'mother', '1991-04-22', 162901292);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('heba mahmoud', 'F', 'mother', '1991-02-04', 166610114);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('yasin amr\'', 'M', 'father', '1969-06-25', 160506177);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('nada zaki', 'F', 'sister', '1986-08-23', 165210161);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('kamal eldin\'', 'M', 'brother', '1992-10-16', 165811222);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mohamed badr\'', 'M', 'father', '1967-04-15', 168111143);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('moamed khaled ', 'M', 'father', '1975-12-21', 169708046);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('moahmed ragab\'', 'M', 'brother', '1995-09-01', 161409171);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mohamed samir', 'M', 'father', '1993-09-04', 164903110);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mohamed sayed', 'M', 'brother', '1966-01-24', 166009207);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mohamed mohy', 'M', 'father', '1975-06-26', 163610127);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mohamed walid', 'M', 'father', '1990-11-30', 166102185);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('moahmed mahmoud', 'M', 'father', '1976-02-04', 164601154);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mahmoud zaki', 'M', 'brother', '1989-03-25', 164507046);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('momen ali', 'M', 'brother', '1982-01-30', 165906116);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('fatma samir', 'F', 'mother', '1990-01-25', 169011280);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('fatma sabry', 'F', 'sister', '1994-07-12', 167812200);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('malak hany', 'F', 'mother', '1969-04-09', 163209224);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mena hassan', 'F', 'mother', '1982-11-12', 161704052);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mena mahmoud', 'F', 'sister', '1991-06-11', 168311105);
INSERT INTO `school`.`dependent` (`d_name`, `d_sex`, `d_relatioship`, `d_Bdate`, `employee_ssn`) VALUES ('mena emad', 'F', 'sister', '1968-10-12', 164904222);

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`subject`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`subject` (`sub_name`, `score`) VALUES ('arabic', 80);
INSERT INTO `school`.`subject` (`sub_name`, `score`) VALUES ('english', 60);
INSERT INTO `school`.`subject` (`sub_name`, `score`) VALUES ('math', 60);
INSERT INTO `school`.`subject` (`sub_name`, `score`) VALUES ('science', 40);
INSERT INTO `school`.`subject` (`sub_name`, `score`) VALUES ('social studies', 40);

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`teacher`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (166010201, 12, 'science');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (168603208, 10, 'social_studies');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (163511184, 9, 'social_studies');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (164704114, 7, 'science');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (161104033, 22, 'arabic');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (167507066, 17, 'math');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (164904222, 14, 'science');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (168311105, 16, 'social_studies');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (167812200, 8, 'english');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (169011280, 20, 'english');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (165906116, 2, 'math');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (161207138, 11, 'english');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (164507046, 9, 'arabic');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (165401275, 16, 'science');
INSERT INTO `school`.`teacher` (`employee_ssn`, `years_of_experience`, `subject_name`) VALUES (163610127, 5, 'arabic');

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`time_table`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('1/1', 'floor1');
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('1/2', 'floor2');
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('1/3', 'floor3');
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('2/1', 'floor1');
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('2/2', 'floor2');
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('2/3', 'floor3');
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('3/1', 'floor1');
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('3/2', 'floor2');
INSERT INTO `school`.`time_table` (`class`, `location`) VALUES ('3/3', 'floor3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`study`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566771, 'arabic', 9, 10, 60, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566771, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566771, 'math', 9, 9, 40, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566771, 'science', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566771, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566772, 'arabic', 10, 8, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566772, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566772, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566772, 'science', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566772, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566773, 'arabic', 9, 10, 59, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566773, 'english', 10, 8, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566773, 'math', 8, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566773, 'science', 5, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566773, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566774, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566774, 'english', 9, 10, 39, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566774, 'math', 10, 8, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566774, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566774, 'social studies', 3, 4, 29, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566775, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566775, 'english', 10, 9, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566775, 'math', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566775, 'science', 5, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566775, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566776, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566776, 'english', 8, 8, 38, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566776, 'math', 9, 10, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566776, 'science', 5, 4, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566776, 'social studies', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566777, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566777, 'english', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566777, 'math', 10, 8, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566777, 'science', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566777, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566778, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566778, 'english', 7, 10, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566778, 'math', 8, 8, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566778, 'science', 5, 4, 29, 35);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566778, 'social studies', 3, 5, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566779, 'arabic', 10, 9, 57, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566779, 'english', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566779, 'math', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566779, 'science', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566779, 'social studies', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566710, 'arabic', 8, 9, 57, 74);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566710, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566710, 'math', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566710, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566710, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566711, 'arabic', 10, 10, 59, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566711, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566711, 'math', 8, 9, 40, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566711, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566711, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566712, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566712, 'english', 7, 9, 38, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566712, 'math', 10, 8, 37, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566712, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566712, 'social studies', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566713, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566713, 'english', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566713, 'math', 7, 9, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566713, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566713, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566714, 'arabic', 8, 10, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566714, 'english', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566714, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566714, 'science', 5, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566714, 'social studies', 4, 5, 27, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566715, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566715, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566715, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566715, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566715, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566716, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566716, 'english', 8, 10, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566716, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566716, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566716, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566717, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566717, 'english', 7, 10, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566717, 'math', 9, 8, 40, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566717, 'science', 5, 4, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566717, 'social studies', 3, 5, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566718, 'arabic', 10, 10, 59, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566718, 'english', 8, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566718, 'math', 7, 8, 39, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566718, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566718, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566719, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566719, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566719, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566719, 'science', 3, 5, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566719, 'social studies', 4, 4, 29, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566720, 'arabic', 10, 8, 57, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566720, 'english', 8, 8, 38, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566720, 'math', 10, 8, 37, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566720, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566720, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566721, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566721, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566721, 'math', 10, 9, 38, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566721, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566721, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566722, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566722, 'english', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566722, 'math', 8, 10, 37, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566722, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566722, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566723, 'arabic', 10, 9, 58, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566723, 'english', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566723, 'math', 8, 10, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566723, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566723, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566724, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566724, 'english', 8, 8, 38, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566724, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566724, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566724, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566725, 'arabic', 8, 9, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566725, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566725, 'math', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566725, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566725, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566726, 'arabic', 10, 10, 59, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566726, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566726, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566726, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566726, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566727, 'arabic', 8, 9, 57, 74);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566727, 'english', 10, 8, 39, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566727, 'math', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566727, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566727, 'social studies', 4, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566728, 'arabic', 9, 8, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566728, 'english', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566728, 'math', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566728, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566728, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566729, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566729, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566729, 'math', 9, 10, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566729, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566729, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566730, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566730, 'english', 10, 8, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566730, 'math', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566730, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566730, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566731, 'arabic', 9, 8, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566731, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566731, 'math', 9, 8, 37, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566731, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566731, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566732, 'arabic', 8, 10, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566732, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566732, 'math', 10, 8, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566732, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566732, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566733, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566733, 'english', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566733, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566733, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566733, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566734, 'arabic', 10, 8, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566734, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566734, 'math', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566734, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566734, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566735, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566735, 'english', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566735, 'math', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566735, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566735, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566736, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566736, 'english', 10, 9, 38, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566736, 'math', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566736, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566736, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566737, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566737, 'english', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566737, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566737, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566737, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566738, 'arabic', 10, 10, 58, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566738, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566738, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566738, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566738, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566739, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566739, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566739, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566739, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566739, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566740, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566740, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566740, 'math', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566740, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566740, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566741, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566741, 'english', 10, 8, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566741, 'math', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566741, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566741, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566742, 'arabic', 10, 10, 58, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566742, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566742, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566742, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566742, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566743, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566743, 'english', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566743, 'math', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566743, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566743, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566744, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566744, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566744, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566744, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566744, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566745, 'arabic', 10, 10, 59, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566745, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566745, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566745, 'science', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566745, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566746, 'arabic', 10, 10, 59, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566746, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566746, 'math', 9, 10, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566746, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566746, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566747, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566747, 'english', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566747, 'math', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566747, 'science', 4, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566747, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566748, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566748, 'english', 8, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566748, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566748, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566748, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566749, 'arabic', 8, 9, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566749, 'english', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566749, 'math', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566749, 'science', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566749, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566750, 'arabic', 10, 8, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566750, 'english', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566750, 'math', 8, 8, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566750, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566750, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566751, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566751, 'english', 10, 8, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566751, 'math', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566751, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566751, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566752, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566752, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566752, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566752, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566752, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566753, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566753, 'english', 10, 9, 39, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566753, 'math', 10, 9, 37, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566753, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566753, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566754, 'arabic', 10, 10, 59, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566754, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566754, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566754, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566754, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566755, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566755, 'english', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566755, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566755, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566755, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566756, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566756, 'english', 8, 10, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566756, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566756, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566756, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566757, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566757, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566757, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566757, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566757, 'social studies', 5, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566758, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566758, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566758, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566758, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566758, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566759, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566759, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566759, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566759, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566759, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566760, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566760, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566760, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566760, 'science', 5, 4, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566760, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566761, 'arabic', 10, 10, 59, 79);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566761, 'english', 9, 9, 40, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566761, 'math', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566761, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566761, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566762, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566762, 'english', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566762, 'math', 8, 10, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566762, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566762, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566763, 'arabic', 10, 10, 58, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566763, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566763, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566763, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566763, 'social studies', 4, 4, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566764, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566764, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566764, 'math', 8, 8, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566764, 'science', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566764, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566765, 'arabic', 10, 9, 57, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566765, 'english', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566765, 'math', 10, 9, 37, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566765, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566765, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566766, 'arabic', 8, 10, 57, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566766, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566766, 'math', 10, 10, 37, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566766, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566766, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566767, 'arabic', 10, 10, 58, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566767, 'english', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566767, 'math', 9, 10, 37, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566767, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566767, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566768, 'arabic', 8, 10, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566768, 'english', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566768, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566768, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566768, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566769, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566769, 'english', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566769, 'math', 10, 8, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566769, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566769, 'social studies', 4, 4, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566770, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566770, 'english', 8, 8, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566770, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566770, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566770, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566780, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566780, 'english', 8, 8, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566780, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566780, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566780, 'social studies', 4, 4, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566781, 'arabic', 9, 9, 57, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566781, 'english', 8, 8, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566781, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566781, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566781, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566782, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566782, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566782, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566782, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566782, 'social studies', 4, 4, 29, 74);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566783, 'arabic', 8, 9, 57, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566783, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566783, 'math', 10, 10, 38, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566783, 'science', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566783, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566784, 'arabic', 9, 10, 57, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566784, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566784, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566784, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566784, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566785, 'arabic', 8, 10, 57, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566785, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566785, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566785, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566785, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566786, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566786, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566786, 'math', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566786, 'science', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566786, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566787, 'arabic', 8, 9, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566787, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566787, 'math', 8, 9, 40, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566787, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566787, 'social studies', 5, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566788, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566788, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566788, 'math', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566788, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566788, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566789, 'arabic', 8, 9, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566789, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566789, 'math', 8, 9, 40, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566789, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566789, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566790, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566790, 'english', 9, 10, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566790, 'math', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566790, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566790, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566791, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566791, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566791, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566791, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566791, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566792, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566792, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566792, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566792, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566792, 'social studies', 5, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566793, 'arabic', 8, 9, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566793, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566793, 'math', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566793, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566793, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566794, 'arabic', 9, 8, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566794, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566794, 'math', 9, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566794, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566794, 'social studies', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566795, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566795, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566795, 'math', 8, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566795, 'science', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566795, 'social studies', 4, 5, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566796, 'arabic', 9, 8, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566796, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566796, 'math', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566796, 'science', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566796, 'social studies', 5, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566797, 'arabic', 8, 9, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566797, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566797, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566797, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566797, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566798, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566798, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566798, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566798, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566798, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566799, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566799, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566799, 'math', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566799, 'science', 5, 4, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566799, 'social studies', 5, 4, 27, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566100, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566100, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566100, 'math', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566100, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566100, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566101, 'arabic', 9, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566101, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566101, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566101, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566101, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566102, 'arabic', 9, 8, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566102, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566102, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566102, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566102, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566103, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566103, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566103, 'math', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566103, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566103, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566104, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566104, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566104, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566104, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566104, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566105, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566105, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566105, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566105, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566105, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566106, 'arabic', 9, 8, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566106, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566106, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566106, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566106, 'social studies', 4, 4, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566107, 'arabic', 8, 9, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566107, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566107, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566107, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566107, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566108, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566108, 'english', 8, 8, 38, 54);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566108, 'math', 8, 10, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566108, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566108, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566109, 'arabic', 9, 10, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566109, 'english', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566109, 'math', 9, 10, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566109, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566109, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566110, 'arabic', 8, 10, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566110, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566110, 'math', 9, 9, 37, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566110, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566110, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566111, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566111, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566111, 'math', 9, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566111, 'science', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566111, 'social studies', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566112, 'arabic', 9, 8, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566112, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566112, 'math', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566112, 'science', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566112, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566113, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566113, 'english', 10, 9, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566113, 'math', 10, 9, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566113, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566113, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566114, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566114, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566114, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566114, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566114, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566115, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566115, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566115, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566115, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566115, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566116, 'arabic', 8, 9, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566116, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566116, 'math', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566116, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566116, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566117, 'arabic', 8, 9, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566117, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566117, 'math', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566117, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566117, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566118, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566118, 'english', 8, 10, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566118, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566118, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566118, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566119, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566119, 'english', 9, 10, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566119, 'math', 9, 10, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566119, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566119, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566120, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566120, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566120, 'math', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566120, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566120, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566121, 'arabic', 9, 10, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566121, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566121, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566121, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566121, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566122, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566122, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566122, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566122, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566122, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566123, 'arabic', 8, 9, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566123, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566123, 'math', 8, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566123, 'science', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566123, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566124, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566124, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566124, 'math', 9, 9, 37, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566124, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566124, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566125, 'arabic', 10, 9, 57, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566125, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566125, 'math', 10, 9, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566125, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566125, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566126, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566126, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566126, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566126, 'science', 4, 4, 28, 36);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566126, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566127, 'arabic', 8, 9, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566127, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566127, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566127, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566127, 'social studies', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566128, 'arabic', 10, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566128, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566128, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566128, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566128, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566129, 'arabic', 9, 10, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566129, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566129, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566129, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566129, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566130, 'arabic', 8, 9, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566130, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566130, 'math', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566130, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566130, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566131, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566131, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566131, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566131, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566131, 'social studies', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566132, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566132, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566132, 'math', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566132, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566132, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566133, 'arabic', 9, 10, 57, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566133, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566133, 'math', 8, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566133, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566133, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566134, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566134, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566134, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566134, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566134, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566135, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566135, 'english', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566135, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566135, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566135, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566136, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566136, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566136, 'math', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566136, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566136, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566137, 'arabic', 8, 9, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566137, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566137, 'math', 10, 9, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566137, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566137, 'social studies', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566138, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566138, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566138, 'math', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566138, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566138, 'social studies', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566139, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566139, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566139, 'math', 9, 10, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566139, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566139, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566140, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566140, 'english', 8, 8, 39, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566140, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566140, 'science', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566140, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566141, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566141, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566141, 'math', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566141, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566141, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566142, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566142, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566142, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566142, 'science', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566142, 'social studies', 5, 5, 29, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566143, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566143, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566143, 'math', 9, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566143, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566143, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566144, 'arabic', 9, 10, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566144, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566144, 'math', 10, 9, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566144, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566144, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566145, 'arabic', 9, 9, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566145, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566145, 'math', 10, 10, 38, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566145, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566145, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566146, 'arabic', 10, 9, 57, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566146, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566146, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566146, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566146, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566147, 'arabic', 9, 10, 58, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566147, 'english', 8, 10, 37, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566147, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566147, 'science', 4, 5, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566147, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566148, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566148, 'english', 9, 8, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566148, 'math', 10, 10, 38, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566148, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566148, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566149, 'arabic', 10, 9, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566149, 'english', 9, 9, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566149, 'math', 8, 9, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566149, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566149, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566150, 'arabic', 8, 10, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566150, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566150, 'math', 10, 10, 40, 60);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566150, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566150, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566151, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566151, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566151, 'math', 9, 10, 38, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566151, 'science', 4, 5, 28, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566151, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566152, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566152, 'english', 8, 10, 39, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566152, 'math', 10, 9, 40, 59);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566152, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566152, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566153, 'arabic', 9, 9, 58, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566153, 'english', 10, 9, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566153, 'math', 10, 10, 38, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566153, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566153, 'social studies', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566154, 'arabic', 9, 10, 57, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566154, 'english', 9, 10, 39, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566154, 'math', 8, 10, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566154, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566154, 'social studies', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566155, 'arabic', 9, 9, 59, 77);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566155, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566155, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566155, 'science', 4, 5, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566155, 'social studies', 5, 4, 30, 39);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566156, 'arabic', 9, 8, 58, 75);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566156, 'english', 8, 9, 39, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566156, 'math', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566156, 'science', 4, 4, 29, 37);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566156, 'social studies', 5, 5, 28, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566157, 'arabic', 8, 9, 59, 76);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566157, 'english', 9, 9, 38, 56);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566157, 'math', 9, 8, 38, 55);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566157, 'science', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566157, 'social studies', 5, 4, 29, 38);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566158, 'arabic', 9, 10, 59, 78);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566158, 'english', 9, 9, 40, 58);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566158, 'math', 9, 8, 40, 57);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566158, 'science', 5, 5, 30, 40);
INSERT INTO `school`.`study` (`student_ssn`, `subject_name`, `oral`, `midterm`, `final`, `total`) VALUES (445566158, 'social studies', 5, 5, 30, 40);

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`secretary`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`secretary` (`employee_ssn`, `speed typing`) VALUES (166309275, '30 w per m');
INSERT INTO `school`.`secretary` (`employee_ssn`, `speed typing`) VALUES (166311285, '24 w per m');
INSERT INTO `school`.`secretary` (`employee_ssn`, `speed typing`) VALUES (165806050, '50 w per m');

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`worker`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`worker` (`employee_ssn`, `work_hours`) VALUES (160709162, 7);
INSERT INTO `school`.`worker` (`employee_ssn`, `work_hours`) VALUES (165412013, 5);
INSERT INTO `school`.`worker` (`employee_ssn`, `work_hours`) VALUES (166610114, 6);
INSERT INTO `school`.`worker` (`employee_ssn`, `work_hours`) VALUES (160511277, 5);
INSERT INTO `school`.`worker` (`employee_ssn`, `work_hours`) VALUES (164509266, 6);
INSERT INTO `school`.`worker` (`employee_ssn`, `work_hours`) VALUES (169108174, 7);
INSERT INTO `school`.`worker` (`employee_ssn`, `work_hours`) VALUES (160109230, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `school`.`has`
-- -----------------------------------------------------
START TRANSACTION;
USE `school`;
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'social studies', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'science', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'english', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'math', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'arabic', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'science', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'arabic', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'english', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'social studies', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'arabic', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'science', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'math', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/1', 'english', 'thursday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'social studies', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'science', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'english', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'math', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'arabic', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'science', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'arabic', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'english', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'social studies', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'arabic', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'science', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'math', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/2', 'english', 'thursday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'social studies', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'science', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'english', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'math', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'arabic', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'science', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'arabic', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'english', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'social studies', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'arabic', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'science', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'math', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('1/3', 'english', 'thursday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'english', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'arabic', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'social studies', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'math', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'social studies', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'arabic', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'science', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'english', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'science', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'english', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'science', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'math', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/1', 'arabic', 'thursday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'english', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'arabic', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'social studies', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'math', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'social studies', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'arabic', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'science', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'english', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'science', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'english', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'science', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'math', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/2', 'arabic', 'thursday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'english', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'arabic', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'social studies', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'math', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'social studies', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'arabic', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'science', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'english', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'science', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'english', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'science', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'math', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('2/3', 'arabic', 'thursday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'science', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'math', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'english', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'arabic', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'social studies', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'english', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'arabic', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'math', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'science', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'social studies', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'english', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'arabic', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/1', 'science', 'thursday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'science', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'math', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'english', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'arabic', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'social studies', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'english', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'arabic', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'math', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'science', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'social studies', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'english', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'arabic', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/2', 'science', 'thursday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'science', 'sunday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'math', 'sunday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'break', 'sunday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'english', 'sunday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'arabic', 'monday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'social studies', 'monday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'break', 'monday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'english', 'monday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'social studies', 'tuesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'arabic', 'tuesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'break', 'tuesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'math', 'tuesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'science', 'wednesday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'social studies', 'wednesday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'break', 'wednesday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'math', 'wednesday', '12:00:00', '13:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'english', 'thursday', '8:00:00', '9:30:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'arabic', 'thursday', '9:30:00', '11:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'break', 'thursday', '11:00:00', '12:00:00');
INSERT INTO `school`.`has` (`class`, `sub_name`, `day`, `from`, `to`) VALUES ('3/3', 'science', 'thursday', '12:00:00', '13:30:00');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
