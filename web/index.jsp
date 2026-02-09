<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login | Financial System</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="style/image/favicon.ico">

<style>
    body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background-color: #f4f6f9;
        height: 100vh;
    }

    /* Top Navigation */
    .top-bar {
        background-color: #d32f2f;
        height: 60px;
        display: flex;
        align-items: center;
        padding: 0 30px;
        color: #fff;
        font-weight: bold;
        font-size: 20px;
        letter-spacing: 0.5px;
    }

    /* Login Container */
    .login-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        height: calc(100vh - 60px);
    }

    .login-card {
        background: #fff;
        width: 360px;
        padding: 30px;
        border-radius: 6px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    }

    .login-card h2 {
        margin: 0 0 20px;
        text-align: center;
        color: #333;
        font-weight: 600;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        margin-bottom: 6px;
        font-size: 14px;
        color: #555;
    }

    .form-group input {
        width: 94%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    .form-group input:focus {
        outline: none;
        border-color: #d32f2f;
    }

    .login-btn {
        width: 100%;
        background-color: #d32f2f;
        color: #fff;
        border: none;
        padding: 11px;
        font-size: 15px;
        border-radius: 4px;
        cursor: pointer;
        font-weight: 600;
    }

    .login-btn:hover {
        background-color: #b71c1c;
    }

    .footer-text {
        margin-top: 15px;
        text-align: center;
        font-size: 12px;
        color: #777;
    }
</style>
</head>

<body>

<div class="top-bar">
    <img src="style/image/MLLOGOWHITE.png" class="logo logo-display" alt="" style="width: 175px;">
</div>

<div class="login-wrapper">
    <div class="login-card">
        <h2>Enhanced <span style="color:#d32f2f;">MLmatic</span> System</h2>

        <form method="POST" action="login_creds" id="login_form">

            <div class="form-group">
                <label>Username</label>
                <input 
                    type="text" 
                    name="username" 
                    placeholder="Enter username" 
                    required
                >
            </div>

            <div class="form-group">
                <label>Password</label>
                <input 
                    type="password" 
                    name="password" 
                    placeholder="Enter password" 
                    required >
            </div>

            <button class="login-btn" type="submit">
                LOGIN
            </button>

        </form>

        <div class="footer-text">
            © M. Lhuillier Financial Services, Inc.
        </div>
    </div>
</div>

</body>
</html>
