/*
Copyright (C) 2011  Kircher Engineering, LLC (http://www.kircherEngineering.com)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

//import org.math.plot.Plot2DPanel;


/**
 * A class that performs the Fast Fourier Transform.
 * @author Kaleb Kircher
 *
 */
public class FFT_zad2_b
{
	/**
	 * Overloaded method to generate signal values.
	 * 
	 * @return a double[] of signal values.
	 */
	public double[] generateSignal()
	{
		double f=100;
		double Fs=8000;
		double o = Math.PI;
		int T=1;
		double poczatek = 0;
		double koniec   = T;
		double krok     = 1/Fs;
		int ilosc_probek = (int)((Math.abs(koniec-poczatek))/krok);
		double wartosci_X[] = new double[(int) ilosc_probek];
		double wartosci_Y[] = new double[(int) ilosc_probek];

		//####### OBLICZANIE WARTOSCI FUNKCJI ########

		// obliczenia, wpisanie do tablic
		double x=poczatek;
		for(int i=0;i<ilosc_probek;i++){
			wartosci_X[i] = x;


			//###################### FUNKCJA #####################

			wartosci_Y[i] = 3 * Math.pow(
					Math.cos(2*Math.PI*f*x+o)*Math.pow(x/2,0.12),7) // x(n)^7
					* Math.sqrt(Math.abs(Math.pow(x,2)/(x+1)));
			//###################### FUNKCJA #####################


			x += krok;
		}

		return wartosci_Y;
	}
//	/**
//	 * Overload method to generate a signal based on a function.
//	 * @param Number of signal points to be generated.
//	 * @return a double[] of signal values.
//	 */
	public double[] generateSignal(int N)
	{
			double[] signal = new double[N];
			for (int i = 0; i < N; i++)
			{
				signal[i] = Math.cos((2 * i * 1 * Math.PI) / N) + 0.5
						* Math.cos(((2 * i * 2 * Math.PI) / N) + Math.PI / 4);
			}
		return signal;
	}

	/**
	 * Main method calculates the coefficients and phase. 
	 * @param args
	 */
	public static void main(String[] args)
	{
		// boot strap 
		FFT_zad2_b calc = new FFT_zad2_b();
		double[] signal = calc.generateSignal();

		long startTime_fft = System.nanoTime();

		// instantiate classes to perform calculations
		CalcReal calcReal = new CalcReal();
		CalcImag calcImag = new CalcImag();
		SumCoefficiants sumC = new SumCoefficiants();

		// obliczanie czasu
		long stopTime_fft = System.nanoTime();
		long duration_fft = stopTime_fft - startTime_fft;



		// size of table
		int N = signal.length;
		// samples per cycle
		int NN = signal.length;
		// harmonics
		int K = 4;

		// initialize arrays
		double[] amplitude = new double[K];
		double[] phase = new double[K];
		double[] cosSignal = new double[N];
		double[] degreesSignal = new double[N];
		double[] IMCSum = new double[K];
		double[] radiansSignal = new double[N];
		double[] RECSum = new double[K];
		double[][] IMC = new double[K][NN];
		double[][] REC = new double[K][NN];

		// generate the radians for the signal
		for (int i = 0; i < N; i++)
		{
			degreesSignal[i] = (360 / (double) N) * i;
			//System.out.println(degreesSignal[i]);
			radiansSignal[i] = degreesSignal[i] * (Math.PI / 180);
		}

		// get the real coefficients
		for (int i = 0; i < K; i++)
		{
			REC[i] = calcReal.calc(radiansSignal, signal, i + 1);
		}

		// sum the real coefficients
		for (int i = 0; i < K; i++)
		{
			RECSum[i] = (sumC.sum(REC[i], (double) NN));
			// System.out.println(RECSum[i]);
		}

		// get the imag coefficients
		for (int i = 0; i < K; i++)
		{
			IMC[i] = calcImag.calc(radiansSignal, signal, i + 1);
		}

		// sum the imag coefficients
		for (int i = 0; i < K; i++)
		{
			IMCSum[i] = (sumC.sum(IMC[i], (double) NN));
			// System.out.println(IMCSum[i]);
		}

		// calculate amplitude (Fourier coefficients)
		// a[i] = 2(abs(RECSum[i]*abs(IMCSum[i])
		for (int i = 0; i < K; i++)
		{
			amplitude[i] = 2 * (Math.sqrt(Math.pow(RECSum[i], 2)
					+ Math.pow(IMCSum[i], 2)));
			// System.out.println(amplitude[i]);
		}

		// calculate phase
		// atan(abs(b/a))
		for (int i = 0; i < K; i++)
		{
			double temp = (Math.sqrt(Math.pow(IMCSum[i], 2)
					/ Math.pow(RECSum[i], 2)));
			phase[i] = Math.atan(temp);
			// System.out.println(phase[i]);
		}
		
//		Plot2DPanel plot = new Plot2DPanel();
//
//		plot.addLinePlot("Signal", new Color(255,68,68), signal);
//		plot.addLinePlot("Harmonic #1", new Color(51,181,229), REC[0]);
//		plot.addLinePlot("Harmonic #2", new Color(153,204,0), REC[1]);
//		plot.addLinePlot("Harmonic #3", new Color(255,187,51), REC[2]);
//		plot.addLinePlot("Harmonic #4", new Color(170,102,204), REC[3]);
//
//		  // define the legend position
//        plot.addLegend("SOUTH");
//
//		// put the PlotPanel in a JFrame like a JPanel
//        JFrame frame = new JFrame("FFT_zad1");
//        frame.setSize(600, 600);
//        frame.setContentPane(plot);
//        frame.setVisible(true);


		// produce output
		for (int i = 0; i < K; i++)
		{
			System.out.println("");
			System.out.println("REC" + (i + 1) + ": " + RECSum[i]);
			System.out.println("IMC" + (i + 1) + ": " + IMCSum[i]);
			System.out.println("Amplitude(K=" + (i + 1) + "): " + amplitude[i]);
			System.out.println("Phase(K=" + (i + 1) + "): " + phase[i]);
			System.out.println("Degrees(K=" + (i + 1) + "): " + phase[i]*(180/Math.PI));
			System.out.println("");
		}
		System.out.println("Czas FFT_zad2_b: " + (double)duration_fft/1000000 + "[ms]");

	}
}
