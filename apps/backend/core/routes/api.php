<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\HealthController;
use App\Http\Controllers\Api\UserController;

Route::get('/health',     [HealthController::class, 'check']);
Route::get('/info',       [HealthController::class, 'info']);
Route::get('/redis-demo', [HealthController::class, 'redisDemo']);

Route::apiResource('users', UserController::class);
