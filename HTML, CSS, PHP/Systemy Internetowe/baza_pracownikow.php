<?php

//    if(isset($_GET['wyszukaj'])){
//        echo 'Wyszukiwanie: "';
//        echo $_GET['wyszukaj'];
//        echo '"</br>';
//    }
//
//    if(isset($_GET['page'])){
//        echo "jest page!!!!!!!!!";
//        echo $_GET['page'];
//    }else{
//        echo "nie ma page.";
//    }




        require_once "connect.php";
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
            //czy zostal wcisniety guzik wyszukiwania

            if(isset($_GET['search_button'])){
                $_GET['page']=1;
            }

            if(isset($_GET['wyszukaj'])){
                $sql = "SELECT * FROM pracownicy WHERE nazwisko LIKE \"%".$_GET['wyszukaj']."%\"";
            }
            else{
                $sql = "SELECT * FROM pracownicy";
            }



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

            $polaczenie->close();
        }


?>

