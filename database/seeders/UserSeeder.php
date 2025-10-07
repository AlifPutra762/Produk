<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User; // <-- Import model User
use Illuminate\Support\Facades\Hash; // <-- Import Hash

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            'name' => 'Alif Rahmat Yudha Putra',
            'email' => 'alif@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('123456'),
            'remember_token' => \Illuminate\Support\Str::random(10),
        ]);
    }
}
