<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index()
    {
        // Panggil stored procedure get_top_product
        $topProducts = DB::select('CALL get_top_product()');

        // Kirim data ke view
        return view('dashboard', ['topProducts' => $topProducts]);
    }
}
