<?php

    require_once 'connect.php';
    $polaczenie = new mysqli($host,$db_user,$db_password,$db_name);

    if ($polaczenie->connect_errno!=0){
        //echo "Error: ".$polaczenie->connect_errno." Opis: ".$polaczenie->connect_error;
        if($polaczenie->connect_errno==2002){
            echo "Połączenie z bazą nieudane. Błędna nazwa hosta.";
        }
        else if($polaczenie->connect_errno==1044){
            echo "Połączenie z bazą nieudane. Błędna nazwa użytkownika.";
        }
        else if($polaczenie->connect_errno==1045){
            echo "Połączenie z bazą nieudane. Błędne hasło.";
        }
        else if($polaczenie->connect_errno==1049){
            echo "Połączenie z bazą nieudane. Baza danych nie istnieje.";
        }
    }
    else{
        mysqli_set_charset($polaczenie,"utf8");



        // formularz zmiany danych
        if(isset($_POST['potwierdz'])){

            $poziom = $_POST['poziom'];
            $login = $_POST['login'];

            $sql = "SELECT * FROM uzytkownicy WHERE uzytkownicy.login = '$login'";
            if($rezultat = $polaczenie->query($sql)){
                $liczba_wynikow = $rezultat->num_rows;

                if($liczba_wynikow>0){
                    $wiersz = $rezultat->fetch_assoc();
                    if($wiersz['uprawnienia']==4){
                        $_SESSION['zmiana_uprawnien_admin'] = $login;
                        header ('Location: index.php?strona='.$_GET['strona'].'&page='.$_GET['page'].'');
                        exit();
                    }
                }
            }




            $_SESSION['zmiana_uprawnien_login'] = $login;
            $_SESSION['zmiana_uprawnien_poziom'] = $poziom;



            if($polaczenie->query("
                                UPDATE uzytkownicy
                                SET uprawnienia = '$poziom'
                                WHERE uzytkownicy.login = '$login'")){
                echo "Dane zostały pomyślnie zmienione.";
            }else{
                echo "Błąd kwerendy zmiany danych. ";
            }

            header ('Location: index.php?strona='.$_GET['strona'].'&page='.$_GET['page'].'');


        }
        // normalne wyswietlanie z opcja edycji
        else{


            $sql = "SELECT * FROM uzytkownicy";



            if($rezultat = $polaczenie->query($sql)){
                $liczba_wynikow = $rezultat->num_rows;

                if($liczba_wynikow>0){

                    $reszta=0;
                    while(($liczba_wynikow+$reszta)%10!=0){
                        $reszta++;
                    }
                    $_SESSION['ilosc_stron']=($liczba_wynikow+$reszta)/10;


                    // STRONICOWANIE

                    echo '<table align="center"><tr align="center" padding="10px"><td>Aktualna strona: <strong>'.$_GET['page'].'</strong></td></tr><tr><td>';
                    if(isset($_GET['wyszukaj'])){
                        if($_GET['page']>1){
                            echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page='.($_GET['page']-1).'&wyszukaj='.$_GET['wyszukaj'].'"><-</a>';
                        }else{
                            echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page=1&wyszukaj='.$_GET['wyszukaj'].'"><-</a>';
                        }
                    }else{
                        if($_GET['page']>1){
                            echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page='.($_GET['page']-1).'"><-</a>';
                        }else{
                            echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page=1"><-</a>';
                        }
                    }
                    echo "&nbsp;&nbsp;";

                    for($i=0; $i<$_SESSION['ilosc_stron']; $i++){
                        if(isset($_GET['wyszukaj'])){
                           echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page='.($i+1).'&wyszukaj='.$_GET['wyszukaj'].'">'.($i+1).'</a>';
                        } else{
                           echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page='.($i+1).'">'.($i+1).'</a>';
                        }
                        echo "&nbsp;&nbsp;";
                    }

                    if(isset($_GET['wyszukaj'])){
                        if($_GET['page']<$_SESSION['ilosc_stron']){
                            echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page='.($_GET['page']+1).'&wyszukaj='.$_GET['wyszukaj'].'">-></a>';
                        }else{
                            echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page='.$_SESSION['ilosc_stron'].'&wyszukaj='.$_GET['wyszukaj'].'">-></a>';
                        }
                    }else{
                        if($_GET['page']<$_SESSION['ilosc_stron']){
                            echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page='.($_GET['page']+1).'">-></a>';
                        }else{
                            echo '<a class="stronicowanie" href="?strona='.$_GET['strona'].'&page='.$_SESSION['ilosc_stron'].'">-></a>';
                        }
                    }
                    echo "&nbsp;&nbsp;";
                    echo '</td></tr></table>';
                    echo "</br></br>";

                    if(isset($_SESSION['zmiana_uprawnien_login'])){
                        echo 'Edytowany użytkownik: <b>'.$_SESSION['zmiana_uprawnien_login'].'</b></br>';
                        echo 'Nowe uprawnienia: <b>'.$_SESSION['zmiana_uprawnien_poziom'].'</b></br></br>';
                        unset($_SESSION['zmiana_uprawnien_login']);
                        unset($_SESSION['zmiana_uprawnien_poziom']);
                    }

                    if(isset($_SESSION['zmiana_uprawnien_admin'])){
                        echo 'Próba edycji admina: <b>'.$_SESSION['zmiana_uprawnien_admin'].'</b></br></br>';
                        unset($_SESSION['zmiana_uprawnien_admin']);
                    }


                    if(isset($_GET['page'])){
                        for($i=0; $i<($_GET['page']-1)*10; $i++){
                            $wiersz = $rezultat->fetch_assoc();
                        }

                        echo '<table class="tabela_wynikow"> ';
                        echo '
                            <tr align="center" style="font-weight:bold">
                                <td>Login</td>
                                <td>Imię</td>
                                <td>Nazwisko</td>
                                <td>Poziom</td>
                                <td>Potwierdź</td>

                            </tr>
                            ';
                            $i=0;
                            while(($wiersz = $rezultat->fetch_assoc())&&$i<10){
                            $i++;
                            echo '<form method="POST">
                            <tr>
                                <input type="hidden" name="login" value="'.$wiersz['login'].'" />
                                <td>'.$wiersz['login'].' </td>
                                <td>'.$wiersz['imie'].' </td>
                                <td>'.$wiersz['nazwisko'].' </td>
                                <td><select name="poziom" style="width: 50px;">
                            ';
                                for($j=0;$j<=4;$j++){
                                    if($wiersz['uprawnienia']==$j){
                                        echo'
                                        <option value="'.$j.'" selected>'.$j.'</option>
                                        ';
                                    }else{
                                        echo'
                                        <option value="'.$j.'">'.$j.'</option>
                                        ';
                                    }
                                }


                            echo'
                                </select></td>
                                <td><input type ="submit" name="potwierdz" value="Potwierdź"></form></td>

                            </tr>
                            ';
                        }
                        echo '</table></div>';

                    }
                }

                $rezultat->free_result();
            }
            else{
                echo "Błąd kwerendy.";
            }
        }
    $polaczenie->close();
    }
?>

