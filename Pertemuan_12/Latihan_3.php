<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Komentar pada PHP</title>
</head>
<body>
    <?php
        // This is a single-line comment

        # This is also a singke-line comment

        /* This is a multiple-lines comment block
        that spans over multiple- lines
        */

        // You can also use comment is leave out parts of a code line
        $x= 5 /* + 15 */ + 5;
        echo $x;
    ?>
</body>
</html>