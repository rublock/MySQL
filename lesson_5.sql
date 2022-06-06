DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия', -- COMMENT на случай, если имя неочевидное
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100), 	
	phone BIGINT UNSIGNED UNIQUE,
    INDEX users_firstname_lastname_idx(firstname, lastname)
) COMMENT 'юзеры';

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('1', 'River', 'Klein', 'justine.kunde@example.net', 'c42c35f31c06e9fcdae15bb8ca1b917cd85f10f9', '84957498120');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('2', 'Kavon', 'Kunze', 'hschmitt@example.net', 'ea4ee6706010530991508e6bb4a27c81592df950', '84951665351');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('3', 'Darby', 'Champlin', 'tamia24@example.com', '2ee5ac88f9c0f20992a2f9826d6a62cefd57d07d', '84953601190');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('4', 'Brett', 'Mann', 'boyle.rachael@example.com', '9afeb2ecf6b5fabea2464e70d18b8c26c396daf5', '84950838329');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('5', 'Sidney', 'Spinka', 'lea08@example.com', '49d844dde6e58a3c8ac15f8658da3feae8942a1c', '84951701351');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('6', 'Alec', 'Hodkiewicz', 'vschuppe@example.net', 'e44dea3aa4656a7fd18a2335bf40d0a710a60a84', '84955276323');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('7', 'Antone', 'Ruecker', 'chandler.rice@example.org', '790bb54c934787bbffced5462a60fc0921ffe972', '84959840258');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('8', 'Ryleigh', 'Ankunding', 'myron.legros@example.net', '553f73944b5d7f694e895d221369a45b33ddb23d', '84959388293');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('9', 'Kirsten', 'Spencer', 'joelle59@example.org', 'c0b0c94fe3bfd774a517dddfa10c2004de17c278', '84954966165');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('10', 'Sylvia', 'Boyer', 'cdickens@example.net', 'aedaf3d4436eb89e4ab7a0be0d5dc078a3b0578e', '84959522651');

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
	
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- пока рано, т.к. таблицы media еще нет
);

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('1', 'm', '2012-03-18', '1', '2008-09-18 05:55:51', 'Veldaville');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('2', 'm', '2017-12-25', '2', '2000-04-09 11:27:27', 'North Katrinaburgh');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('3', 'm', '1993-12-24', '3', '1984-06-13 19:36:13', 'North Bennetttown');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('4', 'm', '2005-09-30', '4', '1993-05-28 03:47:36', 'Kovacekstad');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('5', 'f', '2003-07-31', '5', '2000-04-09 14:35:52', 'South Kadehaven');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('6', 'f', '1981-03-04', '6', '1992-11-01 22:02:20', 'Bruenhaven');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('7', 'm', '1996-08-02', '7', '1973-11-26 23:21:59', 'Hamillfort');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('8', 'm', '2000-06-22', '8', '1991-08-13 09:44:09', 'West Jeanette');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('9', 'f', '2012-04-13', '9', '1983-10-30 06:37:31', 'Abshirestad');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('10', 'f', '1986-12-09', '10', '2008-03-17 01:23:22', 'West Evaberg');


ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE -- (значение по умолчанию)
    ON DELETE RESTRICT; -- (значение по умолчанию)

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- можно будет даже не упоминать это поле при вставке

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('1', '1', '1', 'Eos nesciunt earum explicabo dolor porro quia. Dolorum quae dolor dolorem ut. Autem voluptas error corporis perferendis.', '2006-09-30 22:45:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('2', '2', '2', 'Voluptate est pariatur asperiores dolore velit omnis. Voluptas dolore ea et. Consequatur non beatae harum tempore. Quis occaecati autem illum laborum nam ipsam ipsum.', '1995-02-07 17:06:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('3', '3', '3', 'Voluptatum voluptas veritatis saepe voluptas veritatis. Tempore sunt doloribus quos omnis accusamus laborum. Eius qui nam accusamus aut vel architecto laboriosam. Eos quis nihil beatae minima culpa tempore excepturi itaque.', '1980-10-30 14:05:30');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('4', '4', '4', 'Distinctio reprehenderit repellat et quo enim placeat. Libero voluptates qui error similique autem autem nihil. Ut maxime quos tempore nam quia doloremque aut nisi.', '1986-01-14 01:49:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('5', '5', '5', 'Unde doloremque et architecto dolore similique commodi. Autem beatae vero magnam amet ipsum. Dolorum quibusdam iste ad facilis omnis aut.', '2009-05-17 14:59:59');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('6', '6', '6', 'Illum iure est sint quia soluta. Est autem iusto molestiae voluptas. Aut nostrum est sed ut est facere qui repellat. Ut quia possimus est deleniti ullam. Non est ex minus quam dolore rerum eveniet est.', '2010-07-27 22:02:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('7', '7', '7', 'Temporibus alias repellendus cum. Iusto et qui sapiente illum eveniet. Non et cum in qui sed. Et quia voluptatem ullam cumque deserunt animi.', '2008-07-24 17:29:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('8', '8', '8', 'Omnis omnis quia et labore. Illo esse officia quos sunt. Fugiat magni tenetur omnis alias dolore. Et enim neque harum eum corporis omnis non.', '1994-08-19 13:45:56');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('9', '9', '9', 'Iusto voluptatibus iusto sed aut velit distinctio quis. Qui cumque non magnam et aliquid. Iste qui in quibusdam molestiae provident quis quia.', '1985-11-21 07:42:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('10', '10', '10', 'Dolorem in sed non. Nobis quae ad inventore. Officia dolor ut in quisquam adipisci blanditiis.', '1971-10-22 17:12:55');

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL, -- изменили на составной ключ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
    -- `status` TINYINT(1) UNSIGNED, -- в этом случае в коде хранили бы цифирный enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP, -- можно будет даже не упоминать это поле при обновлении
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)-- ,
    -- CHECK (initiator_user_id <> target_user_id)
);

INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('1', '1', 'declined', '1982-07-15 02:32:02', '1992-11-30 02:30:48');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('2', '2', 'unfriended', '1975-04-05 20:10:28', '2007-04-01 16:26:51');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('3', '3', 'requested', '1988-02-23 11:47:19', '2020-09-22 09:40:21');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('4', '4', 'approved', '1972-03-17 16:49:59', '1988-12-02 19:54:06');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('5', '5', 'unfriended', '1978-08-20 00:21:27', '1978-08-12 23:26:27');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('6', '6', 'declined', '1977-09-04 19:41:25', '1976-02-18 15:53:39');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('7', '7', 'unfriended', '2013-01-08 20:05:38', '1975-07-18 17:09:23');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('8', '8', 'declined', '2018-07-15 09:34:24', '2004-11-17 12:22:25');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('9', '9', 'requested', '1996-10-20 22:56:07', '1981-12-01 09:13:51');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `updated_at`) VALUES ('10', '10', 'unfriended', '1982-03-15 03:17:07', '2009-11-07 01:47:00');

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	
	INDEX communities_name_idx(name), -- индексу можно давать свое имя (communities_name_idx)
	foreign key (admin_user_id) references users(id)
);

INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('1', 'Kelly', '1');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('2', 'Keely', '2');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('3', 'Nyah', '3');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('4', 'Earnestine', '4');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('5', 'Laura', '5');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('6', 'Melba', '6');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('7', 'Eleanora', '7');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('8', 'Marielle', '8');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('9', 'Reta', '9');
INSERT INTO `communities` (`id`, `name`, `admin_user_id`) VALUES ('10', 'Dana', '10');

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('1', '1');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('2', '2');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('3', '3');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('4', '4');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('5', '5');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('6', '6');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('7', '7');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('8', '8');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('9', '9');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('10', '10');


DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name VARCHAR(255), -- записей мало, поэтому в индексе нет необходимости
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'aut', '2004-05-14 02:00:50', '1997-08-25 16:25:33');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('2', 'aperiam', '2002-09-22 04:06:52', '2021-12-24 12:24:56');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('3', 'fugiat', '2005-09-06 16:34:59', '2006-02-03 22:21:35');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('4', 'deleniti', '1970-03-27 07:28:19', '2009-05-08 02:41:36');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('5', 'velit', '1984-06-18 07:35:05', '1994-09-02 13:29:52');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('6', 'error', '2014-01-24 11:40:58', '1978-08-17 16:02:53');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('7', 'voluptate', '2001-01-04 13:08:58', '1996-06-25 14:20:14');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('8', 'optio', '2009-11-15 00:24:12', '2002-10-17 21:18:10');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('9', 'aliquid', '1972-12-06 20:52:12', '1980-01-28 06:10:23');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('10', 'consequuntur', '2017-10-29 09:12:40', '1983-06-30 16:58:21');

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    -- file blob,    	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('1', '1', '1', 'Quaerat totam possimus voluptatem ex. Adipisci quidem sunt aliquam. Architecto vel et rerum ut aut impedit sed.', 'recusandae', 776696179, NULL, '2006-08-30 06:18:26', '2001-03-25 16:47:50');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('2', '2', '2', 'Recusandae aut nobis dolores est voluptatem. Quam nemo consequatur dolorem molestiae vel maiores non. Molestiae maiores eum commodi voluptas doloribus omnis.', 'itaque', 213243950, NULL, '1998-08-10 18:16:18', '2014-08-14 03:29:12');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('3', '3', '3', 'Et occaecati veritatis eum. Sed rem error magni. Omnis odio qui nostrum et.', 'rerum', 138024, NULL, '1980-06-29 03:08:08', '1994-05-04 22:49:26');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('4', '4', '4', 'Ipsum iure ut et iste. Quis nostrum est occaecati necessitatibus et mollitia deserunt odit. Voluptatum et iusto quo voluptatem aut ut natus ut. Sequi vel natus provident aut totam omnis. Dolorum eos tempore consectetur ut enim.', 'labore', 65741, NULL, '1979-08-18 09:54:54', '1998-05-17 03:22:58');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('5', '5', '5', 'Eos aut iusto dolore sunt minus perspiciatis quas voluptates. Enim labore occaecati molestiae sit laborum laborum.', 'accusantium', 8, NULL, '1992-06-07 10:48:56', '1978-03-29 13:36:47');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('6', '6', '6', 'Qui doloribus ut vero eveniet. Architecto numquam et a. Beatae voluptatem ratione earum est sapiente. Itaque nulla repellendus neque totam.', 'saepe', 0, NULL, '1970-06-12 16:20:56', '2021-07-13 16:11:54');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('7', '7', '7', 'Ea nihil aut cumque tempora autem quod. Voluptate ut sit sed quisquam eius ut velit. Asperiores sed incidunt est sit sint sit qui.', 'natus', 0, NULL, '2010-01-11 11:31:46', '1985-08-14 18:12:47');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('8', '8', '8', 'Delectus eveniet et soluta voluptatibus qui voluptas. Blanditiis id aut aut magnam qui natus fugit odit. Doloremque expedita eligendi eligendi veritatis quod nobis alias voluptate.', 'ipsum', 242650, NULL, '1999-10-25 06:10:07', '1979-09-15 16:19:51');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('9', '9', '9', 'Officiis esse similique vel. Sit animi et praesentium. Aperiam consequatur amet molestiae excepturi. Dignissimos incidunt non facere et beatae repudiandae.', 'omnis', 8, NULL, '2008-12-06 21:54:15', '1983-01-18 16:44:26');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('10', '10', '10', 'Nulla dolor amet occaecati aliquam tempora vitae. Et ipsam amet corporis voluptate. Sint dolor voluptas et sit doloremque. Sunt voluptatibus qui ipsam et et non.', 'enim', 63030, NULL, '1995-11-29 22:39:19', '1976-08-08 09:14:32');


DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()

    -- PRIMARY KEY (user_id, media_id) – можно было и так вместо id в качестве PK
  	-- слишком увлекаться индексами тоже опасно, рациональнее их добавлять по мере необходимости (напр., провисают по времени какие-то запросы)  

/* намеренно забыли, чтобы позднее увидеть их отсутствие в ER-диаграмме
    , FOREIGN KEY (user_id) REFERENCES users(id)
    , FOREIGN KEY (media_id) REFERENCES media(id)
*/
);

INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('1', '1', '1', '1976-08-21 17:22:29');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('2', '2', '2', '2011-06-12 19:34:42');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('3', '3', '3', '1998-09-13 16:40:38');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('4', '4', '4', '2010-02-26 06:13:09');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('5', '5', '5', '1998-12-16 03:30:36');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('6', '6', '6', '1982-06-15 20:46:27');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('7', '7', '7', '1992-04-09 10:40:05');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('8', '8', '8', '1978-10-14 14:23:28');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('9', '9', '9', '2008-01-30 17:24:49');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('10', '10', '10', '2014-07-18 20:12:36');


DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('1', 'eum', '1');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('2', 'id', '2');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('3', 'inventore', '3');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('4', 'magni', '4');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('5', 'dolor', '5');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('6', 'dolorum', '6');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('7', 'enim', '7');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('8', 'quis', '8');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('9', 'nesciunt', '9');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('10', 'in', '10');

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL,
	`album_id` BIGINT unsigned NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('1', '1', '1');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('2', '2', '2');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('3', '3', '3');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('4', '4', '4');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('5', '5', '5');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('6', '6', '6');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('7', '7', '7');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('8', '8', '8');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('9', '9', '9');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('10', '10', '10');

DROP TABLE IF EXISTS higher_education;
CREATE TABLE higher_education (
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	institute VARCHAR(255) COMMENT 'Институт',
	faculty VARCHAR(255) COMMENT 'Факультет',
	education_form VARCHAR(255) COMMENT 'Форма обучения',
	status VARCHAR(255) COMMENT 'Текущий статус учащегося',
	
	FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'Высшее образование';

INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('1', '1', 'Swift-Turner', 'Upton', '3', 'v');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('2', '2', 'Larson-Daugherty', 'Schmitt', '1', 'j');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('3', '3', 'Jaskolski-King', 'Connelly', '2', 'p');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('4', '4', 'Cummings Ltd', 'Fahey', '5', 'p');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('5', '5', 'Lakin Ltd', 'Kassulke', '8', 'g');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('6', '6', 'Bins, Jacobi and Rempel', 'Langworth', '8', 'w');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('7', '7', 'Renner and Sons', 'Beatty', '9', 'i');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('8', '8', 'Berge Inc', 'Boyer', '6', 'h');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('9', '9', 'Schuppe, Bahringer and Kertzmann', 'Labadie', '4', 'c');
INSERT INTO `higher_education` (`id`, `user_id`, `institute`, `faculty`, `education_form`, `status`) VALUES ('10', '10', 'Shields, Cruickshank and Kunze', 'Mann', '8', 't');

DROP TABLE IF EXISTS secondary_education;
CREATE TABLE secondary_education (
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	school VARCHAR(255) COMMENT 'Школа',
	year_end VARCHAR(255) COMMENT 'Год окончания',
	
	FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'Среднее образование';

INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('1', '1', 'Schuppe PLC', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('2', '2', 'Greenfelder and Sons', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('3', '3', 'Baumbach, Bernier and Ratke', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('4', '4', 'Effertz PLC', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('5', '5', 'Kshlerin Inc', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('6', '6', 'Lubowitz-Prosacco', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('7', '7', 'Heidenreich-Mertz', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('8', '8', 'Keebler LLC', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('9', '9', 'Hodkiewicz-Hoppe', '1970');
INSERT INTO `secondary_education` (`id`, `user_id`, `school`, `year_end`) VALUES ('10', '10', 'Heidenreich LLC', '1970');

DROP TABLE IF EXISTS wall;
CREATE TABLE wall(
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
)COMMENT 'Стена';

INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('1', '1');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('2', '2');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('3', '3');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('4', '4');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('5', '5');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('6', '6');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('7', '7');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('8', '8');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('9', '9');
INSERT INTO `wall` (`user_id`, `media_id`) VALUES ('10', '10');

-- ЗАДАНИЕ 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
ALTER TABLE users
ADD COLUMN created_at VARCHAR(50) AFTER phone,
ADD COLUMN updated_at VARCHAR(50) AFTER created_at;

UPDATE users SET created_at = now();
UPDATE users SET updated_at = now();

-- ЗАДАНИЕ 2 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое 
-- время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
ALTER TABLE users MODIFY created_at DATETIME;
ALTER TABLE users MODIFY updated_at DATETIME;

-- ЗАДАНИЕ 3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
-- если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, 
-- нулевые запасы должны выводиться в конце, после всех записей.
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL, 
    name VARCHAR(50),
	value BIGINT,
	price BIGINT
) COMMENT 'Складские запасы';

INSERT INTO `storehouses_products` (`id`, `name`, `value`, `price`) VALUES ('1', 'bread', '0', '25');
INSERT INTO `storehouses_products` (`id`, `name`, `value`, `price`) VALUES ('2', 'coke', '0', '70');
INSERT INTO `storehouses_products` (`id`, `name`, `value`, `price`) VALUES ('3', 'meat', '1', '700');
INSERT INTO `storehouses_products` (`id`, `name`, `value`, `price`) VALUES ('4', 'ice cream', '3', '100');
INSERT INTO `storehouses_products` (`id`, `name`, `value`, `price`) VALUES ('5', 'milk', '6', '65');

SELECT value FROM storehouses_products ORDER BY value = 0, value;

-- ЗАДАНИЕ 4 (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')
ALTER TABLE users ADD COLUMN birthday VARCHAR(50) AFTER updated_at;

UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 1;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 2;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 3;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 4;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 5;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 6;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 7;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 8;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 9;
UPDATE users SET birthday = CURRENT_DATE - INTERVAL FLOOR(RAND() * 9999) DAY WHERE id = 10;

SELECT * FROM users WHERE MONTH(birthday) = 5 OR MONTH(birthday) = 8;

-- ЗАДАНИЕ 5 (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

-- беру для примера таблицу storehouses_products

SELECT * FROM storehouses_products WHERE id IN (5, 1, 2) 
ORDER BY CASE id 
	       WHEN 5 THEN 1
           WHEN 1 THEN 2
           WHEN 2 THEN 3
         END;

-- Практическое задание теме “Агрегация данных”
        
-- ЗАДАНИЕ 1 Подсчитайте средний возраст пользователей в таблице users

SELECT AVG(price) FROM storehouses_products;

-- ЗАДАНИЕ 2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT COUNT(id), birthday FROM users GROUP BY DAY(birthday);

-- ЗАДАНИЕ 3 (по желанию) Подсчитайте произведение чисел в столбце таблицы

SELECT exp(SUM(log(price))) FROM storehouses_products;







