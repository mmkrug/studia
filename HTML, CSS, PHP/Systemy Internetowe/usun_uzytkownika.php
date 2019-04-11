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

            if(isset($_POST['nie'])){
                header ('Location: index.php?strona='.$_GET['strona'].'&page='.$_GET['page'].'');
                exit();
            }


            // formularz wyslany, wszystko ok, update danych
            if(isset($_POST['tak'])){
                //DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';


                $sql = "SELECT * FROM uzytkownicy WHERE uzytkownicy.id = '$id'";
                if($rezultat = $polaczenie->query($sql)){
                    $liczba_wynikow = $rezultat->num_rows;

                    if($liczba_wynikow>0){
                        $wiersz = $rezultat->fetch_assoc();
                        if($wiersz['uprawnienia']==4){
                            $_SESSION['usun_uzytkownika_admin'] = true;
                            header ('Location: index.php?strona='.$_GET['strona'].'&page='.$_GET['page'].'');
                            exit();
                        }
                    }
                }





                if($polaczenie->query("
                                    DELETE FROM uzytkownicy
                                    WHERE uzytkownicy.id = '$id'")){

                }else{
                    echo "Błąd kwerendy zmiany danych. ";
                }

                if(($_SESSION['liczba_wynikow']%10)!=1){
                    header ('Location: index.php?strona='.$_GET['strona'].'&page='.$_GET['page'].'');
                }else{
                    header ('Location: index.php?strona='.$_GET['strona'].'&page='.($_GET['page']-1).'');
                }
            }
            else{
                //pobranie danych osobowych rekordu o danym id.

                // wyszukanie pracownika
                if($rezultat = $polaczenie->query("SELECT * FROM pracownicy where id=".$_GET['id']."")){
                    //echo "ZNALEZIONO CZYJESC ID";
                }else{
                    echo "Błąd kwerendy edycji praownika o danym id";
                }

                $wiersz = $rezultat->fetch_assoc();
                echo '

                <form method="POST">
                    <table>

                        <tr><td>Czy na pewno chcesz usunąć rekord?</td></tr>
                        <tr>
                            <td><input type ="submit" name="tak" value="Tak">
                            <input type ="submit" name="nie" value="Nie"></td>
                        </tr>
                    </table>
                </form>
                ';
            }


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


                    if(isset($_SESSION['usun_uzytkownika_admin'])){
                        echo 'Próba usunięcia admina. </br></br>';
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
                                <td>Usuń</td>

                            </tr>
                            ';
                            $i=0;
                            while(($wiersz = $rezultat->fetch_assoc())&&$i<10){
                            $i++;
                            echo'
                                <tr>
                                    <input type="hidden" name="login" value="'.$wiersz['login'].'" />
                                    <td>'.$wiersz['login'].' </td>
                                    <td>'.$wiersz['imie'].' </td>
                                    <td>'.$wiersz['nazwisko'].' </td>
                                    <td>'.$wiersz['uprawnienia'].'</td>
                                    <td><a href="?strona='.$_GET['strona'].'&page='.$_GET['page'].'&id='.$wiersz['id'].'">Usuń</a></td>
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

