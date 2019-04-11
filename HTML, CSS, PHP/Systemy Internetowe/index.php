<!DOCTYPE HTML>
<html lang="pl">
<head>
    <title>tytulik</title>
    <meta charset="utf-8" />
    <meta name="Description" content= "zaliczonko" />
    <link href="./style.css" rel="stylesheet" type="text/css" />



</head>
<body>

    <?php
        session_start();

        if(!isset($_SESSION['zalogowany'])){
            $_SESSION['uprawnienia'] = 0;
        }
        if(isset($_GET['wyloguj'])){
            unset($_SESSION['zalogowany']);
            $_SESSION['uprawnienia'] = 0;
        }


        if(!isset($_GET['strona'])){
            $_GET['strona']=1;
        }

        $_SESSION['wszystko_OK']=false;


        if(!isset($_SESSION['dodanych_pracownikow'])){
            $_SESSION['dodanych_pracownikow']=0;
        }

        if(isset($_GET['wyszukaj'])){
            $_SESSION['wyszukaj'] = $_GET['wyszukaj'];
            $_GET['strona']=4;
        }






    ?>



    <div id="container">

        <div id="header">
            <b>LOGO</b>
        </div>


            <div id="menu_left">

                <?php

                    if($_SESSION['uprawnienia']>=0){
                        echo'
                            <a class="link" href="index.php"><div class="box">Strona główna</div></a>
                        ';

                        if($_SESSION['uprawnienia']>=1){
                            echo'
                                <a class="link" href="index.php?strona=2"><div class="box">Formularz</div></a>
                                <a class="link" href="index.php?strona=3"><div class="box">Zawartość sesji</div></a>
                                <a class="link" href="index.php?strona=4&page=1"><div class="box">Baza pracowników</div></a>
                            ';
                            if($_SESSION['uprawnienia']>=2){
                                echo'
                                    <a class="link" href="index.php?strona=5&page=1"><div class="box">Edycja pracownika</div></a>
                                ';

                                if($_SESSION['uprawnienia']>=3){
                                    echo'
                                        <a class="link" href="index.php?strona=6&page=1"><div class="box">Usunięcie pracownika</div></a>
                                    ';
                                }
                            }

                            echo'
                                </br></br>
                                <a class="link" href="index.php?strona=9"><div class="box">Zmień dane</div></a>
                            ';

                            if($_SESSION['uprawnienia']>=4){
                                echo'
                                    <a class="link" href="index.php?strona=10&page=1"><div class="box">Zmień poziom dostępu</div></a>
                                    <a class="link" href="index.php?strona=11&page=1"><div class="box">Usuń użytkownika</div></a>
                                ';
                            }

                        }
                    }
                ?>

            </div>

            <div id="content">


            <?php
            switch ($_GET['strona']) {
                case 1:
                    require 'glowna.php';
                    break;
                case 2:
                    require 'formularz.php';
                    break;
                case 3:
                    require 'zawartosc_sesji.php';
                    break;
                case 4:
                    require 'baza_pracownikow.php';
                    break;
                case 5:
                    require 'edycja_pracownika.php';
                    break;
                case 6:
                    require 'usuniecie_pracownika.php';
                    break;
                case 7:
                    require 'zaloguj.php';
                    break;
                case 8:
                    require 'zarejestruj.php';
                    break;
                case 9:
                    require 'zmien_dane.php';
                    break;
                case 10:
                    require 'zmien_poziom_dostepu.php';
                    break;
                case 11:
                    require 'usun_uzytkownika.php';
                    break;
            }
            ?>




            </div>

            <div id="menu_right">
                <?php
                    if($_SESSION['uprawnienia']>0){
                    echo'
                        <form method="GET" style="padding:10px">
                            <input type="text" name="wyszukaj"></br>
                            <input type="submit" name="search_button" value="Wyszukaj">
                        </form>
                    ';
                    }

                    echo'
                        </br>
                    ';
                        if(isset($_SESSION['zalogowany'])){
                            echo'<a style="margin-left:10px;" href="index.php?wyloguj">Wyloguj</a></br>';
                        }else{
                            echo'<a style="margin-left:10px;" href="index.php?strona=7">Zaloguj</a></br>';
                        }
                        echo'</br>
                        <a style="margin-left:10px;" href="index.php?strona=8">Zarejestruj</a>
                    ';

                ?>
            </div>

        <div id="footer">
            <?php

                if($_SESSION['dodanych_pracownikow'] == 0){
                    echo "Stopka";
                }else{
                    echo "Liczba dodanych pracowników: ".$_SESSION['dodanych_pracownikow'];
                }
            ?>
        </div>

    </div>
</body>
</html>