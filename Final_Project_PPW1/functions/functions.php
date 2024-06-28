<?php
include_once "conn.php";
function getDepths(){
    global $mysql;
    $allData = [];
    $query = "SELECT * FROM depth_zones";
    $res = mysqli_query($mysql,$query);
    while($row=mysqli_fetch_assoc($res)){
        $allData[] = $row;
    }
    return $allData;
}
function getQuizes($id){
    global $mysql;
    $allData = [];
    $query = "SELECT * FROM quizzes WHERE depth_zone_id='$id'";
    $res = mysqli_query($mysql,$query);
    while($row=mysqli_fetch_assoc($res)){
        $allData[] = $row;
    }
    return $allData;
}
function getAnswers($id){
    global $mysql;
    $allData = [];
    $query = "SELECT * FROM quiz_options WHERE quiz_id='$id' ORDER BY option_text";
    $res = mysqli_query($mysql,$query);
    while($row=mysqli_fetch_assoc($res)){
        $allData[] = $row;
    }
    return $allData;
}
function getPlayers(){
    global $mysql;
    $allData = [];
    $query = "SELECT * FROM users ORDER BY user_progress DESC LIMIT 10";
    $res = mysqli_query($mysql,$query);
    while($row=mysqli_fetch_assoc($res)){
        $allData[] = $row;
    }
    return $allData;
}
function getAnimals(){
    global $mysql;
    $allData = [];
    $query = "SELECT m.*,d.depth_zone_name AS depth_name FROM marine_biota m JOIN depth_zones d ON m.depth_zone_id=d.depth_zone_id";
    $res = mysqli_query($mysql,$query);
    while($row=mysqli_fetch_assoc($res)){
        $allData[] = $row;
    }
    return $allData;
}
function getAnimal($id){
    global $mysql;
    $allData = [];
    $query = "SELECT m.*,d.depth_zone_name AS depth_name FROM marine_biota m JOIN depth_zones d ON m.depth_zone_id=d.depth_zone_id AND m.biota_id='$id'";
    $res = mysqli_query($mysql,$query);
    while($row=mysqli_fetch_assoc($res)){
        $allData[] = $row;
    }
    return $allData[0];
}
function getAnimalAt($id){
    global $mysql;
    $allData = [];
    $id += 1;
    $randomNumber = rand(0, 4);
    $query = "SELECT * FROM marine_biota WHERE depth_zone_id='$id'";
    $res = mysqli_query($mysql,$query);
    while($row=mysqli_fetch_assoc($res)){
        $allData[] = $row;
    }
    return $allData[$randomNumber];
}
function addUser($data){
    global $mysql;
    $uname = $data["username"];
    $email = $data["email"];
    $query = "INSERT INTO users (username,user_email) VALUES ('$uname','$email')";
    try{
        mysqli_query($mysql,$query);
        return $uname;
    }catch(Exception $e){
        return false;
    }
}
function saveScore($id,$score,$user){
    global $mysql;
    $query = "INSERT INTO user_quiz_scores (user_id,quiz_id,quiz_score) VALUES ('$user','$id','$score') ON DUPLICATE KEY UPDATE quiz_score='$score'";
    try{
        mysqli_query($mysql,$query);
    }catch(Exception $e){
    }
}
function login($data){
    global $mysql;
    $uname = $data["username"];
    $email = $data["email"];
    $query = "SELECT user_id FROM users WHERE username='$uname' AND user_email='$email'";
    $res = mysqli_query($mysql,$query);
    if(mysqli_num_rows($res)==1){
        return mysqli_fetch_assoc($res)["user_id"];
    }else{
        return false;
    }
}
function getName($data){
    global $mysql;
    $query = "SELECT username FROM users WHERE user_id='$data'";
    $res = mysqli_query($mysql,$query);
    if(mysqli_num_rows($res)==1){
        return mysqli_fetch_assoc($res)["username"];
    }else{
        return false;
    }
}