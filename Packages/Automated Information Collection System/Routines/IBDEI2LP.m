IBDEI2LP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41542,1,2,0)
 ;;=2^Trigger Point Inj,3+ Muscles
 ;;^UTILITY(U,$J,358.3,41542,1,3,0)
 ;;=3^20553
 ;;^UTILITY(U,$J,358.3,41543,0)
 ;;=63650^^154^2057^10^^^^1
 ;;^UTILITY(U,$J,358.3,41543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41543,1,2,0)
 ;;=2^SC Stimulator Trial
 ;;^UTILITY(U,$J,358.3,41543,1,3,0)
 ;;=3^63650
 ;;^UTILITY(U,$J,358.3,41544,0)
 ;;=63685^^154^2057^9^^^^1
 ;;^UTILITY(U,$J,358.3,41544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41544,1,2,0)
 ;;=2^SC Stimulator Pulse Generator Implant
 ;;^UTILITY(U,$J,358.3,41544,1,3,0)
 ;;=3^63685
 ;;^UTILITY(U,$J,358.3,41545,0)
 ;;=63661^^154^2057^8^^^^1
 ;;^UTILITY(U,$J,358.3,41545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41545,1,2,0)
 ;;=2^SC Stimulator Lead Removal
 ;;^UTILITY(U,$J,358.3,41545,1,3,0)
 ;;=3^63661
 ;;^UTILITY(U,$J,358.3,41546,0)
 ;;=95970^^154^2057^6^^^^1
 ;;^UTILITY(U,$J,358.3,41546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41546,1,2,0)
 ;;=2^Analyze Neurostim w/o Reprogramming
 ;;^UTILITY(U,$J,358.3,41546,1,3,0)
 ;;=3^95970
 ;;^UTILITY(U,$J,358.3,41547,0)
 ;;=95971^^154^2057^7^^^^1
 ;;^UTILITY(U,$J,358.3,41547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41547,1,2,0)
 ;;=2^Analyze Simple Neurostim w/ Intraop/Subsq Programming
 ;;^UTILITY(U,$J,358.3,41547,1,3,0)
 ;;=3^95971
 ;;^UTILITY(U,$J,358.3,41548,0)
 ;;=95972^^154^2057^4^^^^1
 ;;^UTILITY(U,$J,358.3,41548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41548,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Intraop/Subsq Program
 ;;^UTILITY(U,$J,358.3,41548,1,3,0)
 ;;=3^95972
 ;;^UTILITY(U,$J,358.3,41549,0)
 ;;=95976^^154^2057^5^^^^1
 ;;^UTILITY(U,$J,358.3,41549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41549,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Simple CN Pulse Gen
 ;;^UTILITY(U,$J,358.3,41549,1,3,0)
 ;;=3^95976
 ;;^UTILITY(U,$J,358.3,41550,0)
 ;;=95977^^154^2057^3^^^^1
 ;;^UTILITY(U,$J,358.3,41550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41550,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Complex CN Pulse Gen
 ;;^UTILITY(U,$J,358.3,41550,1,3,0)
 ;;=3^95977
 ;;^UTILITY(U,$J,358.3,41551,0)
 ;;=95983^^154^2057^1^^^^1
 ;;^UTILITY(U,$J,358.3,41551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41551,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Brain Neurostim,1st 15min
 ;;^UTILITY(U,$J,358.3,41551,1,3,0)
 ;;=3^95983
 ;;^UTILITY(U,$J,358.3,41552,0)
 ;;=95984^^154^2057^2^^^^1
 ;;^UTILITY(U,$J,358.3,41552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41552,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Brain Neurostim,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,41552,1,3,0)
 ;;=3^95984
 ;;^UTILITY(U,$J,358.3,41553,0)
 ;;=97151^^154^2058^1^^^^1
 ;;^UTILITY(U,$J,358.3,41553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41553,1,2,0)
 ;;=2^Behavioral Id Assess by MD/QHP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,41553,1,3,0)
 ;;=3^97151
 ;;^UTILITY(U,$J,358.3,41554,0)
 ;;=97152^^154^2058^2^^^^1
 ;;^UTILITY(U,$J,358.3,41554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41554,1,2,0)
 ;;=2^Behavioral Id Assess by Tech,Ea 15 min
 ;;^UTILITY(U,$J,358.3,41554,1,3,0)
 ;;=3^97152
 ;;^UTILITY(U,$J,358.3,41555,0)
 ;;=0362T^^154^2058^3^^^^1
 ;;^UTILITY(U,$J,358.3,41555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41555,1,2,0)
 ;;=2^Behavioral Id Supporting Assess,Ea 15 min
 ;;^UTILITY(U,$J,358.3,41555,1,3,0)
 ;;=3^0362T
 ;;^UTILITY(U,$J,358.3,41556,0)
 ;;=97153^^154^2059^2^^^^1
 ;;^UTILITY(U,$J,358.3,41556,1,0)
 ;;=^358.31IA^3^2
