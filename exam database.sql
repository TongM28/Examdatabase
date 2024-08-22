CREATE DATABASE XgameBattle;
USE XgameBattle;

CREATE TABLE PlayerTable (
    PlayerId CHAR(36) PRIMARY KEY,
    PlayerName NVARCHAR(120),
    PlayerNatinal NVARCHAR(50)
);

CREATE TABLE ItemTypeTable (
    ItemTypeId INT PRIMARY KEY AUTO_INCREMENT,
    ItemTypeName NVARCHAR(50)
);

CREATE TABLE ItemTable (
    ItemId CHAR(36) PRIMARY KEY,
    ItemName NVARCHAR(120),
    ItemTypeId INT,
    Price DECIMAL(21, 6),
    FOREIGN KEY (ItemTypeId) REFERENCES ItemTypeTable(ItemTypeId)
);

CREATE TABLE PlayerItem (
    ItemId CHAR(36),
    PlayerId CHAR(36),
    PRIMARY KEY (ItemId, PlayerId),
    FOREIGN KEY (ItemId) REFERENCES ItemTable(ItemId),
    FOREIGN KEY (PlayerId) REFERENCES PlayerTable(PlayerId)
);


USE XgameBattle;

-- Insert data into PlayerTable
INSERT INTO PlayerTable (PlayerId, PlayerName, PlayerNatinal)
VALUES 
('2C16E515-83AF-4D37-8A21-58AFD900E3F6', 'Player 1', 'Viet Nam'),
('D401EA60-7A83-4C7E-BF6E-707CF1F3E57E', 'Player 2', 'US');

-- Insert data into ItemTypeTable
INSERT INTO ItemTypeTable (ItemTypeId, ItemTypeName)
VALUES 
(1, 'Attack'),
(2, 'Defense');

-- Insert data into ItemTable
INSERT INTO ItemTable (ItemId, ItemName, ItemTypeId, Price)
VALUES 
('72883972-051D-4B96-B229-05DE58D5F1EE', 'Gun', 1, 5),
('838913C2-AC84-4080-9B52-5734C4E05082', 'Bullet', 1, 10),
('97E25C9F-FA12-4D9A-AB32-D62EBC21078F', 'Shield', 2, 20);

-- Insert data into PlayerItem
INSERT INTO PlayerItem (ItemId, PlayerId)
VALUES 
('72B83972-051D-4B96-B229-05DE585DF1EE', '72B83972-051D-4B96-B229-05DE585DF1EE'),
('83B931C2-AC84-4080-9852-5734C4E05082', '83B931C2-AC84-4080-9852-5734C4E05082'),
('97E25C9F-FA12-4D9A-AB32-D62EBC2107BF', '97E25C9F-FA12-4D9A-AB32-D62EBC2107BF');


DELIMITER //

CREATE PROCEDURE GetMaxPriceForPlayer1()
BEGIN
    SELECT MAX(i.Price) AS MaxPrice
    FROM PlayerItem pi
    JOIN ItemTable i ON pi.ItemId = i.ItemId
    WHERE pi.PlayerId = '2C16E515-83AF-4D37-8A21-58AFD900E3F6';
END //

DELIMITER ;

-- Execute the procedure
CALL GetMaxPriceForPlayer1();


DELIMITER //

CREATE PROCEDURE GetPlayerItemsSortedByName()
BEGIN
    SELECT p.PlayerName, i.ItemName, it.ItemTypeName as ItemType, i.Price
    FROM PlayerItem pi
    JOIN PlayerTable p ON pi.PlayerId = p.PlayerId  
    JOIN ItemTable i ON pi.ItemId = i.ItemId
    JOIN ItemTypeTable it ON i.ItemTypeId = it.ItemTypeId
    ORDER BY p.PlayerName;
END //

DELIMITER ;

-- Execute the procedure
CALL GetPlayerItemsSortedByName();

