INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('cleanshort', 'Weapon cloth', 10, 1, 'item_standard', 1);

-- to add more items import in db : INSERT ignore INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('configdbname', 'dbitemname', 10, 1, 'item_standard', 1); and change dbitemname and configdbname for the configured ones in Config.lua