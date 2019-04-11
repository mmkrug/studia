using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;





namespace cs_lab1 {
  


    class HtmlTable {

        public string text_html;

        public string[] generate_numbers(int ilosc_wierszy, int ilosc_kolumn) {
            var dane = new string[ilosc_wierszy*ilosc_kolumn];
            for(int i = 0; i < ilosc_wierszy * ilosc_kolumn; i++) {
                dane[i] = i.ToString();
            }

            return dane;
        }

        public string[] generate_text(int ilosc_wierszy, int ilosc_kolumn) {
            var dane = new string[ilosc_wierszy * ilosc_kolumn];
            for (int i = 0; i < ilosc_wierszy * ilosc_kolumn; i++) {
                dane[i] = "taki sobie napis #" + (i + 1) + ". ";
            }

            return dane;
        }


        public void add_doctype() {
            text_html += "<!DOCTYPE html>\n<html>\n<body>\n<table border=1>\n";
        }
        public void add_style() {
            text_html += "<head>\n<style>\ntable{font-family:arial,sans-serif;border-collapse:collapse;width:60%;}\ntd,th{border:1px solid#dddddd;text-align:left;padding:8px;}\ntr:nth-child(even){background-color:#dddddd;}\n</style>\n</head>\n";
        }
        public void add_thead(string thead) {
            text_html += "<thead><tr><th>" + thead + "</th></tr></thead>";
        }

        public void add_thead(int wiersz, int ilosc_kolumn, string[][] zawartosc) {
            text_html += "<thead><tr>";
            for (int i = 0; i < ilosc_kolumn; i++) {
                text_html += "<th>" + zawartosc[wiersz][i] + "</th>";
            }
            text_html += "</tr></thead>";
        }

        public void add_tfoot(string tfoot) {
            text_html += "<tfoot><tr><td>" + tfoot + "</td></tr></tfoot>";
        }
        public void add_tail() {
            text_html += "</table></body></html>";
        }
        public void add_tbody(int liczba_kolumn, int liczba_wierszy) {
            for (int i = 1; i <= liczba_wierszy; i++) {
                text_html += "<tr>";
                for (int j = 1; j <= liczba_kolumn; j++) {
                    text_html += "<td>" + i + "" + j + "</td>";
                }
                text_html += "</tr>";
            }
        }
        public void add_tbody(int liczba_kolumn, int liczba_wierszy, string[] data) {
            int licznik = 0;
            for (int i = 1; i <= liczba_wierszy; i++) {
                text_html += "<tr>";
                for (int j = 1; j <= liczba_kolumn; j++) {
                    text_html += "<td>" + data + "</td>";
                    licznik++;
                }
                text_html += "</tr>";
            }
        }

        public HtmlTable() {

        }

        // tabela M x N wypelniona liczbami
        public HtmlTable(int liczba_kolumn, int liczba_wierszy) {
            text_html += "<!DOCTYPE html>\n<html>\n<body>\n<table border=1>\n";

            for (int i = 1; i <= liczba_wierszy; i++) {
                text_html += "<tr>\n\t";
                for (int j = 1; j <= liczba_kolumn; j++) {
                    text_html += "<td>" + i + "" + j + "</td>";
                }
                text_html += "\n</tr>\n";
            }
            text_html += "</table>\n</body>\n</html>\n";
            Console.WriteLine(text_html);
        }

        // tabela M x N wypelniona podamyni wartosciami
        public HtmlTable(int liczba_kolumn, int liczba_wierszy, string[] dane) {
            text_html += "<!DOCTYPE html><html><body><table border=1>";
            int licznik = 0;
            for (int i = 1; i <= liczba_wierszy; i++) {
                text_html += "<tr>";
                for (int j = 1; j <= liczba_kolumn; j++) {
                    text_html += "<td>" + dane[licznik] + "</td>";
                    licznik++;
                }
                text_html += "</tr>";
            }
            text_html += "</table></body></html>";
            File.WriteAllText("html.html", text_html);
        }

        // tabela M x N, naglowek, stopka, dane
        public HtmlTable(int liczba_kolumn, int liczba_wierszy, string naglowek, string stopka, string[] dane) {
            text_html += "<!DOCTYPE html><html><body><table border=1>";

            // dodanie naglowka
            text_html += "<thead><tr>";
            for (int i = 1; i <= liczba_kolumn; i++) {
                text_html += "<th>" + naglowek + "</th>";
            }
            text_html += "</tr></thead>";

            // wypelnienie tabeli danymi
            int licznik = 0;
            for (int i = 1; i <= liczba_wierszy; i++) {
                text_html += "<tr>";
                for (int j = 1; j <= liczba_kolumn; j++) {
                    text_html += "<td>" + dane[licznik] + "</td>";
                    licznik++;
                }
                text_html += "</tr>";
            }

            // dodanie stopki
            text_html += "<tfoot><tr>";
            for (int i = 1; i <= liczba_kolumn; i++) {
                text_html += "<td>" + stopka + "</td>";
            }
            text_html += "</tr></tfoot>";

            text_html += "</table></body></html>";
            File.WriteAllText("html.html", text_html);
        }

        // tabela M x N, uzwglednia pierwszy wiersz jako naglowek
        public HtmlTable(int liczba_kolumn, int liczba_wierszy, string plik) {
            text_html += "<!DOCTYPE html><html><body><table border=1>";

            var lines = System.IO.File.ReadAllLines(plik);
            var line = lines[0];
            var cols = line.Split(',');

            // dodanie naglowka
            text_html += "<thead><tr>";
            foreach (var col in cols) {
                text_html += "<th>" + col + "</th>";

            }
            text_html += "</tr></thead>";

            // wypelnienie tabeli danymi
            for (int i=1; i<lines.Count();i++) {
                line = lines[i];
                cols = line.Split(',');
                text_html += "<tr>";
                foreach (var col in cols) {
                    text_html += "<td>" + col + "</td>";

                }
                text_html += "</tr>";
            }



            text_html += "</table></body></html>";
            File.WriteAllText("html.html", text_html);
        }



        public HtmlTable(string nazwa_pliku) {
            add_doctype();
            add_style();
            add_thead("naglowek");
            add_tbody(2, 5);
            add_tfoot("stopka");
            add_tail();

            File.WriteAllText(nazwa_pliku + ".html", text_html);
        }

        // wymiary calej tabeli m,n, czy pierwszy wiersz jest naglowkien, czy ostatni wiersz jest stopka, dane do wprowadzenia
        public HtmlTable(int liczba_kolumn, int liczba_wierszy, bool nagolowek, bool stopka, string[] dane) {
            int licznik = 0;

            if (nagolowek == true) {
                liczba_wierszy--;
            }
            if (stopka == true) {
                liczba_wierszy--;
            }

            text_html += "<!DOCTYPE html>\n<html>\n<body>\n<table border=1>\n";

            // naglowek tabeli
            if (nagolowek == true) {
                text_html += "<thead><tr>\n\t";
                for (int i = 0; i < liczba_kolumn; i++) {
                    text_html += "<th>" + dane[licznik] + "</th>";
                    licznik++;
                }
                text_html += "\n</tr></thead>\n";
            }


            // dane wewnetrzne tabeli
            text_html += "<tbody>\n";
            for (int i = 1; i < liczba_wierszy; i++) {
                text_html += "<tr>\n\t";
                for (int j = 1; j <= liczba_kolumn; j++) {
                    text_html += "<td>" + dane[licznik] + "</td>";
                    licznik++;
                }
                text_html += "\n</tr>\n";
            }
            text_html += "\n</tbody>\n";


            //stopka
            if (nagolowek == true) {
                text_html += "<tfoot><tr>\n\t";
                for (int i = 0; i < liczba_kolumn; i++) {
                    text_html += "<td>" + dane[licznik] + "</td>";
                    licznik++;
                }
                text_html += "\n</tr></tfoot>\n";
            }

            // zakonczenie dokumentu
            text_html += "</table>\n</body>\n</html>";

        }

        public HtmlTable(int liczba_kolumn, int liczba_wierszy, bool nagolowek, bool stopka, string nazwa_pliku) {
            int licznik = 0;

            var lines = System.IO.File.ReadAllLines(nazwa_pliku);
            var line = lines[licznik];
            var cols = line.Split(',');
            string text_html = "";

            if (nagolowek == true) {
                liczba_wierszy--;
            }
            if (stopka == true) {
                liczba_wierszy--;
            }

            text_html += "<!DOCTYPE html>\n<html>\n<body>\n<table border=1>\n";


            // naglowek tabeli
            if (nagolowek == true) {
                text_html += "<thead><tr>\n\t";
                for (int j = 0; j < cols.Count(); j++) {
                    text_html += "<th>" + cols[j] + "</th>";
                }
                text_html += "\n</tr></thead>\n";
                licznik++;
            }



            // wypelnienie tabeli danymi
            text_html += "<tbody>\n";
            for (int i = 0; i < liczba_wierszy; i++) {
                line = lines[licznik];
                cols = line.Split(',');
                text_html += "<tr>\n\t";
                foreach (var col in cols) {
                  text_html += "<td>" + col + "</td>";
                }

                //for (int j = 0; j < cols.Count(); j++) {
                 //   text_html += "<td>" + cols[j] + "</td>";
                //}
                licznik++;
                text_html += "\n</tr>\n";
            }
            text_html += "</tbody>\n";


            // stopka tabeli
            if (stopka == true) {
                text_html += "<tfoot><tr>\n\t";
                foreach (var col in cols) {
                    text_html += "<td>" + col + "</td>";
                }
                text_html += "\n</tr></tfoot>\n";
                licznik++;
            }

            // zakonczenie dokumentu
            text_html += "</table>\n</body>\n</html>";
        }


    }


    class Program {

        // funkcja do generowania danych liczbowych. string[m*n];
        static string[] generate_numbers(int ilosc_wierszy, int ilosc_kolumn) {
            var dane = new string[ilosc_wierszy * ilosc_kolumn];
            for (int i = 0; i < ilosc_wierszy * ilosc_kolumn; i++) {
                dane[i] = i.ToString();
            }
            return dane;
        }
        // funkcja do generowania danych tekstowych. string[m*n];
        static string[] generate_text(int ilosc_wierszy, int ilosc_kolumn) {
            var dane = new string[ilosc_wierszy * ilosc_kolumn];
            for (int i = 0; i < ilosc_wierszy * ilosc_kolumn; i++) {
                dane[i] = "taki sobie napis #" + (i + 1) + ". ";
            }
            return dane;
        }



        // test #1
        static void test_pierwszy(int ilosc_wierszy, int ilosc_kolumn) {
            var dane = generate_numbers(ilosc_wierszy, ilosc_kolumn);
            var tabela = new HtmlTable(ilosc_wierszy, ilosc_kolumn, true, false, dane);
            File.WriteAllText("test1.html", tabela.text_html);
            Console.WriteLine(tabela.text_html);
        }

        // test #2
        static void test_drugi(int ilosc_wierszy, int ilosc_kolumn) {
            var dane = generate_text(ilosc_wierszy, ilosc_kolumn);
            var tabela = new HtmlTable(ilosc_wierszy, ilosc_kolumn, false, false, dane);
            File.WriteAllText("test2.html", tabela.text_html);
            Console.WriteLine(tabela.text_html);
        }

        // test #3
        static void test_trzeci(int ilosc_wierszy, int ilosc_kolumn, string nazwa_pliku) {
            var tabela = new HtmlTable(ilosc_wierszy, ilosc_kolumn, false, false, nazwa_pliku);
            File.WriteAllText("test3.html", tabela.text_html);
            Console.WriteLine(tabela.text_html);
        }

        // test #4
        static void test_czwarty(int ilosc_wierszy, int ilosc_kolumn) {
            var dane = generate_text(ilosc_wierszy, ilosc_kolumn);
            var tabela = new HtmlTable(ilosc_wierszy, ilosc_kolumn, true, false, dane);
            File.WriteAllText("test4.html", tabela.text_html);
            Console.WriteLine(tabela.text_html);
        }


        static void Main(string[] args) {





            //test_pierwszy(2,2);

            test_drugi(2,3);

            test_trzeci(2,6,"2x6.csv");

            //test_czwarty(2, 5);

        }
    }
}
