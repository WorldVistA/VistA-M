IBDEI1BT ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23495,1,3,0)
 ;;=3^Behavior Assess,Initial,ea 15min
 ;;^UTILITY(U,$J,358.3,23496,0)
 ;;=96151^^126^1414^2^^^^1
 ;;^UTILITY(U,$J,358.3,23496,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23496,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,23496,1,3,0)
 ;;=3^Behavior Reassessment,ea 15min
 ;;^UTILITY(U,$J,358.3,23497,0)
 ;;=96152^^126^1414^3^^^^1
 ;;^UTILITY(U,$J,358.3,23497,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23497,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,23497,1,3,0)
 ;;=3^Behavior Intervention,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,23498,0)
 ;;=96153^^126^1414^4^^^^1
 ;;^UTILITY(U,$J,358.3,23498,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23498,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,23498,1,3,0)
 ;;=3^Behavior Intervention,Grp,ea 15min
 ;;^UTILITY(U,$J,358.3,23499,0)
 ;;=96154^^126^1414^5^^^^1
 ;;^UTILITY(U,$J,358.3,23499,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23499,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,23499,1,3,0)
 ;;=3^Behav Intervent,Fam w/Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,23500,0)
 ;;=96155^^126^1414^6^^^^1
 ;;^UTILITY(U,$J,358.3,23500,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23500,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,23500,1,3,0)
 ;;=3^Behav Intervent,Fam w/o Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,23501,0)
 ;;=99368^^126^1415^2^^^^1
 ;;^UTILITY(U,$J,358.3,23501,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23501,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,23501,1,3,0)
 ;;=3^Team Conf w/o Pt w/ Non-Phys > 29 min
 ;;^UTILITY(U,$J,358.3,23502,0)
 ;;=99366^^126^1415^1^^^^1
 ;;^UTILITY(U,$J,358.3,23502,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23502,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,23502,1,3,0)
 ;;=3^Team Conf w/ Pt w/ Non-Phys > 29 min
 ;;^UTILITY(U,$J,358.3,23503,0)
 ;;=90785^^126^1416^1^^^^1
 ;;^UTILITY(U,$J,358.3,23503,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23503,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,23503,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,23504,0)
 ;;=H0001^^126^1417^1^^^^1
 ;;^UTILITY(U,$J,358.3,23504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23504,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,23504,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,23505,0)
 ;;=H0002^^126^1417^10^^^^1
 ;;^UTILITY(U,$J,358.3,23505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23505,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,23505,1,3,0)
 ;;=3^Screen for Addictions Admit
 ;;^UTILITY(U,$J,358.3,23506,0)
 ;;=H0003^^126^1417^6^^^^1
 ;;^UTILITY(U,$J,358.3,23506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23506,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,23506,1,3,0)
 ;;=3^Alcohol/Drug Scrn;lab analysis
 ;;^UTILITY(U,$J,358.3,23507,0)
 ;;=H0004^^126^1417^7^^^^1
 ;;^UTILITY(U,$J,358.3,23507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23507,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,23507,1,3,0)
 ;;=3^Individual Counseling per 15 min
 ;;^UTILITY(U,$J,358.3,23508,0)
 ;;=H0005^^126^1417^3^^^^1
 ;;^UTILITY(U,$J,358.3,23508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23508,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,23508,1,3,0)
 ;;=3^Addictions Group
 ;;^UTILITY(U,$J,358.3,23509,0)
 ;;=H0006^^126^1417^5^^^^1
 ;;^UTILITY(U,$J,358.3,23509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23509,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,23509,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,23510,0)
 ;;=H0020^^126^1417^8^^^^1
 ;;^UTILITY(U,$J,358.3,23510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23510,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,23510,1,3,0)
 ;;=3^Methadone Administration
 ;;^UTILITY(U,$J,358.3,23511,0)
 ;;=H0025^^126^1417^2^^^^1
