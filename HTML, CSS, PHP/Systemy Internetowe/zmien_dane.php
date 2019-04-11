<?php
    require_once "connect.php";
    // polaczenie z bazą i dodanie rekordu
    $polaczenie = @new mysqli($host,$db_user,$db_password,$db_name);
    //           @ przed new spowoduje wylaczenie pokazywania bledow

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
    // polaczona z baza danych
    else{
        mysqli_set_charset($polaczenie,"utf8");

        // czy zostal wyslany formularz?
        if(isset($_POST['login'])){
            $_SESSION['wszystko_OK'] = true;

            if(isset($_POST['odrzuc_zmiany'])){
                header ('Location: index.php?strona=1');
            }

            $login = $_POST['login'];
            if((strlen($login)<6) || (strlen($login)>20)){
                $_SESSION['wszystko_OK'] = false;
                $_SESSION['e_login'] = "Login musi posiadać od 6 do 20 znaków.";
            }

            $haslo = $_POST['haslo'];
            if((strlen($haslo)<6) || (strlen($haslo)>20)){
             $_SESSION['wszystko_OK'] = false;
             $_SESSION['e_haslo'] = "Hasło musi posiadać od 6 do 20 znaków.";
            }

            $haslo2 = $_POST['haslo2'];
            if($haslo != $haslo2){
             $_SESSION['wszystko_OK'] = false;
             $_SESSION['e_haslo2'] = "Hasła muszą być zgodne";
            }

            $imie = $_POST['imie'];
            if($haslo != $haslo2){
             $_SESSION['wszystko_OK'] = false;
             $_SESSION['e_imie'] = "Hasła muszą być zgodne";
            }

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

            if($login != $_SESSION['login']){
                $sql = "SELECT * FROM uzytkownicy WHERE login='$login'";
                if($rezultat = $polaczenie->query($sql)){
                    $liczba_wynikow = $rezultat->num_rows;
                    if($liczba_wynikow>0){
                        $_SESSION['wszystko_OK'] = false;
                        $_SESSION['e_login'] = "Taki login już istnieje.";
                    }
                }
            }
        }



        //if(isset($_SESSION['wszystko_OK']))

        // dane z formularza poprawne. co dalej?
        if((isset($_SESSION['wszystko_OK'])) && ($_SESSION['wszystko_OK']==true)){
            $_SESSION['wszystko_OK']=false;


            $id = $_SESSION['id'];
            if($polaczenie->query("
                                UPDATE uzytkownicy
                                SET login = '$login',
                                    haslo = '$haslo',
                                    imie = '$imie',
                                    nazwisko = '$nazwisko'
                                WHERE uzytkownicy.id = '$id'")){
                echo "Dane zostały pomyślnie zmienione.</br></br>";

                $_SESSION['wszystko_OK']=false;
                $_SESSION['login'] = $login;
                $_SESSION['imie'] = $imie;
                $_SESSION['nazwisko'] = $nazwisko;

                echo 'Login: <strong>'.$_POST['login']. '</strong></br>';
                echo 'Imię: <strong>'.$_POST['imie']. '</strong></br>';
                echo 'Nazwisko: <strong>'.$_POST['nazwisko']. '</strong></br>';

            }else{
                echo "Błąd kwerendy zmiany danych. ";
            }

        }
        else{
            echo '

            <form method="POST">
                <table>

                    <tr>
                        <td>Login:</td>
                        <td><input type="text" name="login" value="'.$_SESSION['login'].'"></td>
                    </tr>
                    <tr><td align=center colspan=2>
            ';
                             if (isset($_SESSION['e_login'])){
                                 echo '<div class="error">'.$_SESSION['e_login'].'</div>';
                                 unset($_SESSION['e_login']);
                             }
            echo'
                    </td></tr>


                    <tr>
                        <td>Hasło:</td>
                        <td><input type="password" name ="haslo"></td>
                    </tr>
                    <tr><td align=center colspan=2>
            ';
                             if (isset($_SESSION['e_haslo'])){
                                 echo '<div class="error">'.$_SESSION['e_haslo'].'</div>';
                                 unset($_SESSION['e_haslo']);
                             }
            echo'
                    </td></tr>


                    <tr>
                        <td>Powtórz hasło:</td>
                        <td><input type="password" name ="haslo2"></td>
                    </tr>
                    <tr><td align=center colspan=2>
            ';
                             if (isset($_SESSION['e_haslo2'])){
                                 echo '<div class="error">'.$_SESSION['e_haslo2'].'</div>';
                                 unset($_SESSION['e_haslo2']);
                             }
            echo'
                    </td></tr>


                    <tr>
                        <td>Imię:</td>
                        <td><input type="text" name ="imie" value="'.$_SESSION['imie'].'"></td>
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
                        <td><input type="text" name ="nazwisko" value="'.$_SESSION['nazwisko'].'"></td>
                    </tr>
                    <tr><td align=center colspan=2>
            ';
                             if (isset($_SESSION['e_nazwisko'])){
                                 echo '<div class="error">'.$_SESSION['e_nazwisko'].'</div>';
                                 unset($_SESSION['e_nazwisko']);
                             }




            echo '
                    <tr>
                        <td align="center"><input type ="submit" name="potwierdz_zmiany" value="Potwierdź zmiany"></td>
                        <td align="center"><input type ="submit" name="odrzuc_zmiany" value="Odrzuć zmiany"></td>
                    </tr>
                </table>
            </form>
            ';


        }





        $polaczenie->close();
    }
?>