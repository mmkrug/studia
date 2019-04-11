<!DOCTYPE HTML>
<html lang="pl">
<head>
    <meta charset="utf-8" />
</head>


<body>


<?php

    $first = $_POST['a'];
    $second = $_POST['b'];
    $suma = $first+$second;

echo<<<END
    NO SIEMA;
    <table border="1" cellpadding="10" cellspacing="0">
    <tr>
        <td>a=$first</td><td>b=$second</td>
    </tr>
    <tr>
        <td>suma</td><td>$suma</td>
    </tr>
    </table>

END;
?>


<a href="index.php">Powrót</a>
</body>
</html>