<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class UserController extends Controller
{
    public function index(): JsonResponse
    {
        $users = Cache::remember('users:all', 60, fn () => User::latest()->paginate(15));
        return response()->json($users);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name'     => 'required|string|max:255',
            'email'    => 'required|email|unique:users',
            'password' => 'required|string|min:8',
        ]);

        $user = User::create([
            ...$validated,
            'password' => bcrypt($validated['password']),
        ]);

        Cache::forget('users:all');

        return response()->json($user, 201);
    }

    public function show(User $user): JsonResponse
    {
        return response()->json($user);
    }

    public function update(Request $request, User $user): JsonResponse
    {
        $validated = $request->validate([
            'name'  => 'sometimes|string|max:255',
            'email' => 'sometimes|email|unique:users,email,' . $user->id,
        ]);

        $user->update($validated);
        Cache::forget('users:all');

        return response()->json($user);
    }

    public function destroy(User $user): JsonResponse
    {
        $user->delete();
        Cache::forget('users:all');
        return response()->json(['message' => 'User deleted'], 200);
    }
}
