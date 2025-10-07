@extends('layouts.app')

@section('content')
    <div class="container">
        <h1 class="mb-4">Dashboard</h1>

        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">Top 5 Produk Terlaris</h5>
            </div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Nama Produk</th>
                            <th scope="col">Total Penjualan</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($topProducts as $index => $product)
                            <tr>
                                <th scope="row">{{ $index + 1 }}</th>
                                <td>{{ $product->product_name }}</td>
                                <td>{{ $product->total_sales }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="3" class="text-center">Belum ada data penjualan.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
@endsection
