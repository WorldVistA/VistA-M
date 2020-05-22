IBDEI155 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18344,0)
 ;;=96158^^90^929^2^^^^1
 ;;^UTILITY(U,$J,358.3,18344,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18344,1,2,0)
 ;;=2^96158
 ;;^UTILITY(U,$J,358.3,18344,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Indiv,1st 30 min
 ;;^UTILITY(U,$J,358.3,18345,0)
 ;;=96159^^90^929^3^^^^1
 ;;^UTILITY(U,$J,358.3,18345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18345,1,2,0)
 ;;=2^96159
 ;;^UTILITY(U,$J,358.3,18345,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Indiv,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,18346,0)
 ;;=96167^^90^929^4^^^^1
 ;;^UTILITY(U,$J,358.3,18346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18346,1,2,0)
 ;;=2^96167
 ;;^UTILITY(U,$J,358.3,18346,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,18347,0)
 ;;=96168^^90^929^5^^^^1
 ;;^UTILITY(U,$J,358.3,18347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18347,1,2,0)
 ;;=2^96168
 ;;^UTILITY(U,$J,358.3,18347,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,18348,0)
 ;;=96170^^90^929^6^^^^1
 ;;^UTILITY(U,$J,358.3,18348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18348,1,2,0)
 ;;=2^96170
 ;;^UTILITY(U,$J,358.3,18348,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,18349,0)
 ;;=96171^^90^929^7^^^^1
 ;;^UTILITY(U,$J,358.3,18349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18349,1,2,0)
 ;;=2^96171
 ;;^UTILITY(U,$J,358.3,18349,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,18350,0)
 ;;=99368^^90^930^2^^^^1
 ;;^UTILITY(U,$J,358.3,18350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18350,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,18350,1,3,0)
 ;;=3^Non-Rx Provider Team Conf w/o Pt &/or Family 30+ min
 ;;^UTILITY(U,$J,358.3,18351,0)
 ;;=99366^^90^930^1^^^^1
 ;;^UTILITY(U,$J,358.3,18351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18351,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,18351,1,3,0)
 ;;=3^Non-Rx Provider Team Conf w/ Pt &/or Family 30+ min
 ;;^UTILITY(U,$J,358.3,18352,0)
 ;;=90785^^90^931^1^^^^1
 ;;^UTILITY(U,$J,358.3,18352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18352,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,18352,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,18353,0)
 ;;=H0001^^90^932^1^^^^1
 ;;^UTILITY(U,$J,358.3,18353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18353,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,18353,1,3,0)
 ;;=3^Addictions Assessment,Alcohol &/or Drug
 ;;^UTILITY(U,$J,358.3,18354,0)
 ;;=H0002^^90^932^8^^^^1
 ;;^UTILITY(U,$J,358.3,18354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18354,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,18354,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,18355,0)
 ;;=H0003^^90^932^5^^^^1
 ;;^UTILITY(U,$J,358.3,18355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18355,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,18355,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,18356,0)
 ;;=H0004^^90^932^6^^^^1
 ;;^UTILITY(U,$J,358.3,18356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18356,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,18356,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,18357,0)
 ;;=H0006^^90^932^4^^^^1
 ;;^UTILITY(U,$J,358.3,18357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18357,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,18357,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,18358,0)
 ;;=H0020^^90^932^7^^^^1
