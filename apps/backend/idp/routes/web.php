<?php

use Illuminate\Support\Facades\Route;

Route::get('/', fn () => response()->json(['message' => 'Backend App 1 — use /api prefix']));
