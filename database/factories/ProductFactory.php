<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // Daftar nama produk khas Indonesia
        $productNames = [
            'Beras Pandan Wangi Cianjur',
            'Gula Merah Kelapa Asli',
            'Kopi Robusta Lampung',
            'Teh Melati Pilihan',
            'Minyak Goreng Sawit Premium',
            'Sambal Bawang Pedas',
            'Kerupuk Udang Sidoarjo',
            'Kecap Manis No. 1',
            'Indomie Goreng Spesial',
            'Sandal Jepit Swallow',
            'Batik Pekalongan Tulis',
            'Sarung Tenun Gajah Duduk',
            'Buku Tulis Sinar Dunia',
            'Pensil 2B Faber-Castell',
            'Sabun Mandi Lifebuoy'
        ];

        // Daftar harga sesuai nominal uang kertas (dan kelipatannya)
        $prices = [
            2000,
            5000,
            10000,
            20000,
            50000,
            75000,
            100000,
            150000,
            200000,
            250000,
            300000,
            500000
        ];

        return [
            'product_code' => 'PROD-' . fake()->unique()->numerify('####'),

            // Memilih nama produk secara acak dari daftar
            'product_name' => fake()->randomElement($productNames),

            // Memilih harga secara acak dari daftar nominal uang
            'price' => fake()->randomElement($prices),

            // Stok acak antara 10 sampai 300
            'stock' => fake()->numberBetween(10, 300),
        ];
    }
}
