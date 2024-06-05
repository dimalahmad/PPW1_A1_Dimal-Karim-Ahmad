<?php
$daftar_mahasiswa = array(
    array("Nama" => "John", "Jurusan" => "Teknik Informatika", "Angkatan" => 2019),
    array("Nama" => "Jane", "Jurusan" => "Manajemen", "Angkatan" => 2020),
    array("Nama" => "Doe", "Jurusan" => "Akuntansi", "Angkatan" => 2018),
    array("Nama" => "Adam", "Jurusan" => "Teknik Sipil", "Angkatan" => 2021),
    array("Nama" => "Eve", "Jurusan" => "Psikologi", "Angkatan" => 2017)
);

foreach ($daftar_mahasiswa as $mahasiswa) {
    echo "Nama: ".$mahasiswa['Nama']."<br>";
    echo "Jurusan: ".$mahasiswa['Jurusan']."<br>";
    echo "Angkatan: ".$mahasiswa['Angkatan']."<br><br>";
}
?>
