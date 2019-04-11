<?php


    if(isset($_SESSION['zarejestrowany'])){
        unset($_SESSION['zarejestrowany']);
        echo "Zarejestrowano użytkownika: ".$_SESSION['zarejestrowany_imie']." ".$_SESSION['zarejestrowany_nazwisko'];

    }

    else if(!isset($_SESSION['zalogowany'])){
        echo "<b><h1 align=center>Strona Główna</h1></b>";
    }else{

        echo 'Witaj '.$_SESSION['imie'];
        echo "</br>Uprawnienia:";
        echo $_SESSION['uprawnienia'];
    }

?>