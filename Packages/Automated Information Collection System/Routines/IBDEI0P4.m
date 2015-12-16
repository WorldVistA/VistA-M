IBDEI0P4 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11990,2)
 ;;=Secondary Parkinson's^265154
 ;;^UTILITY(U,$J,358.3,11991,0)
 ;;=333.0^^58^706^7.5
 ;;^UTILITY(U,$J,358.3,11991,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11991,1,2,0)
 ;;=2^333.0
 ;;^UTILITY(U,$J,358.3,11991,1,3,0)
 ;;=3^Parkinson Plus Syndrome
 ;;^UTILITY(U,$J,358.3,11991,2)
 ;;=Parkinson Plus Syndrome^87465
 ;;^UTILITY(U,$J,358.3,11992,0)
 ;;=333.94^^58^706^8
 ;;^UTILITY(U,$J,358.3,11992,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11992,1,2,0)
 ;;=2^333.94
 ;;^UTILITY(U,$J,358.3,11992,1,3,0)
 ;;=3^Restless Leg Syndrome
 ;;^UTILITY(U,$J,358.3,11992,2)
 ;;=^105368
 ;;^UTILITY(U,$J,358.3,11993,0)
 ;;=303.90^^58^707^2
 ;;^UTILITY(U,$J,358.3,11993,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11993,1,2,0)
 ;;=2^303.90
 ;;^UTILITY(U,$J,358.3,11993,1,3,0)
 ;;=3^Alcoholism
 ;;^UTILITY(U,$J,358.3,11993,2)
 ;;=Alcoholism^268187
 ;;^UTILITY(U,$J,358.3,11994,0)
 ;;=300.11^^58^707^5
 ;;^UTILITY(U,$J,358.3,11994,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11994,1,2,0)
 ;;=2^300.11
 ;;^UTILITY(U,$J,358.3,11994,1,3,0)
 ;;=3^Conversion Disorder
 ;;^UTILITY(U,$J,358.3,11994,2)
 ;;=Conversion Disorder^28139
 ;;^UTILITY(U,$J,358.3,11995,0)
 ;;=311.^^58^707^6
 ;;^UTILITY(U,$J,358.3,11995,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11995,1,2,0)
 ;;=2^311.
 ;;^UTILITY(U,$J,358.3,11995,1,3,0)
 ;;=3^Depression
 ;;^UTILITY(U,$J,358.3,11995,2)
 ;;=Depression^35603
 ;;^UTILITY(U,$J,358.3,11996,0)
 ;;=977.9^^58^707^7
 ;;^UTILITY(U,$J,358.3,11996,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11996,1,2,0)
 ;;=2^977.9
 ;;^UTILITY(U,$J,358.3,11996,1,3,0)
 ;;=3^Drug Toxicity/Poisoning
 ;;^UTILITY(U,$J,358.3,11996,2)
 ;;=Drug Toxicity/Poisening^276155
 ;;^UTILITY(U,$J,358.3,11997,0)
 ;;=331.4^^58^707^8
 ;;^UTILITY(U,$J,358.3,11997,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11997,1,2,0)
 ;;=2^331.4
 ;;^UTILITY(U,$J,358.3,11997,1,3,0)
 ;;=3^Hydrocephalus
 ;;^UTILITY(U,$J,358.3,11997,2)
 ;;=Hydrocephalus^84947
 ;;^UTILITY(U,$J,358.3,11998,0)
 ;;=458.1^^58^707^12
 ;;^UTILITY(U,$J,358.3,11998,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11998,1,2,0)
 ;;=2^458.1
 ;;^UTILITY(U,$J,358.3,11998,1,3,0)
 ;;=3^Hypotension, Chronic
 ;;^UTILITY(U,$J,358.3,11998,2)
 ;;=Hypotension, Chronic^269847
 ;;^UTILITY(U,$J,358.3,11999,0)
 ;;=306.9^^58^707^26
 ;;^UTILITY(U,$J,358.3,11999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11999,1,2,0)
 ;;=2^306.9
 ;;^UTILITY(U,$J,358.3,11999,1,3,0)
 ;;=3^Psychophysiologic Rxn
 ;;^UTILITY(U,$J,358.3,11999,2)
 ;;=Psychophysiologic Rxn^123979
 ;;^UTILITY(U,$J,358.3,12000,0)
 ;;=135.^^58^707^29
 ;;^UTILITY(U,$J,358.3,12000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12000,1,2,0)
 ;;=2^135.
 ;;^UTILITY(U,$J,358.3,12000,1,3,0)
 ;;=3^Sarcoidosis of Central Nervous System
 ;;^UTILITY(U,$J,358.3,12000,2)
 ;;=Sarciodosis of CNS^107916^357.4
 ;;^UTILITY(U,$J,358.3,12001,0)
 ;;=780.57^^58^707^30
 ;;^UTILITY(U,$J,358.3,12001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12001,1,2,0)
 ;;=2^780.57
 ;;^UTILITY(U,$J,358.3,12001,1,3,0)
 ;;=3^Sleep Apnea
 ;;^UTILITY(U,$J,358.3,12001,2)
 ;;=Sleep Apnea^293933
 ;;^UTILITY(U,$J,358.3,12002,0)
 ;;=307.49^^58^707^33
 ;;^UTILITY(U,$J,358.3,12002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12002,1,2,0)
 ;;=2^307.49
 ;;^UTILITY(U,$J,358.3,12002,1,3,0)
 ;;=3^Sleep Disorder, Nonorganic
 ;;^UTILITY(U,$J,358.3,12002,2)
 ;;=Sleep Disord, Nonorganic^268292
 ;;^UTILITY(U,$J,358.3,12003,0)
 ;;=780.2^^58^707^36
 ;;^UTILITY(U,$J,358.3,12003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12003,1,2,0)
 ;;=2^780.2
 ;;^UTILITY(U,$J,358.3,12003,1,3,0)
 ;;=3^Syncope
