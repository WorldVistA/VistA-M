IBDEI02A ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2516,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,2516,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,2517,0)
 ;;=R10.30^^14^188^12
 ;;^UTILITY(U,$J,358.3,2517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2517,1,3,0)
 ;;=3^Lower Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,2517,1,4,0)
 ;;=4^R10.30
 ;;^UTILITY(U,$J,358.3,2517,2)
 ;;=^5019210
 ;;^UTILITY(U,$J,358.3,2518,0)
 ;;=R10.31^^14^188^21
 ;;^UTILITY(U,$J,358.3,2518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2518,1,3,0)
 ;;=3^Right Lower Quadrant Pain
 ;;^UTILITY(U,$J,358.3,2518,1,4,0)
 ;;=4^R10.31
 ;;^UTILITY(U,$J,358.3,2518,2)
 ;;=^5019211
 ;;^UTILITY(U,$J,358.3,2519,0)
 ;;=R10.32^^14^188^11
 ;;^UTILITY(U,$J,358.3,2519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2519,1,3,0)
 ;;=3^Left Lower Quadrant Pain
 ;;^UTILITY(U,$J,358.3,2519,1,4,0)
 ;;=4^R10.32
 ;;^UTILITY(U,$J,358.3,2519,2)
 ;;=^5019212
 ;;^UTILITY(U,$J,358.3,2520,0)
 ;;=R10.33^^14^188^18
 ;;^UTILITY(U,$J,358.3,2520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2520,1,3,0)
 ;;=3^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,2520,1,4,0)
 ;;=4^R10.33
 ;;^UTILITY(U,$J,358.3,2520,2)
 ;;=^5019213
 ;;^UTILITY(U,$J,358.3,2521,0)
 ;;=R10.84^^14^188^1
 ;;^UTILITY(U,$J,358.3,2521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2521,1,3,0)
 ;;=3^Abdominal Pain,Generalized
 ;;^UTILITY(U,$J,358.3,2521,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,2521,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,2522,0)
 ;;=R10.9^^14^188^2
 ;;^UTILITY(U,$J,358.3,2522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2522,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,2522,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,2522,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,2523,0)
 ;;=R11.2^^14^188^13
 ;;^UTILITY(U,$J,358.3,2523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2523,1,3,0)
 ;;=3^Nausea w/ Vomiting,Unspec
 ;;^UTILITY(U,$J,358.3,2523,1,4,0)
 ;;=4^R11.2
 ;;^UTILITY(U,$J,358.3,2523,2)
 ;;=^5019237
 ;;^UTILITY(U,$J,358.3,2524,0)
 ;;=R15.9^^14^188^6
 ;;^UTILITY(U,$J,358.3,2524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2524,1,3,0)
 ;;=3^Full Incontinence of Feces
 ;;^UTILITY(U,$J,358.3,2524,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,2524,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,2525,0)
 ;;=R20.2^^14^188^16
 ;;^UTILITY(U,$J,358.3,2525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2525,1,3,0)
 ;;=3^Paresthesia of Skin
 ;;^UTILITY(U,$J,358.3,2525,1,4,0)
 ;;=4^R20.2
 ;;^UTILITY(U,$J,358.3,2525,2)
 ;;=^5019280
 ;;^UTILITY(U,$J,358.3,2526,0)
 ;;=R26.89^^14^188^7
 ;;^UTILITY(U,$J,358.3,2526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2526,1,3,0)
 ;;=3^Gait/Mobility Abnormalities
 ;;^UTILITY(U,$J,358.3,2526,1,4,0)
 ;;=4^R26.89
 ;;^UTILITY(U,$J,358.3,2526,2)
 ;;=^5019308
 ;;^UTILITY(U,$J,358.3,2527,0)
 ;;=R42.^^14^188^5
 ;;^UTILITY(U,$J,358.3,2527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2527,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,2527,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,2527,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,2528,0)
 ;;=R45.4^^14^188^9
 ;;^UTILITY(U,$J,358.3,2528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2528,1,3,0)
 ;;=3^Irritability and Anger
 ;;^UTILITY(U,$J,358.3,2528,1,4,0)
 ;;=4^R45.4
 ;;^UTILITY(U,$J,358.3,2528,2)
 ;;=^5019465
 ;;^UTILITY(U,$J,358.3,2529,0)
 ;;=R45.851^^14^188^22
 ;;^UTILITY(U,$J,358.3,2529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2529,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,2529,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,2529,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,2530,0)
 ;;=R51.^^14^188^8
 ;;^UTILITY(U,$J,358.3,2530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2530,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,2530,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,2530,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,2531,0)
 ;;=R52.^^14^188^15
 ;;^UTILITY(U,$J,358.3,2531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2531,1,3,0)
 ;;=3^Pain,Unspec
 ;;^UTILITY(U,$J,358.3,2531,1,4,0)
 ;;=4^R52.
 ;;^UTILITY(U,$J,358.3,2531,2)
 ;;=^5019514
 ;;^UTILITY(U,$J,358.3,2532,0)
 ;;=R53.82^^14^188^4
 ;;^UTILITY(U,$J,358.3,2532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2532,1,3,0)
 ;;=3^Chronic Fatigue,Unspec
 ;;^UTILITY(U,$J,358.3,2532,1,4,0)
 ;;=4^R53.82
 ;;^UTILITY(U,$J,358.3,2532,2)
 ;;=^5019519
 ;;^UTILITY(U,$J,358.3,2533,0)
 ;;=R68.84^^14^188^10
 ;;^UTILITY(U,$J,358.3,2533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2533,1,3,0)
 ;;=3^Jaw Pain
 ;;^UTILITY(U,$J,358.3,2533,1,4,0)
 ;;=4^R68.84
 ;;^UTILITY(U,$J,358.3,2533,2)
 ;;=^5019556
 ;;^UTILITY(U,$J,358.3,2534,0)
 ;;=F10.10^^14^189^2
 ;;^UTILITY(U,$J,358.3,2534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2534,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2534,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,2534,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,2535,0)
 ;;=F10.14^^14^189^1
 ;;^UTILITY(U,$J,358.3,2535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2535,1,3,0)
 ;;=3^Alcohol Abuse w/ Alcohol-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,2535,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,2535,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,2536,0)
 ;;=F10.20^^14^189^7
 ;;^UTILITY(U,$J,358.3,2536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2536,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2536,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,2536,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,2537,0)
 ;;=F10.230^^14^189^5
 ;;^UTILITY(U,$J,358.3,2537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2537,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2537,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,2537,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,2538,0)
 ;;=F10.239^^14^189^6
 ;;^UTILITY(U,$J,358.3,2538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2538,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,2538,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,2538,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,2539,0)
 ;;=F10.24^^14^189^3
 ;;^UTILITY(U,$J,358.3,2539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2539,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,2539,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,2539,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,2540,0)
 ;;=F10.288^^14^189^4
 ;;^UTILITY(U,$J,358.3,2540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2540,1,3,0)
 ;;=3^Alcohol Dependence w/ Other Alcohol-Induced Disorder
 ;;^UTILITY(U,$J,358.3,2540,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,2540,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,2541,0)
 ;;=F10.94^^14^189^8
 ;;^UTILITY(U,$J,358.3,2541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2541,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Alcohol-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,2541,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,2541,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,2542,0)
 ;;=F11.20^^14^189^15
 ;;^UTILITY(U,$J,358.3,2542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2542,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2542,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,2542,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,2543,0)
 ;;=F12.20^^14^189^9
 ;;^UTILITY(U,$J,358.3,2543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2543,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2543,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,2543,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,2544,0)
 ;;=F14.188^^14^189^10
 ;;^UTILITY(U,$J,358.3,2544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2544,1,3,0)
 ;;=3^Cocaine Abuse w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,2544,1,4,0)
 ;;=4^F14.188
 ;;^UTILITY(U,$J,358.3,2544,2)
 ;;=^5003251
 ;;^UTILITY(U,$J,358.3,2545,0)
 ;;=F14.20^^14^189^11
 ;;^UTILITY(U,$J,358.3,2545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2545,1,3,0)
 ;;=3^Cocaine Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2545,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,2545,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,2546,0)
 ;;=F15.10^^14^189^18
 ;;^UTILITY(U,$J,358.3,2546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2546,1,3,0)
 ;;=3^Stimulant Abuse,Uncomplicated,Other
 ;;^UTILITY(U,$J,358.3,2546,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,2546,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,2547,0)
 ;;=F15.20^^14^189^19
 ;;^UTILITY(U,$J,358.3,2547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2547,1,3,0)
 ;;=3^Stimulant Dependence,Uncomplicated,Other
 ;;^UTILITY(U,$J,358.3,2547,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,2547,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,2548,0)
 ;;=F17.210^^14^189^14
 ;;^UTILITY(U,$J,358.3,2548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2548,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2548,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,2548,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,2549,0)
 ;;=F17.211^^14^189^13
 ;;^UTILITY(U,$J,358.3,2549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2549,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,2549,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,2549,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,2550,0)
 ;;=F17.293^^14^189^12
 ;;^UTILITY(U,$J,358.3,2550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2550,1,3,0)
 ;;=3^Nicotine Dependence w/ Withdrawal,Other Tobacco Product
 ;;^UTILITY(U,$J,358.3,2550,1,4,0)
 ;;=4^F17.293
 ;;^UTILITY(U,$J,358.3,2550,2)
 ;;=^5003377
 ;;^UTILITY(U,$J,358.3,2551,0)
 ;;=F19.10^^14^189^16
 ;;^UTILITY(U,$J,358.3,2551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2551,1,3,0)
 ;;=3^Psychoactive Substance Abuse,Uncomplicated,Other
 ;;^UTILITY(U,$J,358.3,2551,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,2551,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,2552,0)
 ;;=F19.20^^14^189^17
 ;;^UTILITY(U,$J,358.3,2552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2552,1,3,0)
 ;;=3^Psychoactive Substance Dependence,Uncomplicated,Other
 ;;^UTILITY(U,$J,358.3,2552,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,2552,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,2553,0)
 ;;=E66.01^^14^190^1
