<?php 
include_once "functions/functions.php";
if(isset($_GET["logout"])){
  setcookie("user_id","",time()-10,"/");
  header("Location: index.php");
}
$depths = getDepths();
$players = getPlayers();
$animals = getAnimals();
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Ocean Deep</title>
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
  <header id="header" class="fixed-top ">
    <div class="container d-flex align-items-center justify-content-between">

      <h1 class="logo"><a href="./">Deep Sea Adventure</a></h1>
      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto active" href="#hero">Home</a></li>
          <li><a class="nav-link scrollto" href="#about">About</a></li>
          <li><a class="nav-link scrollto " href="#portfolio">Biota</a></li>
          <?php if(isset($_COOKIE["user_id"])):?>
          <li><a class="getstarted scrollto" href="./?logout">Logout</a></li>
          <?php endif;?>
          <li><a class="getstarted scrollto" href="ocean/">
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
  <section id="hero">
    <div class="hero-container" data-aos="fade-up">
      <h1>Explore the Deep Sea Now!</h1>
      <h2>We can help you learn about the deep sea</h2>
      <div class="d-flex">
        <a href="#about" class="btn-get-started scrollto">Start</a>
        <a href="https://youtu.be/PaErPyEnDvk?si=6JrmYhpU0WGnpSSM" class="glightbox btn-watch-video"><i class="bi bi-play-circle"></i><span>Watch Video</span></a>
      </div>
    </div>
  </section>
  <main id="main">
    <section id="about" class="about">
      <div class="container" data-aos="fade-up">
        <div class="row">

          <div class="col-lg-6 video-box align-self-baseline" data-aos="zoom-in" data-aos-delay="100">
            <img src="assets/img/about.jpg" class="img-fluid" alt="">
            <a href="https://www.youtube.com/watch?v=p0G68ORc8uQ" class="glightbox play-btn mb-4"></a>
          </div>

          <div class="col-lg-6 pt-3 pt-lg-0 content">
            <h3>Discover the Deep Sea</h3>
            <p>
              The deep sea is a fascinating and mysterious part of our planet. It covers about 71% of the Earth's surface and contains some of the most unique and diverse ecosystems known to man.
            </p>
            <ul>
              <li><i class="ri-check-double-line"></i> Home to countless species of marine life</li>
              <li><i class="ri-check-double-line"></i> Contains the world's largest mountain range, the Mid-Ocean Ridge</li>
              <li><i class="ri-check-double-line"></i> Unexplored depths hold many secrets</li>
            </ul>
            <p>
              From the Mariana Trench, the deepest part of the world's oceans, to the vibrant coral reefs, the deep sea is full of wonders waiting to be discovered. Join us on an adventure to explore these mysterious waters and learn about the incredible creatures and environments found within.
            </p>
            <a href="#map" class="btn-learn-more">Learn More</a>
          </div>
        </div>
      </div>
    </section>
    <section id="map" class="map">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Choose Your Ocean</h2>
          <p>Select the ocean you want to explore</p>
        </div>

        <div class="row">
          <?php foreach($depths as $depth):?>
          <div class="col-lg-6 mt-lg-2">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="100">
              <i class="bi bi-globe2"></i>
              <h4><a href=""><?= $depth["depth_zone_name"]?> (<?= $depth["min_depth"]?>-<?= $depth["max_depth"]?>)</a></h4>
              <p><?= $depth["depth_zone_description"]?></p>
            </div>
          </div>
          <?php endforeach;?>

        </div>

      </div>
    </section>
    <section id="ranking" class="ranking">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Player Ranking</h2>
          <p>Check out the top performers in our quizzes</p>
        </div>

        <div class="row">
          <div class="col-lg-12">
            <ul class="list-group">
              <?php foreach($players as $player):?>
              <li class="list-group-item d-flex justify-content-between align-items-center">
                <?=$player["username"]?>
                <span class="badge bg-primary rounded-pill"><?=intval($player["user_progress"]*100)?>%</span>
              </li>
              <?php endforeach;?>
            </ul>
          </div>
        </div>

      </div>
    </section>
    <section id="testimonials" class="testimonials">
      <div class="container" data-aos="zoom-in">

        <div class="testimonials-slider swiper" data-aos="fade-up" data-aos-delay="100">
          <div class="swiper-wrapper">

            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="assets/img/testimonials/testimonials-1.jpg" class="testimonial-img" alt="">
                <h3>Ferdinand Magellan</h3>
                <h4>Explorer, Navigator</h4>
                <p>
                  <i class="bx bxs-quote-alt-left quote-icon-left"></i>
                  The deep sea is a vast, uncharted territory full of mysteries and potential discoveries. It is the ultimate frontier for exploration and understanding our planet.
                  <i class="bx bxs-quote-alt-right quote-icon-right"></i>
                </p>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="assets/img/testimonials/testimonials-2.jpg" class="testimonial-img" alt="">
                <h3>Zheng He</h3>
                <h4>Oceanographer, Filmmaker, Explorer</h4>
                <p>
                  <i class="bx bxs-quote-alt-left quote-icon-left"></i>
                  The deep sea is a realm of unparalleled beauty and complexity. It is our responsibility to explore and protect this fragile environment for future generations.
                  <i class="bx bxs-quote-alt-right quote-icon-right"></i>
                </p>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="assets/img/testimonials/testimonials-3.jpg" class="testimonial-img" alt="">
                <h3>Jena Karlis</h3>
                <h4>Oceanographer, Explorer</h4>
                <p>
                  <i class="bx bxs-quote-alt-left quote-icon-left"></i>
                  The deep sea is the final frontier of our planet. It holds countless secrets and treasures, waiting to be discovered by those brave enough to venture into its depths.
                  <i class="bx bxs-quote-alt-right quote-icon-right"></i>
                </p>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="assets/img/testimonials/testimonials-4.jpg" class="testimonial-img" alt="">
                <h3>James Cook</h3>
                <h4>Explorer, Navigator, Cartographer</h4>
                <p>
                  <i class="bx bxs-quote-alt-left quote-icon-left"></i>
                  The deep sea is an area of endless intrigue and potential. Each voyage into its depths reveals new wonders and challenges our understanding of the natural world.
                  <i class="bx bxs-quote-alt-right quote-icon-right"></i>
                </p>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="assets/img/testimonials/testimonials-5.jpg" class="testimonial-img" alt="">
                <h3> Jacques Cousteau</h3>
                <h4>Admiral, Explorer</h4>
                <p>
                  <i class="bx bxs-quote-alt-left quote-icon-left"></i>
                  The deep sea represents the boundless possibilities of exploration and trade. It is a testament to human ingenuity and the spirit of adventure.
                  <i class="bx bxs-quote-alt-right quote-icon-right"></i>
                </p>
              </div>
            </div>
          <div class="swiper-pagination"></div>
        </div>

      </div>
    </section>
    <section id="portfolio" class="portfolio">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Biota</h2>
          <p>Check our Biota's Information</p>
        </div>

        <div class="row portfolio-container" data-aos="fade-up" data-aos-delay="200">
          <?php foreach($animals as $animal):?>
          <div class="col-lg-4 col-md-6 portfolio-item filter-app">
            <img src="assets/<?=$animal['image_path']?>" class="img-fluid" alt="">
            <div class="portfolio-info">
              <h4><?=$animal["biota_name"]?></h4>
              <p><?=$animal["depth_name"]?></p>
              <a href="assets/<?=$animal['image_path']?>" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="<?=$animal["biota_name"]?>"><i class="bx bx-plus"></i></a>
              <a href="animal.php?id=<?=$animal["biota_id"]?>" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>
          <?php endforeach;?>
        </div>

      </div>
    </section>
    <section id="facts" class="facts">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Interesting Facts</h2>
          <p>Did you know?</p>
        </div>

        <div class="row">
          <div class="col-lg-4 col-md-6">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="100">
              <i class="bi bi-info-circle"></i>
              <h4>Mariana Trench</h4>
              <p>The Mariana Trench is the deepest part of the world's oceans, reaching a depth of about 36,000 feet (11,000 meters).</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 mt-4 mt-md-0">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="200">
              <i class="bi bi-info-circle"></i>
              <h4>Bioluminescence</h4>
              <p>Many deep-sea creatures produce their own light through a process called bioluminescence, which helps them survive in the dark depths.</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 mt-4 mt-lg-0">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="300">
              <i class="bi bi-info-circle"></i>
              <h4>Giant Squid</h4>
              <p>The giant squid, one of the most elusive creatures of the deep sea, can grow up to 43 feet (13 meters) in length.</p>
            </div>
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