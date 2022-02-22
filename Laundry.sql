CREATE TABLE `tr_merchant` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `tr_invoice` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `invoice_type` varchar(255),
  `is_logo` boolean,
  `is_qr_code` boolean,
  `notes` text,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `tr_outlets` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `outlet_id` varchar(255),
  `outlet_name` varchar(255),
  `image` varchar(255),
  `address` text,
  `postal_code` varchar(255),
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `merchant_id` int,
  `invoice_id` int
);
ALTER TABLE `tr_outlets` ADD FOREIGN KEY (`merchant_id`) REFERENCES `tr_merchant` (`id`);
ALTER TABLE `tr_outlets` ADD FOREIGN KEY (`invoice_id`) REFERENCES `tr_invoice` (`id`);

CREATE TABLE `tr_services_parent` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `service_name` varchar(255),
  `is_available` boolean,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `outlet_id` int
);
ALTER TABLE `tr_services_parent` ADD FOREIGN KEY (`outlet_id`) REFERENCES `tr_outlets` (`id`);

CREATE TABLE `tr_services` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `service_name` varchar(255),
  `price` int,
  `category_id` int,
  `category_name` varchar(255),
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `outlet_id` int
);
ALTER TABLE `tr_services` ADD FOREIGN KEY (`outlet_id`) REFERENCES `tr_services_parent` (`id`);

CREATE TABLE `tr_services_category` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(255),
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `outlet_id` int
);
ALTER TABLE `tr_services_category` ADD FOREIGN KEY (`outlet_id`) REFERENCES `tr_services` (`id`);

CREATE TABLE `tr_services_time` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `time_name` varchar(255),
  `time_hour` int,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `service_id` int
);
ALTER TABLE `tr_services_time` ADD FOREIGN KEY (`service_id`) REFERENCES `tr_services` (`id`);

CREATE TABLE `tr_parfumes` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `parfume_name` varchar(255),
  `price` int,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `tr_payment_method` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `payment_name` varchar(255),
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `tr_users_owner` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(255),
  `name` varchar(255),
  `no_hp` varchar(255),
  `address` text,
  `email` varchar(255),
  `password` varchar(255),
  `user_type` varchar(255),
  `remember_me_token` varchar(255),
  `avatar` varchar(255),
  `email_verified_at` datetime,
  `is_activated` boolean,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `merchant_id` int
);
ALTER TABLE `tr_users_owner` ADD FOREIGN KEY (`merchant_id`) REFERENCES `tr_merchant` (`id`);

CREATE TABLE `tr_users_cashier` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(255),
  `name` varchar(255),
  `no_hp` varchar(255),
  `address` text,
  `email` varchar(255),
  `password` varchar(255),
  `user_type` varchar(255),
  `remember_me_token` varchar(255),
  `avatar` varchar(255),
  `email_verified_at` datetime,
  `is_activated` boolean,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `outlet_id` int,
  `owner_id` int
);
ALTER TABLE `tr_users_cashier` ADD FOREIGN KEY (`outlet_id`) REFERENCES `tr_outlets` (`id`);
ALTER TABLE `tr_users_cashier` ADD FOREIGN KEY (`owner_id`) REFERENCES `tr_users_owner` (`id`);

CREATE TABLE `tt_order_kiloan` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `customer_name` varchar(255),
  `date_order` datetime,
  `date_finish` datetime,
  `number_of_kilos` double,
  `total_cost` double,
  `pay_amount` double,
  `remainder` double,
  `change_money` double,
  `payment_status` varchar(255),
  `order_status` int,
  `discount` double,
  `notes` text,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `cashier_id` int,
  `customer_id` int,
  `service_parent_id` int,
  `service_id` int,
  `service_time_id` int,
  `parfume_id` int,
  `payment_method_id` int
);
ALTER TABLE `tt_order_kiloan` ADD FOREIGN KEY (`cashier_id`) REFERENCES `tr_users_cashier` (`id`);
ALTER TABLE `tt_order_kiloan` ADD FOREIGN KEY (`customer_id`) REFERENCES `tr_customers` (`id`);
ALTER TABLE `tt_order_kiloan` ADD FOREIGN KEY (`service_parent_id`) REFERENCES `tr_services_parent` (`id`);
ALTER TABLE `tt_order_kiloan` ADD FOREIGN KEY (`service_id`) REFERENCES `tr_services` (`id`);
ALTER TABLE `tt_order_kiloan` ADD FOREIGN KEY (`service_time_id`) REFERENCES `tr_services_time` (`id`);
ALTER TABLE `tt_order_kiloan` ADD FOREIGN KEY (`parfume_id`) REFERENCES `tr_parfumes` (`id`);
ALTER TABLE `tt_order_kiloan` ADD FOREIGN KEY (`payment_method_id`) REFERENCES `tr_payment_method` (`id`);

CREATE TABLE `tt_order_satuan` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `customer_name` varchar(255),
  `date_order` datetime,
  `total_cost` double,
  `pay_amount` double,
  `remainder` double,
  `change_money` double,
  `payment_method` varchar(255),
  `payment_status` varchar(255),
  `order_status` int,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `cashier_id` int,
  `customer_id` int,
  `service_parent_id` int
);
ALTER TABLE `tt_order_satuan` ADD FOREIGN KEY (`cashier_id`) REFERENCES `tr_users_cashier` (`id`);
ALTER TABLE `tt_order_satuan` ADD FOREIGN KEY (`customer_id`) REFERENCES `tr_customers` (`id`);
ALTER TABLE `tt_order_satuan` ADD FOREIGN KEY (`service_parent_id`) REFERENCES `tr_services_parent` (`id`);

CREATE TABLE `tt_order_satuan_details` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `qty` double,
  `discount` double,
  `notes` text,
  `date_order` datetime,
  `date_finish` datetime,
  `unit_type` varchar(255),
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `service_id` int,
  `service_time_id` int,
  `order_satuan_id` int
);
ALTER TABLE `tt_order_satuan_details` ADD FOREIGN KEY (`service_id`) REFERENCES `tr_services` (`id`);
ALTER TABLE `tt_order_satuan_details` ADD FOREIGN KEY (`service_time_id`) REFERENCES `tr_services_time` (`id`);
ALTER TABLE `tt_order_satuan_details` ADD FOREIGN KEY (`order_satuan_id`) REFERENCES `tt_order_satuan` (`id`);

CREATE TABLE `tr_customers` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `no_hp` varchar(255),
  `address` varchar(255),
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `outlet_id` int
);
ALTER TABLE `tr_customers` ADD FOREIGN KEY (`outlet_id`) REFERENCES `tr_outlets` (`id`);

CREATE TABLE `tt_order_history` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `customer_name` varchar(255),
  `date_order` datetime,
  `total_cost` double,
  `pay_amount` double,
  `payment_status` varchar(255),
  `order_status` int,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `cashier_id` int,
  `customer_id` int,
  `order_satuan_id` int,
  `order_kiloan_id` int
);
ALTER TABLE `tt_order_history` ADD FOREIGN KEY (`cashier_id`) REFERENCES `tr_users_cashier` (`id`);
ALTER TABLE `tt_order_history` ADD FOREIGN KEY (`customer_id`) REFERENCES `tr_customers` (`id`);
ALTER TABLE `tt_order_history` ADD FOREIGN KEY (`order_satuan_id`) REFERENCES `tt_order_satuan` (`id`);
ALTER TABLE `tt_order_history` ADD FOREIGN KEY (`order_kiloan_id`) REFERENCES `tt_order_kiloan` (`id`);

CREATE TABLE `tt_operational` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `operational_name` varchar(255),
  `operational_type` varchar(255),
  `amount` double,
  `qty` double,
  `unit_type` varchar(255),
  `notes` text,
  `is_active` boolean,
  `created_at` datetime,
  `updated_at` datetime,
  `cashier_id` int
);
ALTER TABLE `tt_operational` ADD FOREIGN KEY (`cashier_id`) REFERENCES `tr_users_cashier` (`id`);
ALTER TABLE `tt_operational` ADD FOREIGN KEY (`cashier_id`) REFERENCES `tr_users_cashier` (`id`);
