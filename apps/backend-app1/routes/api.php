<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\HealthController;
use App\Http\Controllers\Api\UserController;

Route::get('/health', [HealthController::class, 'check']);
Route::get('/info', [HealthController::class, 'info']);

Route::apiResource('users', UserController::class);
