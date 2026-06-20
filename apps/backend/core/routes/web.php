<?php

use Illuminate\Support\Facades\Route;

Route::get('/', fn () => response()->json(['message' => 'Backend App 2 — use /api prefix']));
