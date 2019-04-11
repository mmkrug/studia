import java.util.Scanner;

import static java.lang.Math.sqrt;

public class Main {


//    int a = 0, b = 0, c = 0, d = 0;
//    float delta_r = 0, delta_u = 0, p_delta_r, p_delta_u, x1r, x2r, x3r, x4r, x1u, x2u, x3u, x4u, sr = 0, su = 0, rr = 0, ru = 0, ilr = 0, ilu = 0;
//


    static void wprowadz_dane() {

        Scanner skaner = new Scanner(System.in);

        System.out.print("Podaj a: ");
        Zm.a = skaner.nextInt();
        System.out.print("Podaj b: ");
        Zm.b = skaner.nextInt();
        System.out.print("Podaj c: ");
        Zm.c = skaner.nextInt();
        System.out.print("Podaj d: ");
        Zm.d = skaner.nextInt();

        skaner.close();

    }

    static void formatuj_rownanie(int a, int b, int c, int d) {

        System.out.println();

        // AAAAAAAAAAA
        if (a != 0) {
            System.out.print(a + "xx");
            //System.out.println("%dxx", a);
        }

        // BBBBBBBBBB
        if (a == 0 && b != 0) {
            System.out.print(b + "x");

        } else if (b > 0) {
            System.out.print("+" + b + "x");

        } else if (b < 0) {
            System.out.print(b + "x");

        } else {
        }


        // CCCCCCCCCC

        if (a == 0 && b == 0 && c != 0) {
            System.out.print(c);

        } else if ((a != 0 || b != 0) && c > 0) {
            System.out.print("+" + c);

        } else if ((a != 0 || b != 0) && c < 0) {
            System.out.print(c);

        } else {
        }


        // DDDDDDDDDDD

        if (a == 0 && b == 0 && c == 0 && d != 0) {
            System.out.print(d + "i");

        } else if ((a != 0 || b != 0 || c != 0) && d > 0) {
            System.out.print("+" + d + "i");

        } else if ((a != 0 || b != 0 || c != 0) && d < 0) {
            System.out.print(d + "i");

        } else {
        }

        if(a==0 && b==0 && c==0 && d==0){
            System.out.print("0");
        }

        System.out.println(" = 0\n");
    }

    static float oblicz_d_r(int a, int b, int c) {
        float delta_r = (b*b) - (4 * a*c);
        return delta_r;
    }

    static float oblicz_d_u(int a, int d) {
        float delta_u = -(4 * a*d);
        return delta_u;
    }

    static float oblicz_p_d_r(float delta_r, float delta_u) {
        float p_delta_r;
        p_delta_r = (float) sqrt((sqrt((delta_r*delta_r) + (delta_u*delta_u)) + delta_r) / 2);
        return p_delta_r;
    }

    static float oblicz_p_d_u(float delta_r, float delta_u) {
        float p_delta_u;
        p_delta_u = (float) sqrt((sqrt((delta_r*delta_r) + (delta_u*delta_u)) - delta_r) / 2);
        return p_delta_u;

    }


    static void oblicz_rownanie(int a, int b, int c, int d, float x1r, float x1u, float x2r, float x2u, float x3r, float x3u, float x4r, float x4u) {

        float delta_r, delta_u, p_delta_r, p_delta_u, deltr;

        if (a != 0 && d == 0) {
            delta_r = oblicz_d_r(a, b, c);
            delta_u = oblicz_d_u(a, d);
            //1.1
            if (delta_r > 0) {
                p_delta_r = oblicz_p_d_r(delta_r, delta_u);
                Zm.x1r = (-(float)b - p_delta_r) / (2 * a);
                Zm.x2r = (-(float)b + p_delta_r) / (2 * a);
            }
            //1.2
            if (delta_r == 0) {
                Zm.x1r = -(float)b / (2 * a);
            }
            //1.3
            if (delta_r < 0) {
                delta_r = -delta_r;
                p_delta_r = oblicz_p_d_r(delta_r, delta_u);
                Zm.x1r = (float)-b / (2 * a);
                Zm.x1u = (float)-(p_delta_r / (2 * a));
                Zm.x2r = Zm.x1r;
                Zm.x2u = -Zm.x1u;
            }
        }
        //2.
        if (a == 0 && b != 0 && d == 0) {
            Zm.x1r = -((float)c / b);
        }
        //3.
        if (a == 0 && b == 0 && (c != 0 || d != 0)) {
            //System.out.println("Rownanie sprzeczne \n");
        }

        //4.
        if (a == 0 && b == 0 && c == 0 && d == 0) {
            //System.out.println("Rownanie tozsamosciowe \n");
        }
        //5.
        if (a == 0 && b != 0 && d != 0) {
            Zm.x1r = -((float)c / b);
            Zm.x1u = -((float)d / b);
        }
        //6.
        if (a != 0 && d != 0) {
            delta_r = oblicz_d_r(a, b, c);
            delta_u = oblicz_d_u(a, d);
            p_delta_r = oblicz_p_d_r(delta_r, delta_u);
            p_delta_u = oblicz_p_d_u(delta_r, delta_u);
            Zm.x1r = (-b - p_delta_r) / (2 * a);
            Zm.x1u = (-b - p_delta_u) / (2 * a);
            Zm.x2r = (-b - p_delta_r) / (2 * a);
            Zm.x2u = (-b + p_delta_u) / (2 * a);
            Zm.x3r = (-b + p_delta_r) / (2 * a);
            Zm.x3u = (-b + p_delta_u) / (2 * a);
            Zm.x4r = (-b + p_delta_r) / (2 * a);
            Zm.x4u = (-b - p_delta_u) / (2 * a);
        }
    }



    static void dodaj(float delta_r, float delta_u, float x1r, float x1u, float x2r, float x2u, float x3r, float x3u, float x4r, float x4u, float sr, float su) {
        if (delta_u != 0) {
		    Zm.sr = x1r + x2r + x3r + x4r;
            Zm.su = x1u + x2u + x3u + x4u;
        }
        else if (delta_r > 0) {
            Zm.sr = x1r + x2r;
        }
        else if (delta_r < 0) {
            Zm.sr = x1r + x2r;
            Zm.su = x1u + x2u;
        }
    }
    static void odejmij(float delta_r, float delta_u, float x1r, float x1u, float x2r, float x2u, float x3r, float x3u, float x4r, float x4u, float rr, float ru) {
        if (delta_u != 0) {
            Zm.rr = x1r - x2r - x3r - x4r;
            Zm.ru = x1u - x2u - x3u - x4u;
        }
        else if (delta_r > 0) {
            Zm.rr = x1r - x2r;
        }
        else if (delta_r < 0) {
            Zm.rr = x1r - x2r;
            Zm.ru = x1u - x2u;
        }
    }
    static void pomnoz(float delta_r, float delta_u, float x1r, float x1u, float x2r, float x2u, float x3r, float x3u, float x4r, float x4u, float ilr, float ilu) {
        if (delta_u != 0) {
            Zm.ilr = ((x1r * x2r - x1u * x2u) * (x3r * x4r - x3u * x4u)) - ((x1r * x2u + x2r * x1u) * (x3r * x4u + x4r * x3u));
            Zm.ilu = ((x1r * x2r - x1u * x2u) * (x3r * x4u + x4r * x3u)) + ((x1r * x2u + x2r * x1u) * (x3r * x4r - x3u * x4u));
        }
        else if (delta_r > 0) {
            Zm.ilr = x1r * x2r;
        }
        else if (delta_r < 0) {
            Zm.ilr = (x1r * x2r - x1u * x2u);
            Zm.ilu = (x1r * x2u + x2r * x1u);
        }
    }



    static void wyswietl_wynik(int a, int b, int c, int d, float x1r, float x1u, float x2r, float x2u, float x3r, float x3u, float x4r, float x4u, float sr, float su, float rr, float ru, float ilr, float ilu) {
        if (a != 0 && d == 0) {
            float delta_r = oblicz_d_r(a, b, c);
            System.out.println("\n  Delta= " + delta_r);

            //1.1
            if (delta_r > 0) {
                System.out.println("  x1r = " + x1r);
                System.out.println("  x2r = " + x2r);
                System.out.println("\n");
                System.out.println("  sr = " + sr);
                System.out.println("  rr = " + rr);
                System.out.println("  ilr = " + ilr);
            }

            //1.2
            if (delta_r == 0) {
                System.out.println("x1r = " + x1r);
            }

            //1.3
            if (delta_r < 0) {

                System.out.println("  x1r = " + x1r);
                System.out.println("  x1u = " + x1u);
                System.out.println("  x2r = " + x2r);
                System.out.println("  x2u = " + x2u);
                System.out.println("\n");
                System.out.println("  sr = " + sr);
                System.out.println("  su = " + su);
                System.out.println("  rr = " + rr);
                System.out.println("  ru = " + ru);
                System.out.println("  ilr = " + ilr);
                System.out.println("  ilu = " + ilu);
            }

        }
        //2.
        if (a == 0 && b != 0 && d == 0) {
            System.out.println("  x1r = " + x1r);

        }

        //3.
        if (a == 0 && b == 0 && (c != 0 || d != 0)) {
            System.out.println("  Rownanie sprzeczne \n");
        }

        //4.
        if (a == 0 && b == 0 && c == 0 && d == 0) {
            System.out.println("  Rownanie tozsamosciowe \n");
        }

        //5.
        if (a == 0 && b != 0 && d != 0) {
            System.out.println("  x1r = " + x1r);
            System.out.println("  x1u = " + x1u);
        }

        //6.
        if (a != 0 && d != 0) {
            float delta_r = oblicz_d_r(a, b, c);
            float delta_u = oblicz_d_u(a, d);
            System.out.print("  Delta = " + delta_r);
            if (delta_u > 0)
                System.out.print(" + ");
            System.out.println(delta_u + "i");
            System.out.println("  x1r = " + x1r);
            System.out.println("  x1u = " + x1u);
            System.out.println("  x2r = " + x2r);
            System.out.println("  x2u = " + x2u);
            System.out.println("  x3r = " + x3r);
            System.out.println("  x3u = " + x3u);
            System.out.println("  x4r = " + x4r);
            System.out.println("  x4u = " + x4u);
            System.out.println();
            System.out.println("  sr = " + sr);
            System.out.println("  su = " + su);
            System.out.println("  rr = " + rr);
            System.out.println("  ru = " + ru);
            System.out.println("  ilr = " + ilr);
            System.out.println("  ilu = " + ilu);
        }
    }


    public static void main(String[] args) {

       // int a = 0, b = 0, c = 0, d = 0;
       // float delta_r = 0, delta_u = 0, p_delta_r, p_delta_u, x1r, x2r, x3r, x4r, x1u, x2u, x3u, x4u, sr = 0, su = 0, rr = 0, ru = 0, ilr = 0, ilu = 0;


        wprowadz_dane();
        formatuj_rownanie(Zm.a, Zm.b, Zm.c, Zm.d);

        Zm.delta_r = oblicz_d_r(Zm.a, Zm.b, Zm.c);
        Zm.delta_u = oblicz_d_u(Zm.a, Zm.d);

        oblicz_rownanie(Zm.a, Zm.b, Zm.c, Zm.d, Zm.x1r, Zm.x1u, Zm.x2r, Zm.x2u, Zm.x3r, Zm.x3u, Zm.x4r, Zm.x4u);

        dodaj(Zm.delta_r, Zm.delta_u, Zm.x1r, Zm.x1u, Zm.x2r, Zm.x2u, Zm.x3r, Zm.x3u, Zm.x4r, Zm.x4u, Zm.sr, Zm.su);
        odejmij(Zm.delta_r, Zm.delta_u, Zm.x1r, Zm.x1u, Zm.x2r, Zm.x2u, Zm.x3r, Zm.x3u, Zm.x4r, Zm.x4u, Zm.rr, Zm.ru);
        pomnoz(Zm.delta_r, Zm.delta_u, Zm.x1r, Zm.x1u, Zm.x2r, Zm.x2u, Zm.x3r, Zm.x3u, Zm.x4r, Zm.x4u, Zm.ilr, Zm.ilu);

        wyswietl_wynik(Zm.a, Zm.b, Zm.c, Zm.d, Zm.x1r, Zm.x1u, Zm.x2r, Zm.x2u, Zm.x3r, Zm.x3u, Zm.x4r, Zm.x4u, Zm.sr, Zm.su, Zm.rr, Zm.ru, Zm.ilr, Zm.ilu);

    }
}
