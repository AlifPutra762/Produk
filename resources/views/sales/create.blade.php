@extends('layouts.app')

@section('content')
    <div class="container">
        <h1 class="mb-4">Buat Transaksi Penjualan Baru</h1>

        {{-- Menampilkan pesan sukses --}}
        @if (session('success'))
            <div class="alert alert-success">{{ session('success') }}</div>
        @endif

        {{-- Menampilkan pesan error validasi --}}
        @if ($errors->any())
            <div class="alert alert-danger">
                <ul class="mb-0">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        {{-- Form Penjualan --}}
        <form action="{{ route('sales.store') }}" method="POST">
            @csrf
            <div class="mb-3">
                <label for="product" class="form-label">Pilih Produk:</label>
                <select name="product_code" id="product" class="form-select" required>
                    <option value="" disabled selected>-- Pilih Produk --</option>
                    @foreach ($products as $product)
                        <option value="{{ $product['product_code'] }}" data-price="{{ $product['price'] }}"
                            data-stock="{{ $product['stock'] }}">
                            {{ $product['product_name'] }} (Stok: {{ $product['stock'] }})
                        </option>
                    @endforeach
                </select>
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label for="quantity" class="form-label">Quantity:</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" min="1" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="price" class="form-label">Harga Satuan (Rp):</label>
                    <input type="number" id="price" name="price" class="form-control" readonly>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="subtotal" class="form-label">Subtotal:</label>
                    <input type="text" id="subtotal" name="subtotal" class="form-control" readonly>
                </div>
            </div>

            <button type="submit" id="saveButton" class="btn btn-primary">Simpan Transaksi</button>
        </form>
    </div>
@endsection {{-- <-- PENAMBAHAN KRUSIAL ADA DI SINI --}}

@push('scripts')
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const productSelect = document.getElementById('product');
            const quantityInput = document.getElementById('quantity');
            const priceInput = document.getElementById('price');
            const subtotalInput = document.getElementById('subtotal');

            function calculateSubtotal() {
                const price = parseFloat(priceInput.value) || 0;
                const quantity = parseInt(quantityInput.value) || 0;
                const subtotal = price * quantity;

                // Format sebagai Rupiah untuk ditampilkan
                subtotalInput.value = new Intl.NumberFormat('id-ID', {
                    style: 'currency',
                    currency: 'IDR',
                    minimumFractionDigits: 0
                }).format(subtotal);
            }

            productSelect.addEventListener('change', function() {
                const selectedOption = this.options[this.selectedIndex];
                const price = selectedOption.getAttribute('data-price') || '0';
                const stock = selectedOption.getAttribute('data-stock') || '0';

                priceInput.value = price;
                quantityInput.max = stock; // Set max quantity sesuai stok
                quantityInput.value = 1; // Reset quantity ke 1 saat produk diganti
                calculateSubtotal();
            });

            quantityInput.addEventListener('input', calculateSubtotal);
        });
    </script>
@endpush
