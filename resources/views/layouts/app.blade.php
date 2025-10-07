<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aplikasi Penjualan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sidebar {
            width: 280px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #f8f9fa;
            /* Warna background sidebar */
            z-index: 1000;
            /* Pastikan sidebar di lapisan atas */
        }

        .main-content {
            margin-left: 280px;
            /* Beri margin kiri seukuran lebar sidebar */
            padding: 2rem;
        }
    </style>
</head>

<body>
    <div class="d-flex">
        {{-- Sidebar --}}
        <nav class="sidebar border-end p-3">
            <h4 class="fw-bold">Menu Navigasi</h4>
            <hr>
            <ul class="nav flex-column mb-auto">
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('dashboard') }}">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('product.index') }}">Master Produk</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('sales.create') }}">Transaksi Penjualan</a>
                </li>
            </ul>
            <hr>
            <form action="{{ route('logout') }}" method="POST">
                @csrf
                <button type="submit" class="btn btn-danger w-100">Logout</button>
            </form>
        </nav>

        {{-- Konten Utama --}}
        <main class="main-content flex-grow-1">
            @yield('content')
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    @stack('scripts')
</body>

</html>
