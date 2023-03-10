IBDEI0N8 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10461,0)
 ;;=T1016^^41^460^1^^^^1
 ;;^UTILITY(U,$J,358.3,10461,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10461,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,10461,1,3,0)
 ;;=3^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,10462,0)
 ;;=H0006^^41^460^2^^^^1
 ;;^UTILITY(U,$J,358.3,10462,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10462,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,10462,1,3,0)
 ;;=3^Case Mgmt w/ Alcohol & Drug Tx Focus
 ;;^UTILITY(U,$J,358.3,10463,0)
 ;;=96156^^41^461^1^^^^1
 ;;^UTILITY(U,$J,358.3,10463,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10463,1,2,0)
 ;;=2^96156
 ;;^UTILITY(U,$J,358.3,10463,1,3,0)
 ;;=3^Hlth/Behav Assess/Re-Assess
 ;;^UTILITY(U,$J,358.3,10464,0)
 ;;=96158^^41^461^8^^^^1
 ;;^UTILITY(U,$J,358.3,10464,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10464,1,2,0)
 ;;=2^96158
 ;;^UTILITY(U,$J,358.3,10464,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Ind,1st 30 min
 ;;^UTILITY(U,$J,358.3,10465,0)
 ;;=96159^^41^461^9^^^^1
 ;;^UTILITY(U,$J,358.3,10465,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10465,1,2,0)
 ;;=2^96159
 ;;^UTILITY(U,$J,358.3,10465,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Ind,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,10466,0)
 ;;=96164^^41^461^6^^^^1
 ;;^UTILITY(U,$J,358.3,10466,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10466,1,2,0)
 ;;=2^96164
 ;;^UTILITY(U,$J,358.3,10466,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,1st 30 min
 ;;^UTILITY(U,$J,358.3,10467,0)
 ;;=96165^^41^461^7^^^^1
 ;;^UTILITY(U,$J,358.3,10467,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10467,1,2,0)
 ;;=2^96165
 ;;^UTILITY(U,$J,358.3,10467,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,10468,0)
 ;;=96167^^41^461^2^^^^1
 ;;^UTILITY(U,$J,358.3,10468,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10468,1,2,0)
 ;;=2^96167
 ;;^UTILITY(U,$J,358.3,10468,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,10469,0)
 ;;=96168^^41^461^3^^^^1
 ;;^UTILITY(U,$J,358.3,10469,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10469,1,2,0)
 ;;=2^96168
 ;;^UTILITY(U,$J,358.3,10469,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,10470,0)
 ;;=96170^^41^461^4^^^^1
 ;;^UTILITY(U,$J,358.3,10470,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10470,1,2,0)
 ;;=2^96170
 ;;^UTILITY(U,$J,358.3,10470,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,10471,0)
 ;;=96171^^41^461^5^^^^1
 ;;^UTILITY(U,$J,358.3,10471,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10471,1,2,0)
 ;;=2^96171
 ;;^UTILITY(U,$J,358.3,10471,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,10472,0)
 ;;=S9445^^41^462^4^^^^1
 ;;^UTILITY(U,$J,358.3,10472,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10472,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,10472,1,3,0)
 ;;=3^Pt Educ,Individual,NOS
 ;;^UTILITY(U,$J,358.3,10473,0)
 ;;=97537^^41^462^3^^^^1
 ;;^UTILITY(U,$J,358.3,10473,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10473,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,10473,1,3,0)
 ;;=3^Community/Work Reintegration Training,Ea 15 min
 ;;^UTILITY(U,$J,358.3,10474,0)
 ;;=3085F^^41^462^5^^^^1
 ;;^UTILITY(U,$J,358.3,10474,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10474,1,2,0)
 ;;=2^3085F
 ;;^UTILITY(U,$J,358.3,10474,1,3,0)
 ;;=3^Suicide Risk Assessment
 ;;^UTILITY(U,$J,358.3,10475,0)
 ;;=99497^^41^462^1^^^^1
 ;;^UTILITY(U,$J,358.3,10475,1,0)
 ;;=^358.31IA^3^2
