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
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `id` int(11) NOT NULL,
  `login` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `haslo` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `uprawnienia` int(11) NOT NULL,
  `imie` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`id`, `login`, `haslo`, `uprawnienia`, `imie`, `nazwisko`) VALUES
(4, 'w2e3r4', 'q1w2e3', 4, 'Michał', 'Krug'),
(5, 'qwerty', 'qwerty', 4, 'qwerty', 'qwerty'),
(6, 'qwerty1', 'qwerty1', 4, 'qwerty1', 'qwerty1'),
(7, 'qwerty2', 'qwerty2', 4, 'qwerty2', 'qwerty2'),
(9, 'qwerty4', 'qwerty4', 4, 'qwerty4', 'qwerty4'),
(10, 'qwerty12', 'qwerty12', 4, 'qwerty12', 'qwerty12'),
(11, 'asdfgh', 'asdfgh', 4, 'asdfgh', 'asdfgh'),
(12, 'asdfgh1', 'asdfgh1', 4, 'asdfgh1', 'asdfgh1'),
(13, 'dsadsa1', 'qweasd', 4, 'qweqwe', 'asdasd'),
(14, 'aaaaaa', 'aaaaaa', 0, 'aaa', 'aaa'),
(15, 'haslohash', '$2y$10$3.iND70GEsnYQj5TsEiRReXwO7cTQjueJjt.2WG9qmpryh3e1sVXy', 0, 'haslo', 'hash'),
(16, 'admin1', '$2y$10$AH2I4fw/cpGAuQklOHCgF.1iz9jlq2tLJKkWGG4gzd6dVyOYEURUC', 4, 'admin', 'admin'),
(17, 'admin2', '$2y$10$YWXMV1e8zKrnDDm6dcPhVOJSVgLQr8ZJDAGVteNXx9kYP/6Bhmkgu', 4, 'admin', 'numer2');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
