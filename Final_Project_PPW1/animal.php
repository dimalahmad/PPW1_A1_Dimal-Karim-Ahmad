<?php
include_once "functions/functions.php";
$animal = getAnimal($_GET["id"]);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title><?=$animal["biota_name"]?></title>
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">
</head>

<body>
  <header id="header" class="fixed-top header-inner-pages">
    <div class="container d-flex align-items-center justify-content-between">

      <h1 class="logo"><a href="./">Deep Sea Adventure</a></h1>
      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto " href="./">Home</a></li>
          <li><a class="nav-link scrollto" href="./#about">About</a></li>
          <li><a class="nav-link scrollto active " href="./#portfolio">Biota</a></li>
          <?php if(isset($_COOKIE["user_id"])):?>
          <li><a class="getstarted scrollto" href="./?logout">Logout</a></li>
          <?php endif;?>
          <li><a class="getstarted scrollto" href="quis/">
            <?php 
            if(isset($_COOKIE["user_id"])){
              echo getName($_COOKIE["user_id"]);
            }else{
              echo "Get Started";
            }
            ?>
          </a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>

    </div>
  </header>

  <main id="main">

    <section id="breadcrumbs" class="breadcrumbs">
      <div class="container">

        <div class="d-flex justify-content-between align-items-center">
          <h2><?=$animal["biota_name"]?></h2>
          <ol>
            <li><a href="./">Home</a></li>
            <li>Biota</li>
            <li><?=$animal["depth_name"]?></li>
            <li><?=$animal["biota_name"]?></li>
          </ol>
        </div>

      </div>
    </section>
    <section id="portfolio-details" class="portfolio-details">
      <div class="container">

        <div class="row gy-4">

          <div class="col-lg-8">
            <div class="portfolio-details-slider swiper">
              <div class="swiper-wrapper align-items-center">

                <div class="swiper-slide">
                  <img src="assets/<?=$animal["image_path"]?>" alt="">
                </div>

              </div>
              <div class="swiper-pagination"></div>
            </div>
          </div>

          <div class="col-lg-4">
            <div class="portfolio-info">
              <h3><?=$animal['biota_name']?></h3>
              <ul>
                <li><strong>Conservation</strong>: <?=$animal["conservation_status"]?></li>
                <li><strong>Zone</strong>: <?=$animal["depth_name"]?></li>
              </ul>
            </div>
            <div class="portfolio-description">
              <h2>About</h2>
              <p>
              <?=$animal["biota_description"]?>
              </p>
            </div>
          </div>

        </div>

      </div>
    </section>

  </main>
  <footer id="footer">
    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong><span>Dimal</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        For PPW Finale Project
      </div>
    </div>
  </footer>

  <div id="preloader"></div>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/js/main.js"></script>

</body>

</html>