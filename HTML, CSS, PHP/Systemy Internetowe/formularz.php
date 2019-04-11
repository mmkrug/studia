<?php

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

    //if(isset($_SESSION['wszystko_OK']))

    if((isset($_SESSION['wszystko_OK'])) && ($_SESSION['wszystko_OK']==true)){
        $_SESSION['wszystko_OK']=false;

        echo 'Imię: <strong>'.$_POST['imie']. '</strong></br>';
        echo 'Nazwisko: <strong>'.$_POST['nazwisko']. '</strong></br>';
        echo 'Nazwisko panienskie: <strong>'.$_POST['nazwisko_panienskie']. '</strong></br>';
        echo 'Płeć: <strong>'.$_POST['plec']. '</strong></br>';
        echo 'Email: <strong>'.$_POST['email']. '</strong></br>';
        echo 'Kod pocztowy: <strong>'.$_POST['kod_pocztowy']. '</strong></br>';


        $_SESSION['dodanych_pracownikow']++;
        $_SESSION[($_SESSION['dodanych_pracownikow']-1).'imie'] = $_POST['imie'];
        $_SESSION[($_SESSION['dodanych_pracownikow']-1).'nazwisko'] = $_POST['nazwisko'];
        $_SESSION[($_SESSION['dodanych_pracownikow']-1).'nazwisko_panienskie'] = $_POST['nazwisko_panienskie'];
        $_SESSION[($_SESSION['dodanych_pracownikow']-1).'email'] = $_POST['email'];
        $_SESSION[($_SESSION['dodanych_pracownikow']-1).'plec'] = $_POST['plec'];
        $_SESSION[($_SESSION['dodanych_pracownikow']-1).'kod_pocztowy'] = $_POST['kod_pocztowy'];


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
        else{

            mysqli_set_charset($polaczenie,"utf8");


            // wstawienie pracownikow
            if($polaczenie->query("INSERT INTO pracownicy(id,imie,nazwisko,nazwisko_panienskie,email,plec,kod_pocztowy) VALUES (NULL,'$imie', '$nazwisko', '$nazwisko_panienskie', '$email', '$plec', '$kod_pocztowy')")){
                echo "Dane zostały pomyślnie wstawione.";
            }else{
                echo "Błąd kwerendy wprowadzania danych";
            }



            $polaczenie->close();
        }


    }
    else{
        echo '

        <form method="POST">
            <table>

                <tr>
                    <td>Imie:</td>
                    <td><input type="text" name="imie"></td>
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
                    <td><input type="text" name ="nazwisko"></td>
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
                    <td><input type="radio" name="plec" value="kobieta">kobieta<br/>
                        <input type="radio" name="plec" value="mezczyzna">mężczyzna</td>
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
                    <td><input type="text" name="nazwisko_panienskie"></td>
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
                    <td><input type="text" name="email"></td>
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
                    <td><input type="text" name="kod_pocztowy"></td>
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
                    <td>&nbsp;</td>
                    <td id="submit_button"><input type ="submit" name="submit" value="Wyślij"></td>
                </tr>
            </table>
        </form>
        ';


    }
?>