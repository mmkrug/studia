<?php
    $_SESSION['strona']=3;


    if($_SESSION['dodanych_pracownikow']>0){

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
        	for($i=0; $i < $_SESSION['dodanych_pracownikow']; $i++){
        		echo '
        		<tr>
        			<td>'.$i.' </td>
        			<td>'.$_SESSION[$i.'imie'].' </td>
        			<td>'.$_SESSION[$i.'nazwisko'].' </td>
        			<td>'.$_SESSION[$i.'nazwisko_panienskie'].' </td>
        			<td>'.$_SESSION[$i.'plec'].' </td>
        			<td>'.$_SESSION[$i.'email'].' </td>
        			<td>'.$_SESSION[$i.'kod_pocztowy'].' </td>
        		</tr>
        		';
        	}
        	echo '</table></div>';

    }else{
        echo "Brak dodanych pracowników.";
    }

?>