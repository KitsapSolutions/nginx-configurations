<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, and ABSPATH. You can find more information by visiting
 * {@link https://codex.wordpress.org/Editing_wp-config.php Editing wp-config.php}
 * Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'example');

/** MySQL database username */
define('DB_USER', 'example');

/** MySQL database password */
define('DB_PASSWORD', 'example');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/* SFTP parameters */
/* These parameters make is possible to upload directly into Wordpress via SFTP. */
define('FTP_PUBKEY','/home/example/.ssh/id_rsa.pub');
define('FTP_PRIKEY','/home/example/.ssh/id_rsa');
define('FTP_USER','ftp_user_name');
define('FTP_PASS','');
define('FTP_HOST','127.0.0.1:22');
// Possible values: "direct", "ssh2", "ftpext", or "ftpsockets".
define('FS_METHOD', 'direct');
define('WP_MEMORY_LIMIT', '128M');
define('FORCE_SSL_ADMIN', true);
// Required for Wordpress Nginx Helper plugin.
define('RT_WP_NGINX_HELPER_CACHE_PATH','/tmp/cache/');
/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'some_gibberish');
define('SECURE_AUTH_KEY',  'some_gibberish');
define('LOGGED_IN_KEY',    'some_gibberish');
define('NONCE_KEY',        'some_gibberish');
define('AUTH_SALT',        'some_gibberish');
define('SECURE_AUTH_SALT', 'some_gibberish');
define('LOGGED_IN_SALT',   'some_gibberish');
define('NONCE_SALT',       'some_gibberish');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'pre_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
