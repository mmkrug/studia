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
        if(isset($_GET['id'])){
            $id = $_GET['id'];

            if(isset($_POST['odrzuc_zmiany'])){
                header ('Location: index.php?strona='.$_GET['strona'].'');
            }

            if(isset($_POST['imie'])){
                $_SESSION['wszystko_OK'] = true;

                $imie = $_POST['imie'];
                if((strlen($imie)<3) || (strlen($imie)>20)){
                    $_SESSION['wszystko_OK'] = false;
                    $_SESSION['e_imie'] = "Imię musi posiadać od 3 do 20 znaków.";
                }

                $nazwisko = $_POST['nazwisko'];
                if((strlen($nazwisko)<3) || (strlen($nazwisko)>20)){
                    $_SESSION['wszystko_OK'] = false;
                    $_SESSION['e_nazwisko'] = "Nazwisko musi posiadać od 3 do 20 znaków.";
                }

                if(isset($_POST['plec'])){
                    $plec = $_POST['plec'];
                }
                if(!isset($_POST['plec'])){
                    $_SESSION['wszystko_OK'] = false;
                    $_SESSION['e_plec'] = "Należy wybrać płeć.";
                }

                $nazwisko_panienskie = $_POST['nazwisko_panienskie'];
                if((strlen($nazwisko_panienskie)<3) || (strlen($nazwisko_panienskie)>20)){
                    $_SESSION['wszystko_OK'] = false;
                    $_SESSION['e_nazwisko_panienskie'] = "Nazwisko panieńskie musi posiadać od 3 do 20 znaków.";
                }

                //https://regex101.com/r/PZh6yf/5
                $email = $_POST['email'];
                $regex = '/^[a-z0-9]+([\.\-\_][a-z0-9]+)*@[a-z0-9]+\.[_a-z-]{2,}/';
                if(!preg_match($regex,$email)) {
                    $_SESSION['wszystko_OK'] = false;
                    $_SESSION['e_email'] = "Nieprawidłowy e-mail.";
                }

                $kod_pocztowy = $_POST['kod_pocztowy'];
                $regex = '/^[0-9]{2}\-[0-9]{3}/';
                if(!preg_match($regex,$kod_pocztowy)) {
                    $_SESSION['wszystko_OK'] = false;
                    $_SESSION['e_kod_pocztowy'] = "Nieprawidłowy kod pocztowy.";
                }

            }

            // formularz wyslany, wszystko ok, update danych
            if((isset($_SESSION['wszystko_OK'])) && ($_SESSION['wszystko_OK']==true)){

                $_SESSION['wszystko_OK']=false;

                if($polaczenie->query("
                                    UPDATE pracownicy
                                    SET imie = '$imie',
                                        email = '$email',
                                        nazwisko_panienskie = '$nazwisko_panienskie',
                                        email = '$email',
                                        plec = '$plec',
                                        kod_pocztowy = '$kod_pocztowy'
                                    WHERE pracownicy.id = '$id'")){
                    echo "Dane zostały pomyślnie zmienione.";
                }else{
                    echo "Błąd kwerendy zmiany danych. ";
                }

                header ('Location: index.php?strona='.$_GET['strona'].'&page='.$_GET['page'].'');
            }
            else{
                //pobranie danych osobowych rekordu o danym id.

                // wyszukanie pracownika
                if($rezultat = $polaczenie->query("SELECT * FROM pracownicy where id=".$_GET['id']."")){
                    //echo "ZNALEZIONO CZYJESC ID";
                }else{
                    echo "Błąd kwerendy edycji praownika o danym id";
                }

                //$rezultat = $polaczenie->query($sql)
                $wiersz = $rezultat->fetch_assoc();
                echo '

                <form method="POST">
                    <table>

                        <tr>
                            <td>Imie:</td>
                            <td><input type="text" name="imie" value="'.$wiersz['imie'].'"></td>
                        </tr>
                        <tr><td align=center colspan=2>
                ';
                                 if (isset($_SESSION['e_imie'])){
                                     echo '<div class="error">'.$_SESSION['e_imie'].'</div>';
                                     unset($_SESSION['e_imie']);
                                 }
                echo'
                        </td></tr>


                        <tr>
                            <td>Nazwisko:</td>
                            <td><input type="text" name ="nazwisko" value="'.$wiersz['nazwisko'].'"></td>
                        </tr>
                        <tr><td align=center colspan=2>
                ';
                                 if (isset($_SESSION['e_nazwisko'])){
                                     echo '<div class="error">'.$_SESSION['e_nazwisko'].'</div>';
                                     unset($_SESSION['e_nazwisko']);
                                 }
                echo'
                        </td></tr>


                        <tr>
                            <td>Płeć:</td>
                            <td>
                ';
                            if($wiersz['plec']=="kobieta"){
                echo'
                                <input type="radio" name="plec" value="kobieta" checked>kobieta<br/>
                                <input type="radio" name="plec" value="mezczyzna">mężczyzna</td>
                ';
                            }else{
                echo'
                                <input type="radio" name="plec" value="kobieta">kobieta<br/>
                                <input type="radio" name="plec" value="mezczyzna" checked>mężczyzna</td>
                ';
                            }
                echo'
                        </tr>
                        <tr><td align=center colspan=2>
                ';
                                 if (isset($_SESSION['e_plec'])){
                                     echo '<div class="error">'.$_SESSION['e_plec'].'</div>';
                                     unset($_SESSION['e_plec']);
                                 }
                echo'
                        </td></tr>


                        <tr>
                            <td>Nazwisko panieńskie:</td>
                            <td><input type="text" name="nazwisko_panienskie" value="'.$wiersz['nazwisko_panienskie'].'"></td>
                        </tr>
                        <tr><td align=center colspan=2>
                ';
                                 if (isset($_SESSION['e_nazwisko_panienskie'])){
                                     echo '<div class="error">'.$_SESSION['e_nazwisko_panienskie'].'</div>';
                                     unset($_SESSION['e_nazwisko_panienskie']);
                                 }
                echo'
                        </td></tr>


                        <tr>
                            <td>Email:</td>
                            <td><input type="text" name="email" value="'.$wiersz['email'].'"></td>
                        </tr>
                        <tr><td align=center colspan=2>
                ';
                                 if (isset($_SESSION['e_email'])){
                                     echo '<div class="error">'.$_SESSION['e_email'].'</div>';
                                     unset($_SESSION['e_email']);
                                 }
                echo'
                        </td></tr>


                        <tr>
                            <td>Kod pocztowy:</td>
                            <td><input type="text" name="kod_pocztowy" value="'.$wiersz['kod_pocztowy'].'"></td>
                        </tr>
                        <tr><td align=center colspan=2>
                ';
                                 if (isset($_SESSION['e_kod_pocztowy'])){
                                     echo '<div class="error">'.$_SESSION['e_kod_pocztowy'].'</div>';
                                     unset($_SESSION['e_kod_pocztowy']);
                                 }
                echo'
                        </td></tr>


                        <tr>
                            <td><input type ="submit" name="potwierdz_zmiany" value="Potwierdź zmiany"></td>
                            <td><input type ="submit" name="odrzuc_zmiany" value="Odrzuć zmiany"></td>
                        </tr>
                    </table>
                </form>
                ';
            }
        }
        // normalne wyswietlanie z opcja edycji
        else{


            $sql = "SELECT * FROM pracownicy";



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


                    if(isset($_GET['page'])){
                        for($i=0; $i<($_GET['page']-1)*10; $i++){
                            $wiersz = $rezultat->fetch_assoc();
                        }

                        echo '<table class="tabela_wynikow"> ';
                        echo '
                            <tr align="center" style="font-weight:bold">
                                <td>Edycja</td>
                                <td>Id</td>
                                <td>Imię </td>
                                <td>Nazwisko </td>
                                <td>Nazwisko panieńskie </td>
                                <td>Płeć </td>
                                <td>Email </td>
                                <td>Kod pocztowy</td>
                            </tr>
                            ';
                            $i=0;
                            while(($wiersz = $rezultat->fetch_assoc())&&$i<10){
                            $i++;
                            echo '
                            <tr>
                                <td><a href="?strona='.$_GET['strona'].'&page='.$_GET['page'].'&id='.$wiersz['id'].'">Edycja</a></td>
                                <td>'.$wiersz['id'].' </td>
                                <td>'.$wiersz['imie'].' </td>
                                <td>'.$wiersz['nazwisko'].' </td>
                                <td>'.$wiersz['nazwisko_panienskie'].' </td>
                                <td>'.$wiersz['plec'].' </td>
                                <td>'.$wiersz['email'].' </td>
                                <td>'.$wiersz['kod_pocztowy'].' </td>
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

