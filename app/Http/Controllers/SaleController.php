<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product; // Gunakan Model Product
use Illuminate\Support\Facades\DB; // Gunakan DB facade
use Illuminate\Support\Str;

class SaleController extends Controller
{
    /**
     * Menampilkan form penjualan.
     */
    public function create()
    {
        // Ambil data produk langsung dari database untuk dropdown
        $products = Product::where('stock', '>', 0)->orderBy('product_name')->get();

        return view('sales.create', ['products' => $products]);
    }

    /**
     * Menyimpan data penjualan langsung ke database.
     */
    public function store(Request $request)
    {
        // 1. Validasi input
        $request->validate([
            'product_code' => 'required|exists:products,product_code',
            'quantity' => 'required|integer|min:1',
        ]);

        // 2. Validasi stok secara manual sebelum panggil procedure
        $product = Product::where('product_code', $request->product_code)->first();
        if ($request->quantity > $product->stock) {
            return back()->withErrors(['quantity' => 'Stok tidak mencukupi. Sisa stok: ' . $product->stock])->withInput();
        }

        // 3. Buat referensi penjualan unik
        $salesReference = 'INV-' . date('Ymd') . '-' . Str::upper(Str::random(4));

        // 4. Panggil Stored Procedure secara langsung
        DB::statement('CALL create_sale_transaction(?, ?, ?)', [
            $salesReference,
            $request->product_code,
            $request->quantity
        ]);

        // 5. Redirect dengan pesan sukses
        return redirect()->route('sales.create')->with('success', 'Penjualan berhasil disimpan!');
    }
}
