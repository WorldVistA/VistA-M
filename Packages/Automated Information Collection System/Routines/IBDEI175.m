IBDEI175 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19438,0)
 ;;=96164^^66^868^6^^^^1
 ;;^UTILITY(U,$J,358.3,19438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19438,1,2,0)
 ;;=2^Hlth/Behav Intrvn,Grp,1st 30 min
 ;;^UTILITY(U,$J,358.3,19438,1,3,0)
 ;;=3^96164
 ;;^UTILITY(U,$J,358.3,19439,0)
 ;;=96165^^66^868^7^^^^1
 ;;^UTILITY(U,$J,358.3,19439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19439,1,2,0)
 ;;=2^Hlth/Behav Intrvn,Grp,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,19439,1,3,0)
 ;;=3^96165
 ;;^UTILITY(U,$J,358.3,19440,0)
 ;;=96167^^66^868^2^^^^1
 ;;^UTILITY(U,$J,358.3,19440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19440,1,2,0)
 ;;=2^Hlth/Behav Intrvn,Family w/ Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,19440,1,3,0)
 ;;=3^96167
 ;;^UTILITY(U,$J,358.3,19441,0)
 ;;=96168^^66^868^3^^^^1
 ;;^UTILITY(U,$J,358.3,19441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19441,1,2,0)
 ;;=2^Hlth/Behav Intrvn,Family w/ Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,19441,1,3,0)
 ;;=3^96168
 ;;^UTILITY(U,$J,358.3,19442,0)
 ;;=96170^^66^868^4^^^^1
 ;;^UTILITY(U,$J,358.3,19442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19442,1,2,0)
 ;;=2^Hlth/Behav Intrvn,Family w/o Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,19442,1,3,0)
 ;;=3^96170
 ;;^UTILITY(U,$J,358.3,19443,0)
 ;;=96171^^66^868^5^^^^1
 ;;^UTILITY(U,$J,358.3,19443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19443,1,2,0)
 ;;=2^Hlth/Behav Intrvn,Family w/o Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,19443,1,3,0)
 ;;=3^96171
 ;;^UTILITY(U,$J,358.3,19444,0)
 ;;=S9445^^66^869^3^^^^1
 ;;^UTILITY(U,$J,358.3,19444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19444,1,2,0)
 ;;=2^Pt Education NOC Individual
 ;;^UTILITY(U,$J,358.3,19444,1,3,0)
 ;;=3^S9445
 ;;^UTILITY(U,$J,358.3,19445,0)
 ;;=S9446^^66^869^2^^^^1
 ;;^UTILITY(U,$J,358.3,19445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19445,1,2,0)
 ;;=2^Pt Education NOC Group
 ;;^UTILITY(U,$J,358.3,19445,1,3,0)
 ;;=3^S9446
 ;;^UTILITY(U,$J,358.3,19446,0)
 ;;=T2001^^66^869^1^^^^1
 ;;^UTILITY(U,$J,358.3,19446,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19446,1,2,0)
 ;;=2^N-ET:Patient Attend/Escort
 ;;^UTILITY(U,$J,358.3,19446,1,3,0)
 ;;=3^T2001
 ;;^UTILITY(U,$J,358.3,19447,0)
 ;;=97014^^66^870^2^^^^1
 ;;^UTILITY(U,$J,358.3,19447,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19447,1,2,0)
 ;;=2^TENS,Unattended
 ;;^UTILITY(U,$J,358.3,19447,1,3,0)
 ;;=3^97014
 ;;^UTILITY(U,$J,358.3,19448,0)
 ;;=97032^^66^870^1^^^^1
 ;;^UTILITY(U,$J,358.3,19448,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19448,1,2,0)
 ;;=2^TENS,1+ Areas,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19448,1,3,0)
 ;;=3^97032
 ;;^UTILITY(U,$J,358.3,19449,0)
 ;;=97810^^66^871^1^^^^1
 ;;^UTILITY(U,$J,358.3,19449,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19449,1,2,0)
 ;;=2^Acupuncture w/o Stimul,1st 15 min
 ;;^UTILITY(U,$J,358.3,19449,1,3,0)
 ;;=3^97810
 ;;^UTILITY(U,$J,358.3,19450,0)
 ;;=97811^^66^871^2^^^^1
 ;;^UTILITY(U,$J,358.3,19450,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19450,1,2,0)
 ;;=2^Acupuncture w/o Stimul,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,19450,1,3,0)
 ;;=3^97811
 ;;^UTILITY(U,$J,358.3,19451,0)
 ;;=97813^^66^871^3^^^^1
 ;;^UTILITY(U,$J,358.3,19451,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19451,1,2,0)
 ;;=2^Acupuncture w/ Stimul,1st 15 min
 ;;^UTILITY(U,$J,358.3,19451,1,3,0)
 ;;=3^97813
 ;;^UTILITY(U,$J,358.3,19452,0)
 ;;=97814^^66^871^4^^^^1
 ;;^UTILITY(U,$J,358.3,19452,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19452,1,2,0)
 ;;=2^Acupuncture w/ Stimul,Ea Addl 15 min
