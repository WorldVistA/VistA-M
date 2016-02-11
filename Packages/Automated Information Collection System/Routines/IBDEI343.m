IBDEI343 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52230,1,2,0)
 ;;=2^90885
 ;;^UTILITY(U,$J,358.3,52230,1,3,0)
 ;;=3^Psy Evaluation of Records by Suicide Prevent
 ;;^UTILITY(U,$J,358.3,52231,0)
 ;;=S0257^^236^2580^1^^^^1
 ;;^UTILITY(U,$J,358.3,52231,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52231,1,2,0)
 ;;=2^S0257
 ;;^UTILITY(U,$J,358.3,52231,1,3,0)
 ;;=3^Advance Directive/End of Life Planning
 ;;^UTILITY(U,$J,358.3,52232,0)
 ;;=A0160^^236^2580^4^^^^1
 ;;^UTILITY(U,$J,358.3,52232,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52232,1,2,0)
 ;;=2^A0160
 ;;^UTILITY(U,$J,358.3,52232,1,3,0)
 ;;=3^Non-Emergent Pt Transport by SWS
 ;;^UTILITY(U,$J,358.3,52233,0)
 ;;=90791^^236^2580^7^^^^1
 ;;^UTILITY(U,$J,358.3,52233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52233,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,52233,1,3,0)
 ;;=3^Social Industrial Survey or F/U C&P
 ;;^UTILITY(U,$J,358.3,52234,0)
 ;;=T1016^^236^2581^1^^^^1
 ;;^UTILITY(U,$J,358.3,52234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52234,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,52234,1,3,0)
 ;;=3^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,52235,0)
 ;;=G0155^^236^2582^1^^^^1
 ;;^UTILITY(U,$J,358.3,52235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52235,1,2,0)
 ;;=2^G0155
 ;;^UTILITY(U,$J,358.3,52235,1,3,0)
 ;;=3^Home Visit Ea 15 min
 ;;^UTILITY(U,$J,358.3,52236,0)
 ;;=99510^^236^2582^3^^^^1
 ;;^UTILITY(U,$J,358.3,52236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52236,1,2,0)
 ;;=2^99510
 ;;^UTILITY(U,$J,358.3,52236,1,3,0)
 ;;=3^Home Visit for Indiv/Fam/Marriage Counseling
 ;;^UTILITY(U,$J,358.3,52237,0)
 ;;=99509^^236^2582^2^^^^1
 ;;^UTILITY(U,$J,358.3,52237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52237,1,2,0)
 ;;=2^99509
 ;;^UTILITY(U,$J,358.3,52237,1,3,0)
 ;;=3^Home Visit for ADL
 ;;^UTILITY(U,$J,358.3,52238,0)
 ;;=S9127^^236^2582^5^^^^1
 ;;^UTILITY(U,$J,358.3,52238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52238,1,2,0)
 ;;=2^S9127
 ;;^UTILITY(U,$J,358.3,52238,1,3,0)
 ;;=3^SW Visit in Home,per diem
 ;;^UTILITY(U,$J,358.3,52239,0)
 ;;=99600^^236^2582^4^^^^1
 ;;^UTILITY(U,$J,358.3,52239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52239,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,52239,1,3,0)
 ;;=3^Home Visit for Indivdual Case Management
 ;;^UTILITY(U,$J,358.3,52240,0)
 ;;=T1016^^236^2583^3^^^^1
 ;;^UTILITY(U,$J,358.3,52240,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52240,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,52240,1,3,0)
 ;;=3^Community Residential Care F/U,ea 15 min
 ;;^UTILITY(U,$J,358.3,52241,0)
 ;;=T1016^^236^2583^4^^^^1
 ;;^UTILITY(U,$J,358.3,52241,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52241,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,52241,1,3,0)
 ;;=3^Contract Nursing Home F/U,ea 15 min
 ;;^UTILITY(U,$J,358.3,52242,0)
 ;;=S9453^^236^2584^1^^^^1
 ;;^UTILITY(U,$J,358.3,52242,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52242,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,52242,1,3,0)
 ;;=3^Smoking Cessation Class
 ;;^UTILITY(U,$J,358.3,52243,0)
 ;;=96150^^236^2585^2^^^^1
 ;;^UTILITY(U,$J,358.3,52243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52243,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,52243,1,3,0)
 ;;=3^Assess Hlth/Beh,Init Ea 15min
 ;;^UTILITY(U,$J,358.3,52244,0)
 ;;=96151^^236^2585^3^^^^1
 ;;^UTILITY(U,$J,358.3,52244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52244,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,52244,1,3,0)
 ;;=3^Assess Hlth/Beh,Subs Ea 15min
 ;;^UTILITY(U,$J,358.3,52245,0)
 ;;=96152^^236^2585^7^^^^1
 ;;^UTILITY(U,$J,358.3,52245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52245,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,52245,1,3,0)
 ;;=3^Inter Hlth/Beh,Ind Ea 15min
