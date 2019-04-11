-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 24 Sty 2019, 18:46
-- Wersja serwera: 10.1.33-MariaDB
-- Wersja PHP: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `si`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `id` int(11) NOT NULL,
  `imie` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `nazwisko` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `plec` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `nazwisko_panienskie` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `kod_pocztowy` text COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `pracownicy`
--

INSERT INTO `pracownicy` (`id`, `imie`, `nazwisko`, `plec`, `nazwisko_panienskie`, `email`, `kod_pocztowy`) VALUES
(2, 'Bob', 'Travis', 'mezczyzna', 'Niewiem', 'email.example@example.com', '22-345'),
(3, 'Bob2', 'Travis2', 'mezczyzna', 'Niewiem2', 'email.example@example.com', '22-345'),
(4, 'Bobby', 'Smith', 'mezczyzna', 'Lolo', 'email@wp.pl', '11-111'),
(5, 'Majk', 'Wazoski', 'plec', 'Fasoski', 'fasoski.email@gmail.com', '12-345'),
(6, 'Aaa', 'Aaa', 'mezczyzna', 'Aaa', 'aaa@gmail.com', '11-111'),
(7, 'Bbb', 'Bbb', 'plec', 'Bbb', 'bbb@email.com', '22-222'),
(8, 'Ccc', 'Ccc', 'plec', 'Ccc', 'ccc@o2.pl', '33-333'),
(9, 'Ddd', 'Ddd', 'plec', 'Ddd', 'ddd@gmail.com', '44-444'),
(11, 'Ghi', 'Ghij', 'plec', 'Ghijk', 'ghi@gmail.com', '54-321'),
(12, 'Bobby', 'Smith', 'plec', 'Iron', 'boby@gmail.com', '98-765'),
(13, 'Bob', 'Iron', 'mezczyzna', 'Lolo', 'email@wp.pl', '65-432'),
(14, 'dsadsaDS', 'SSDAA', 'plec', 'dsadas', 'dsa@dsa.dsa', '11-222'),
(15, 'dsadsa', 'sadas', 'mezczyzna', 'dsa', 'dsa@dsa.pl', '99-999'),
(16, 'Michał', 'Krug', 'mezczyzna', 'Lolo', 'email@wp.pl', '11-111'),
(17, 'sadads', 'dsaads', 'mezczyzna', 'sdadas', 'email@gmail.com', '11-111'),
(18, 'Michał', 'Krug', 'kobieta', 'Lolo', 'email@wp.pl', '11-111'),
(19, 'Michał', 'Krug', 'mezczyzna', 'Lolo', 'email@wp.pl', '11-111'),
(20, 'Bobby', 'Wazoski', 'kobieta', 'Ccc', 'email@gmail.com', '99-200'),
(21, 'Majk', 'Wazoski', 'mezczyzna', 'FFFFFF', 'fasoski.email@gmail.com', '33-333'),
(22, 'aaa', 'aaa', 'kobieta', 'aaa', 'email@wp.pl', '11-111'),
(23, 'aaa', 'aaa', 'kobieta', 'aaa', 'email@wp.pl', '11-111'),
(24, 'aaa', 'aaa', 'kobieta', 'aaa', 'email@wp.pl', '11-111');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
