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

        // czy zostal wyslany formularz? sprawdzenie danych
        if(isset($_POST['zaloguj'])){

            $_SESSION['wszystko_OK'] = true;
            $login = $_POST['login'];
            $haslo = $_POST['haslo'];

            $sql = "SELECT *
                    FROM uzytkownicy
                    WHERE login='$login'";

            if($rezultat = $polaczenie->query($sql)){
                $liczba_wynikow = $rezultat->num_rows;

                if($liczba_wynikow>0){
                    //echo" JEST WIECEJ NIZ 0 !!!!!!";
                    $_SESSION['wiersz'] = $rezultat->fetch_assoc();
                    $id = $_SESSION['wiersz']['id'];
                    $imie = $_SESSION['wiersz']['imie'];
                    $nazwisko = $_SESSION['wiersz']['nazwisko'];
                    $uprawnienia = $_SESSION['wiersz']['uprawnienia'];


                    if(!password_verify($haslo, $_SESSION['wiersz']['haslo'])){
                        $_SESSION['wszystko_OK'] = false;
                        $_SESSION['e_haslo'] = "Nieprawidłowe hasło.";
                    }

                    unset($_SESSION['wiersz']);
                }else{
                    $_SESSION['wszystko_OK'] = false;
                    $_SESSION['e_login'] = "Nieprawidłowy login.";
                }
            }





        }

        // dane z formularza poprawne. co dalej?
        if((isset($_SESSION['wszystko_OK'])) && ($_SESSION['wszystko_OK']==true)){
            $_SESSION['wszystko_OK']=false;
            $_SESSION['id'] = $id;
            $_SESSION['login'] = $login;
            $_SESSION['imie'] = $imie;
            $_SESSION['nazwisko'] = $nazwisko;
            $_SESSION['zalogowany'] = true;
            $_SESSION['uprawnienia'] = $uprawnienia;
            header ('Location: index.php');

        }
        else{
            echo '

            <form method="POST">
                <table>

                    <tr>
                        <td>Login:</td>
                        <td><input type="text" name="login"></td>
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
            echo '
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center"><input type ="submit" name="zaloguj" value="Zaloguj"></td>
                    </tr>
                </table>
            </form>
            ';


        }





        $polaczenie->close();
    }
?>