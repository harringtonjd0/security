<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="author" content="lean">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="/static/logo.png" type="image/png">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <title>Ghostly Templates</title>
</head>

<body class="bg-dark text-light">
    <nav class="navbar navbar-expand-lg bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="/static/logo.png" alt="Bootstrap">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>
    <div class="container">
        <div class="row mt-5">
            <div class="col">
                <h1>Ghostly Templates!</h1>
                <hr>
                <p>Unleash your inner ghoul with words and eerie artistry</p>
                <p>You conjure the incantations, we supply the spectral data!</p>
            </div>
        </div>
        <div class="row mt-2 mb-5">
            <div class="col">
                <h1>Available template data</h1>
                <hr>
                <ul>
                    <li>{{ .OutFileContents "../flag.txt" }}</li>
                    <li>{{ . }}</li>
                </ul>
            </div>
        </div>
    </div>
    <script src="/static/js/bootstrap.bundle.min.js"></script>
    <script src="/static/js/script.js"></script>
</body>

</html>
