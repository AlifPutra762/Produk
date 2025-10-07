<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use App\Models\Product;

class SaleController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'product_code' => 'required|exists:products,product_code',
            'quantity' => 'required|integer|min:1',
        ]);

        $product = Product::where('product_code', $request->product_code)->first();
        if ($request->quantity > $product->stock) {
            return response()->json(['message' => 'Stok tidak mencukupi.', 'errors' => ['quantity' => ['Stok sisa: ' . $product->stock]]], 422);
        }

        $salesReference = 'INV-' . date('Ymd') . '-' . Str::upper(Str::random(4));
        DB::statement('CALL create_sale_transaction(?, ?, ?)', [$salesReference, $request->product_code, $request->quantity]);

        return response()->json(['success' => true, 'message' => 'Penjualan berhasil!'], 201);
    }
}
