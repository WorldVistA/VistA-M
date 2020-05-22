IBDEI1AI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20628,1,2,0)
 ;;=2^96164
 ;;^UTILITY(U,$J,358.3,20628,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,1st 30 min
 ;;^UTILITY(U,$J,358.3,20629,0)
 ;;=96165^^94^1012^7^^^^1
 ;;^UTILITY(U,$J,358.3,20629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20629,1,2,0)
 ;;=2^96165
 ;;^UTILITY(U,$J,358.3,20629,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,20630,0)
 ;;=96167^^94^1012^2^^^^1
 ;;^UTILITY(U,$J,358.3,20630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20630,1,2,0)
 ;;=2^96167
 ;;^UTILITY(U,$J,358.3,20630,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,20631,0)
 ;;=96168^^94^1012^3^^^^1
 ;;^UTILITY(U,$J,358.3,20631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20631,1,2,0)
 ;;=2^96168
 ;;^UTILITY(U,$J,358.3,20631,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,20632,0)
 ;;=96170^^94^1012^4^^^^1
 ;;^UTILITY(U,$J,358.3,20632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20632,1,2,0)
 ;;=2^96170
 ;;^UTILITY(U,$J,358.3,20632,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,20633,0)
 ;;=96171^^94^1012^5^^^^1
 ;;^UTILITY(U,$J,358.3,20633,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20633,1,2,0)
 ;;=2^96171
 ;;^UTILITY(U,$J,358.3,20633,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,20634,0)
 ;;=S9445^^94^1013^4^^^^1
 ;;^UTILITY(U,$J,358.3,20634,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20634,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,20634,1,3,0)
 ;;=3^Pt Educ,Individual,NOS
 ;;^UTILITY(U,$J,358.3,20635,0)
 ;;=97537^^94^1013^3^^^^1
 ;;^UTILITY(U,$J,358.3,20635,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20635,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,20635,1,3,0)
 ;;=3^Community/Work Reintegration Training
 ;;^UTILITY(U,$J,358.3,20636,0)
 ;;=3085F^^94^1013^5^^^^1
 ;;^UTILITY(U,$J,358.3,20636,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20636,1,2,0)
 ;;=2^3085F
 ;;^UTILITY(U,$J,358.3,20636,1,3,0)
 ;;=3^Suicide Risk Assessment
 ;;^UTILITY(U,$J,358.3,20637,0)
 ;;=99497^^94^1013^1^^^^1
 ;;^UTILITY(U,$J,358.3,20637,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20637,1,2,0)
 ;;=2^99497
 ;;^UTILITY(U,$J,358.3,20637,1,3,0)
 ;;=3^Advance Care Planning,1st 30 min
 ;;^UTILITY(U,$J,358.3,20638,0)
 ;;=99498^^94^1013^2^^^^1
 ;;^UTILITY(U,$J,358.3,20638,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20638,1,2,0)
 ;;=2^99498
 ;;^UTILITY(U,$J,358.3,20638,1,3,0)
 ;;=3^Advance Care Planning,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,20639,0)
 ;;=99366^^94^1014^1^^^^1
 ;;^UTILITY(U,$J,358.3,20639,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20639,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,20639,1,3,0)
 ;;=3^Non-Phy Team Conf w/ Pt &/or Fam,30 min+
 ;;^UTILITY(U,$J,358.3,20640,0)
 ;;=90833^^94^1015^1^^^^1
 ;;^UTILITY(U,$J,358.3,20640,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20640,1,2,0)
 ;;=2^90833
 ;;^UTILITY(U,$J,358.3,20640,1,3,0)
 ;;=3^Psychotherapy Services,30 min
 ;;^UTILITY(U,$J,358.3,20641,0)
 ;;=90836^^94^1015^2^^^^1
 ;;^UTILITY(U,$J,358.3,20641,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20641,1,2,0)
 ;;=2^90836
 ;;^UTILITY(U,$J,358.3,20641,1,3,0)
 ;;=3^Psychotherapy Services,45 min
 ;;^UTILITY(U,$J,358.3,20642,0)
 ;;=90838^^94^1015^3^^^^1
 ;;^UTILITY(U,$J,358.3,20642,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20642,1,2,0)
 ;;=2^90838
 ;;^UTILITY(U,$J,358.3,20642,1,3,0)
 ;;=3^Psychotherapy Services,60 min
