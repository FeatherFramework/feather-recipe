CREATE TABLE `roles` (
    `ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `Name` varchar(255) NOT NULL,
    `Level` int NOT NULL,
    PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `users` (
    `ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `RoleID` bigint UNSIGNED NOT NULL,
    `Username` varchar(255) NOT NULL,
    `License` varchar(255) NOT NULL,
    `SteamID` varchar(255) NOT NULL,
    `CreatedAt` TimeStamp,
    `UpdatedAt` TimeStamp,
    PRIMARY KEY (`ID`),
    CONSTRAINT `FK_Role` FOREIGN KEY (`RoleID`) REFERENCES `Roles` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `characters` (
    `ID` bigint UNSIGNED  NOT NULL AUTO_INCREMENT,
    `UserID` bigint UNSIGNED  NOT NULL,
    `FirstName` varchar(255) NOT NULL,
    `LastName` varchar(255) NOT NULL,
    `DOB` varchar(255) NOT NULL,
    `Dollars` decimal(15,3) NOT NULL,
    `Gold` decimal(15,3) NOT NULL,
    `XP` float NOT NULL,
    `X` decimal(15,10) NOT NULL,
    `Y` decimal(15,10) NOT NULL,
    `Z` decimal(15,10) NOT NULL,
    `CreatedAt` TimeStamp,
    `UpdatedAt` TimeStamp,
    PRIMARY KEY (`ID`),
    CONSTRAINT `FK_User` FOREIGN KEY (`UserID`) REFERENCES `Users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `inventory` (
    `ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `EntityID` bigint UNSIGNED NOT NULL,
    `EntityType` varchar(255) NOT NULL,
    PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `items` (
    `ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `Name` varchar(255) NOT NULL,
    `MaxQuantity` int DEFAULT 0,
    `ModelName` varchar(255) NOT NULL,
    `Usable` boolean DEFAULT false,
    PRIMARY KEY (`ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `InventoryItems` (
    `ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `InventoryID` bigint UNSIGNED NOT NULL,
    `ItemID` bigint UNSIGNED NOT NULL,
    `Name` varchar(255) NOT NULL,
    `Quantity` int NOT NULL,
    PRIMARY KEY (`ID`),
    CONSTRAINT `FK_Inventory` FOREIGN KEY (`InventoryID`) REFERENCES `Inventory` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_InventoryItem` FOREIGN KEY (`ItemID`) REFERENCES `Items` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `InventoryAllowList` (
    `ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `InventoryID` bigint UNSIGNED NOT NULL,
    `EntityID` bigint UNSIGNED NOT NULL,
    PRIMARY KEY (`ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;