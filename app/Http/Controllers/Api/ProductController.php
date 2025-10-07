<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule; // <-- IMPORT BARU

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // Tentukan jumlah item per halaman, defaultnya 10
        $perPage = $request->input('per_page', 10);

        // Mulai query builder
        $query = Product::query();

        // 1. Logika Filter berdasarkan Nama Produk
        if ($request->has('product_name')) {
            $query->where('product_name', 'like', '%' . $request->product_name . '%');
        }

        // 2. Logika Paginasi
        $products = $query->paginate($perPage);

        // Kembalikan response JSON yang sudah terstruktur oleh paginator
        return response()->json($products);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // DIUBAH: Menyesuaikan aturan validasi dengan skema tabel baru
        $validator = Validator::make($request->all(), [
            'product_code' => 'required|string|max:255|unique:products,product_code',
            'product_name' => 'required|string|max:255',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $product = Product::create($validator->validated());

        return response()->json([
            'success' => true,
            'message' => 'Product created successfully',
            'data' => $product
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Product $product)
    {
        return response()->json([
            'success' => true,
            'data' => $product
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Product $product)
    {
        // DIUBAH: Menyesuaikan aturan validasi dengan skema tabel baru
        $validator = Validator::make($request->all(), [
            'product_code' => [
                'sometimes',
                'required',
                'string',
                Rule::unique('products')->ignore($product->id), // Unik, tapi abaikan produk ini
            ],
            'product_name' => 'sometimes|required|string|max:255',
            'price' => 'sometimes|required|numeric|min:0',
            'stock' => 'sometimes|required|integer|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $product->update($validator->validated());

        return response()->json([
            'success' => true,
            'message' => 'Product updated successfully',
            'data' => $product
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product)
    {
        $product->delete();

        return response()->json([
            'success' => true,
            'message' => 'Product deleted successfully'
        ], 200);
    }
}
