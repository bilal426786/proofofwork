<?php

use Illuminate\Support\Str;

return [
    'default' => env('DB_CONNECTION', 'mysql'),
    'connections' => [
        'mysql' => [
            'driver'    => 'mysql',
            'url'       => env('DB_URL'),
            'host'      => env('DB_HOST', '127.0.0.1'),
            'port'      => env('DB_PORT', '3306'),
            'database'  => env('DB_DATABASE', 'laravel'),
            'username'  => env('DB_USERNAME', 'root'),
            'password'  => env('DB_PASSWORD', ''),
            'charset'   => 'utf8mb4',
            'collation' => 'utf8mb4_unicode_ci',
            'prefix'    => '',
            'strict'    => true,
            'engine'    => null,
        ],
    ],
    'redis' => [
        'client' => env('REDIS_CLIENT', 'predis'),
        'default' => [
            'host'     => env('REDIS_HOST', '127.0.0.1'),
            'password' => env('REDIS_PASSWORD'),
            'port'     => env('REDIS_PORT', 6379),
            'database' => env('REDIS_DB', 0),
        ],
        'cache' => [
            'host'     => env('REDIS_HOST', '127.0.0.1'),
            'password' => env('REDIS_PASSWORD'),
            'port'     => env('REDIS_PORT', 6379),
            'database' => env('REDIS_CACHE_DB', 1),
        ],
    ],
    'migrations' => [
        'table' => 'migrations',
        'update_date_on_publish' => true,
    ],
];
