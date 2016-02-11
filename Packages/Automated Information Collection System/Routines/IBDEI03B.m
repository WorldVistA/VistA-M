IBDEI03B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,809,2)
 ;;=^5063605
 ;;^UTILITY(U,$J,358.3,810,0)
 ;;=Z91.018^^9^88^30
 ;;^UTILITY(U,$J,358.3,810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,810,1,3,0)
 ;;=3^Allergy to Foods NEC
 ;;^UTILITY(U,$J,358.3,810,1,4,0)
 ;;=4^Z91.018
 ;;^UTILITY(U,$J,358.3,810,2)
 ;;=^5063603
 ;;^UTILITY(U,$J,358.3,811,0)
 ;;=Z91.038^^9^88^31
 ;;^UTILITY(U,$J,358.3,811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,811,1,3,0)
 ;;=3^Allergy to Insects NEC
 ;;^UTILITY(U,$J,358.3,811,1,4,0)
 ;;=4^Z91.038
 ;;^UTILITY(U,$J,358.3,811,2)
 ;;=^5063606
 ;;^UTILITY(U,$J,358.3,812,0)
 ;;=D83.9^^9^89^1
 ;;^UTILITY(U,$J,358.3,812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,812,1,3,0)
 ;;=3^Common Variable Immunodeficiency,Unspec
 ;;^UTILITY(U,$J,358.3,812,1,4,0)
 ;;=4^D83.9
 ;;^UTILITY(U,$J,358.3,812,2)
 ;;=^5002437
 ;;^UTILITY(U,$J,358.3,813,0)
 ;;=D89.9^^9^89^2
 ;;^UTILITY(U,$J,358.3,813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,813,1,3,0)
 ;;=3^Disorder Involving the Immune Mechanism,Unspec
 ;;^UTILITY(U,$J,358.3,813,1,4,0)
 ;;=4^D89.9
 ;;^UTILITY(U,$J,358.3,813,2)
 ;;=^5002459
 ;;^UTILITY(U,$J,358.3,814,0)
 ;;=D80.1^^9^89^3
 ;;^UTILITY(U,$J,358.3,814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,814,1,3,0)
 ;;=3^Nonfamilial Hypogammaglobulinemia
 ;;^UTILITY(U,$J,358.3,814,1,4,0)
 ;;=4^D80.1
 ;;^UTILITY(U,$J,358.3,814,2)
 ;;=^5002406
 ;;^UTILITY(U,$J,358.3,815,0)
 ;;=D84.8^^9^89^4
 ;;^UTILITY(U,$J,358.3,815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,815,1,3,0)
 ;;=3^Other Spec Immunodeficiencies
 ;;^UTILITY(U,$J,358.3,815,1,4,0)
 ;;=4^D84.8
 ;;^UTILITY(U,$J,358.3,815,2)
 ;;=^5002440
 ;;^UTILITY(U,$J,358.3,816,0)
 ;;=Z01.82^^9^90^1
 ;;^UTILITY(U,$J,358.3,816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,816,1,3,0)
 ;;=3^Encounter for Allergy Testing
 ;;^UTILITY(U,$J,358.3,816,1,4,0)
 ;;=4^Z01.82
 ;;^UTILITY(U,$J,358.3,816,2)
 ;;=^5062629
 ;;^UTILITY(U,$J,358.3,817,0)
 ;;=99212^^10^91^2
 ;;^UTILITY(U,$J,358.3,817,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,817,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,817,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,818,0)
 ;;=99213^^10^91^3
 ;;^UTILITY(U,$J,358.3,818,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,818,1,1,0)
 ;;=1^Detailed Visit
 ;;^UTILITY(U,$J,358.3,818,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,819,0)
 ;;=99214^^10^91^4
 ;;^UTILITY(U,$J,358.3,819,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,819,1,1,0)
 ;;=1^Comprehensive,Mod Complexity
 ;;^UTILITY(U,$J,358.3,819,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,820,0)
 ;;=99211^^10^91^1
 ;;^UTILITY(U,$J,358.3,820,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,820,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,820,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,821,0)
 ;;=99242^^10^92^1
 ;;^UTILITY(U,$J,358.3,821,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,821,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,821,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,822,0)
 ;;=99243^^10^92^2
 ;;^UTILITY(U,$J,358.3,822,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,822,1,1,0)
 ;;=1^Detailed Visit
 ;;^UTILITY(U,$J,358.3,822,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,823,0)
 ;;=99244^^10^92^3
 ;;^UTILITY(U,$J,358.3,823,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,823,1,1,0)
 ;;=1^Comprehensive,Mod Complexity
 ;;^UTILITY(U,$J,358.3,823,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,824,0)
 ;;=99024^^10^93^1
 ;;^UTILITY(U,$J,358.3,824,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,824,1,1,0)
 ;;=1^Post Op visit in Global
 ;;^UTILITY(U,$J,358.3,824,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,825,0)
 ;;=64415^^11^94^4^^^^1
