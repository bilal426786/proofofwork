<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redis;

class HealthController extends Controller
{
    public function check(): JsonResponse
    {
        $dbStatus  = 'ok';
        $redisStatus = 'ok';

        try {
            DB::connection()->getPdo();
        } catch (\Exception $e) {
            $dbStatus = 'unavailable: ' . $e->getMessage();
        }

        try {
            Cache::put('health_check', true, 10);
            Cache::get('health_check');
        } catch (\Exception $e) {
            $redisStatus = 'unavailable: ' . $e->getMessage();
        }

        return response()->json([
            'status'   => 'ok',
            'app'      => config('app.name'),
            'version'  => app()->version(),
            'database' => $dbStatus,
            'redis'    => $redisStatus,
            'cache'    => config('cache.default'),
            'session'  => config('session.driver'),
            'queue'    => config('queue.default'),
            'time'     => now()->toIso8601String(),
        ]);
    }

    public function info(): JsonResponse
    {
        return response()->json([
            'app'         => config('app.name'),
            'env'         => config('app.env'),
            'php_version' => PHP_VERSION,
            'laravel'     => app()->version(),
            'redis_host'  => config('database.redis.default.host'),
            'cache_driver'=> config('cache.default'),
        ]);
    }

    public function redisDemo(): JsonResponse
    {
        $key   = 'demo:counter:app2';
        $count = Cache::increment($key);

        Cache::put('demo:last_visit:app2', now()->toIso8601String(), 3600);

        return response()->json([
            'message'    => 'Redis is working!',
            'counter'    => $count,
            'last_visit' => Cache::get('demo:last_visit:app2'),
            'cache_ttl'  => '1 hour',
        ]);
    }
}
