<?php
include_once "functions/functions.php";
if(isset($_POST["username"])){
    $userId = login($_POST);
    if($userId!=false){
        setcookie("user_id",$userId,time()+3600,"/");
        header("Location: ./ocean");
    }else{
        header("Location: login.php?fail");
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Login</title>
   <link rel="stylesheet" href="./assets/css/login.css">
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
   
<div class="form-container">

   <form action="" method="post">
      <h3>Login now</h3>
      <input type="text" name="username" required placeholder="Username">
      <input type="email" name="email" required placeholder="Email">
      <input type="submit" name="submit" value="Login" class="form-btn">
      <p>don't have an account? <a href="register.php">register now</a></p>
   </form>

</div>

</body>
</html>
<?php 
if(isset($_GET["fail"])){
    echo '<script>
Swal.fire({
  title: "Failed",
  text: "Email or username is invalid",
  icon: "error"
});
    </script>';
}
?>