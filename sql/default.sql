CREATE TABLE `analysis` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sentiment` VARCHAR(45) NULL DEFAULT 'null',
  `hashtags` VARCHAR(250) NULL DEFAULT 'null',
  `user_image` VARCHAR(250) NULL DEFAULT 'null',
  `user_name` VARCHAR(100) NULL DEFAULT 'null',
  `user_username` VARCHAR(100) NULL DEFAULT 'null',
  `created_at` VARCHAR(50) NULL DEFAULT 'null',
  `source` VARCHAR(45) NULL DEFAULT 'null',
  `user_id` VARCHAR(45) NULL DEFAULT 'null',
  `mentions` VARCHAR(250) NULL DEFAULT 'null',
  `user_url` VARCHAR(200) NULL DEFAULT 'null',
  `twitter_id` VARCHAR(45) NULL DEFAULT 'null',
  `text` VARCHAR(250) NULL DEFAULT 'null',
  `user_location` VARCHAR(100) NULL DEFAULT 'null',
  `user_verified` VARCHAR(10) NULL DEFAULT 'false',
  `timestamp` BIGINT(20) NULL DEFAULT 0,
  `filter` VARCHAR(45) NULL DEFAULT 'null',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;