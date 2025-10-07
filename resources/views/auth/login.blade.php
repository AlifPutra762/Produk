<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Aplikasi Penjualan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            /* Warna latar belakang cerah */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            /* Pastikan mengambil tinggi viewport penuh */
        }

        .login-card {
            width: 100%;
            max-width: 400px;
            /* Lebar maksimal card */
            padding: 2rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            /* Bayangan lembut */
            border-radius: 0.5rem;
            /* Sudut membulat */
            background-color: #fff;
        }

        .login-card h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #343a40;
            /* Warna teks gelap */
        }
    </style>
</head>

<body>
    <div class="login-card">
        <h2>Login Aplikasi Penjualan</h2>

        @if ($errors->any())
            <div class="alert alert-danger mb-3">
                {{ $errors->first() }}
            </div>
        @endif

        <form method="POST" action="{{ route('login.process') }}">
            @csrf
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" required autofocus>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-lg">Login</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
