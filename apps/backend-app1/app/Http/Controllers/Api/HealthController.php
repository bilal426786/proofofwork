<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;

class HealthController extends Controller
{
    public function check(): JsonResponse
    {
        $dbStatus = 'ok';
        try {
            DB::connection()->getPdo();
        } catch (\Exception $e) {
            $dbStatus = 'unavailable: ' . $e->getMessage();
        }

        return response()->json([
            'status'  => 'ok',
            'app'     => 'Backend App 1',
            'version' => app()->version(),
            'database'=> $dbStatus,
            'time'    => now()->toIso8601String(),
        ]);
    }

    public function info(): JsonResponse
    {
        return response()->json([
            'app'         => config('app.name'),
            'env'         => config('app.env'),
            'php_version' => PHP_VERSION,
            'laravel'     => app()->version(),
        ]);
    }
}
