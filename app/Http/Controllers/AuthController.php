<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth; // <-- Gunakan Auth bawaan Laravel

class AuthController extends Controller
{
    /**
     * Menampilkan halaman/view form login.
     */
    public function showLoginForm()
    {
        return view('auth.login');
    }

    /**
     * Memproses data dari form login secara langsung.
     */
    public function processLogin(Request $request)
    {
        // 1. Validasi input
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required'],
        ]);

        // 2. Coba lakukan login menggunakan Auth bawaan
        if (Auth::attempt($credentials)) {
            // 3. Jika berhasil, buat session baru & redirect ke dashboard
            $request->session()->regenerate();
            return redirect()->intended(route('dashboard'));
        }

        // 4. Jika gagal, kembali ke form login dengan pesan error
        return back()->withErrors([
            'email' => 'Email atau Password yang Anda masukkan salah.',
        ])->onlyInput('email');
    }

    /**
     * Proses logout dari aplikasi web.
     */
    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/login');
    }
}
