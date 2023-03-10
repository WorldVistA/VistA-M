IBDEI14N ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18285,1,2,0)
 ;;=2^36000
 ;;^UTILITY(U,$J,358.3,18285,1,3,0)
 ;;=3^Hep Lock w/o IV Infusion
 ;;^UTILITY(U,$J,358.3,18286,0)
 ;;=82803^^62^812^3^^^^1
 ;;^UTILITY(U,$J,358.3,18286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18286,1,2,0)
 ;;=2^82803
 ;;^UTILITY(U,$J,358.3,18286,1,3,0)
 ;;=3^ABG Analyzed, pO2, pCO2, HCO3
 ;;^UTILITY(U,$J,358.3,18287,0)
 ;;=82805^^62^812^4^^^^1
 ;;^UTILITY(U,$J,358.3,18287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18287,1,2,0)
 ;;=2^82805
 ;;^UTILITY(U,$J,358.3,18287,1,3,0)
 ;;=3^Arterial O2 Saturation
 ;;^UTILITY(U,$J,358.3,18288,0)
 ;;=82375^^62^812^5^^^^1
 ;;^UTILITY(U,$J,358.3,18288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18288,1,2,0)
 ;;=2^82375
 ;;^UTILITY(U,$J,358.3,18288,1,3,0)
 ;;=3^Blood Gas, CO analysis
 ;;^UTILITY(U,$J,358.3,18289,0)
 ;;=36556^^62^812^8^^^^1
 ;;^UTILITY(U,$J,358.3,18289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18289,1,2,0)
 ;;=2^36556
 ;;^UTILITY(U,$J,358.3,18289,1,3,0)
 ;;=3^Insert Central Line,Non-Tunneled
 ;;^UTILITY(U,$J,358.3,18290,0)
 ;;=36558^^62^812^9^^^^1
 ;;^UTILITY(U,$J,358.3,18290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18290,1,2,0)
 ;;=2^36558
 ;;^UTILITY(U,$J,358.3,18290,1,3,0)
 ;;=3^Insert Central Line,Tunneled w/o Port
 ;;^UTILITY(U,$J,358.3,18291,0)
 ;;=93503^^62^812^7^^^^1
 ;;^UTILITY(U,$J,358.3,18291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18291,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,18291,1,3,0)
 ;;=3^Insert Cath,Flow Direct,Monitoring (Swan-Ganz)
 ;;^UTILITY(U,$J,358.3,18292,0)
 ;;=94760^^62^813^2
 ;;^UTILITY(U,$J,358.3,18292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18292,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,18292,1,3,0)
 ;;=3^Ear or Pulse OX, Resting
 ;;^UTILITY(U,$J,358.3,18293,0)
 ;;=94761^^62^813^1
 ;;^UTILITY(U,$J,358.3,18293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18293,1,2,0)
 ;;=2^94761
 ;;^UTILITY(U,$J,358.3,18293,1,3,0)
 ;;=3^Ear or Pulse OX, Exercise
 ;;^UTILITY(U,$J,358.3,18294,0)
 ;;=99183^^62^813^4^^^^1
 ;;^UTILITY(U,$J,358.3,18294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18294,1,2,0)
 ;;=2^99183
 ;;^UTILITY(U,$J,358.3,18294,1,3,0)
 ;;=3^Hyperbaric O2 Chamber,Attend by Prof
 ;;^UTILITY(U,$J,358.3,18295,0)
 ;;=94762^^62^813^3^^^^1
 ;;^UTILITY(U,$J,358.3,18295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18295,1,2,0)
 ;;=2^94762
 ;;^UTILITY(U,$J,358.3,18295,1,3,0)
 ;;=3^Ear or Pulse OX,Cont Overnight Monitoring
 ;;^UTILITY(U,$J,358.3,18296,0)
 ;;=94010^^62^814^11
 ;;^UTILITY(U,$J,358.3,18296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18296,1,2,0)
 ;;=2^94010
 ;;^UTILITY(U,$J,358.3,18296,1,3,0)
 ;;=3^Spirometry/Forced Vital Capacity
 ;;^UTILITY(U,$J,358.3,18297,0)
 ;;=94060^^62^814^10
 ;;^UTILITY(U,$J,358.3,18297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18297,1,2,0)
 ;;=2^94060
 ;;^UTILITY(U,$J,358.3,18297,1,3,0)
 ;;=3^Spirometry, pre and post bronchodilator
 ;;^UTILITY(U,$J,358.3,18298,0)
 ;;=94375^^62^814^4^^^^1
 ;;^UTILITY(U,$J,358.3,18298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18298,1,2,0)
 ;;=2^94375
 ;;^UTILITY(U,$J,358.3,18298,1,3,0)
 ;;=3^Flow Volume Loop (included w/94010)
 ;;^UTILITY(U,$J,358.3,18299,0)
 ;;=94070^^62^814^9^^^^1
 ;;^UTILITY(U,$J,358.3,18299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18299,1,2,0)
 ;;=2^94070
 ;;^UTILITY(U,$J,358.3,18299,1,3,0)
 ;;=3^Prolong Eval of Bronchospasm/Methacholine
 ;;^UTILITY(U,$J,358.3,18300,0)
 ;;=94200^^62^814^7^^^^1
