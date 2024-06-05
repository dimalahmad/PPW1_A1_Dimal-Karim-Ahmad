<?php
$data = array("apel", "jeruk", "nanas", "pisang", "anggur", "melon", "semangka", "mangga");

foreach ($data as $buah) {
    if ($buah == "nanas" || $buah == "anggur") {
        echo "Saya suka ".$buah."!<br>";
    } else {
        echo "Saya suka buah ".$buah."<br>";
    }
}
?>
